public interface ITicketRepository {
    Ticket findById(Id ticketId);
    List<Ticket> findAll();
    void save(Ticket ticket);
    void deleteById(Id ticketId);
}