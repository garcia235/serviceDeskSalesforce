# 🛠️ Salesforce Ticket Management System (ServiceDesk App)

> Projeto completo de gerenciamento de chamados desenvolvido na plataforma Salesforce, com foco em Clean Architecture, SOLID e boas práticas de engenharia de software.

---

## 📌 Visão Geral

Este projeto é um sistema de abertura, visualização e acompanhamento de chamados internos (tickets), com base em **Salesforce Apex**, **LWC**, **Triggers** e **RESTful Principles**. Ele foi estruturado para servir como referência de arquitetura limpa e escalável dentro da plataforma Salesforce.

---

## 🧱 Tecnologias Utilizadas

| Camada          | Tecnologias                     |
|----------------|----------------------------------|
| Plataforma      | Salesforce Platform, Lightning  |
| Backend         | Apex (Classes, Interfaces, Triggers) |
| Frontend        | LWC (Lightning Web Components)  |
| Integração      | Lightning Message Service (LMS) |
| Padrões         | Clean Architecture, SOLID, DDD  |
| Testes          | Apex Unit Tests                 |

---

## 📐 Arquitetura e Estrutura do Projeto

A estrutura segue os princípios da **Clean Architecture**, dividida em camadas bem definidas:

ticket/
├── application/
│ ├── commands/ ← DTOs e estruturas de entrada
│ └── usecases/ ← Regras de uso e coordenação
├── domain/
│ ├── model/ ← Entidades (Ex: Ticket.cls)
│ ├── interfaces/ ← Contratos como ITicketRepository
│ └── service/ ← Lógica de domínio (TicketService)
├── infra/
│ └── repository/ ← Implementações de persistência (SOQL)
├── trigger-handlers/ ← Orquestradores de trigger
└── helper/ ← Validações e pós-processamento
|
utils/
|--- TriggerHandler

---

## 🔁 Funcionalidades

✅ Criar chamado com título, descrição, prioridade e responsável  
✅ Listar todos os chamados com filtros por status e prioridade  
✅ Atualização automática da listagem ao criar um novo chamado  
✅ Trigger handler desacoplado com controle de execução  
✅ Lookup dinâmico de usuários ao criar um chamado  
✅ Comunicação entre componentes via Lightning Message Service (LMS)  

---

## 📊 Objeto Customizado

### `Ticket__c`

| Campo               | Tipo         | Descrição                      |
|---------------------|--------------|--------------------------------|
| `Title__c`          | Text         | Título do chamado              |
| `Description__c`    | Long Text    | Descrição detalhada            |
| `Priority__c`       | Picklist     | Prioridade: Low, Medium, High  |
| `Status__c`         | Picklist     | Status: Open, In Progress...   |
| `AssignedTo__c`     | Lookup(User) | Responsável pelo chamado       |

---

## 🧩 LWC Components

### 📂 `ticketForm`
Formulário de criação de chamados com lookup dinâmico de usuários e integração com backend via Apex (`CreateTicketUseCase`).

### 📂 `ticketList`
Tabela com todos os chamados filtráveis por status e prioridade. Atualiza automaticamente usando **LMS** quando um novo ticket é criado.

### 📂 `lookupUser`
Componente de busca para lookup de usuários via nome, utilizando `UserLookupController` + Apex.

---

## 📡 Integração entre Componentes (LMS)

Usamos o **Lightning Message Service (LMS)** com o canal `ticketMessageChannel` para comunicar eventos entre `ticketForm` → `ticketList`.

- Ao criar um ticket, o `ticketForm` publica `event: 'created'`
- O `ticketList` escuta e atualiza os dados em tempo real

---

## ✅ Como Executar

1. Clone o repositório para seu projeto DX
2. Execute `sfdx force:source:push` para subir os metadados
3. Adicione os componentes `ticketForm` e `ticketList` em uma Lightning App Page
4. Atribua permissões necessárias para `Ticket__c` e `User`
5. Teste criando e visualizando chamados no app

---

## 🧪 Testes

As classes de domínio e repositório têm testes unitários com foco em:

- Cobertura de lógica do `TicketService` e `CreateTicketUseCase`
- Validação de regras de negócio (status, responsáveis)
- Comportamento das triggers usando `TriggerHandler`

---

## 🧠 Padrões Aplicados

| Conceito            | Onde foi aplicado                              |
|---------------------|-------------------------------------------------|
| **SOLID**           | `TicketService`, `ITicketRepository`            |
| **Service Layer**   | `TicketService` centraliza regras               |
| **Repository**      | `TicketRepository` isola o SOQL                 |
| **Command**         | `CreateTicketCommand` + UseCase                 |
| **Trigger Pattern** | `TriggerHandler` para controle de execução      |
| **LMS**             | Comunicação entre `ticketForm` e `ticketList`   |

---

## 💡 Futuras Melhorias

- Implementar edição e reatribuição de chamados
- Adicionar histórico de movimentações (log)
- Controle de permissões (ex: só quem criou pode editar)
- Exportação em PDF/Excel dos tickets

---

## 👤 Autor

**Arthur Garcia**  
Salesforce Developer | Java Enthusiast | Clean Code Advocate  
📧 arthurgf.dev@gmail.com | 💼 [LinkedIn](https://www.linkedin.com/in/arthur-garcia-88770728a/)