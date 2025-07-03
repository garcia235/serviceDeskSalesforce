public with sharing class CreateTicketController {
    @AuraEnabled
    public static void createTicket(String title, String description, String priority, Id assignedTo) {
        ITicketRepository repo = new TicketRepository();
        CreateTicketUseCase useCase = new CreateTicketUseCase(repo);
        useCase.execute(title, description, priority, assignedTo);
    }
}
