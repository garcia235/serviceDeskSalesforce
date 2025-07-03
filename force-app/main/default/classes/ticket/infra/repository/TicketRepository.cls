public class TicketRepository implements ITicketRepository {
    public Ticket findById(Id ticketId) {
        Ticket__c t = [SELECT Id, Title__c, Description__c, Priority__c, Status__c, CreatedById, AssignedTo__c, CreatedDate FROM Ticket__c WHERE Id = :ticketId LIMIT 1];

        return new Ticket(
            t.Id, t.Title__c, t.Description__c, t.Priority__c, t.Status__c, t.CreatedById, t.AssignedTo__c, t.CreatedDate
        );
    }

    public List<Ticket> findAll() {
        List<Ticket> results = new List<Ticket>();
        for (Ticket__c t : [SELECT Id, Title__c, Description__c, Priority__c, Status__c, CreatedById, AssignedTo__c, CreatedDate FROM Ticket__c]) {
            results.add(new Ticket(t.Id, t.Title__c, t.Description__c, t.Priority__c, t.Status__c, t.CreatedById, t.AssignedTo__c, t.CreatedDate));
        }
        return results;
    }

    public void save(Ticket ticket) {
        Ticket__c t = new Ticket__c(
            Id = ticket.id,
            Name = ticket.title,
            Title__c = ticket.title,
            Description__c = ticket.description,
            Priority__c = ticket.priority,
            Status__c = ticket.status,
            AssignedTo__c = ticket.assignedTo
        );
        upsert t;
    }

    public void deleteById(Id ticketId) {
        delete [SELECT Id FROM Ticket__c WHERE Id = :ticketId];
    }
}
