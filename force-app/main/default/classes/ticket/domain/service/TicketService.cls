public class TicketService {
    private ITicketRepository repo;

    public TicketService(ITicketRepository repository) {
        this.repo = repository;
    }

    public void assignTicket(Id ticketId, Id newOwnerId) {
        Ticket t = repo.findById(ticketId);
        t.assignedTo = newOwnerId;
        repo.save(t);
    }

    public void updateStatus(Id ticketId, String newStatus) {
        Ticket t = repo.findById(ticketId);
        t.status = newStatus;
        repo.save(t);
    }

    public void deleteTicket(Id ticketId) {
        repo.deleteById(ticketId);
    }
}
