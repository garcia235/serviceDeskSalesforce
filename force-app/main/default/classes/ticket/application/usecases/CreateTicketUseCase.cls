public class CreateTicketUseCase {
    private ITicketRepository repo;

    public CreateTicketUseCase(ITicketRepository repository) {
        this.repo = repository;
    }

    public void execute(String title, String description, String priority, Id assignedTo) {
        Ticket t = new Ticket(
            null,
            title,
            description,
            priority,
            'Open',
            UserInfo.getUserId(),
            assignedTo,
            Datetime.now()
        );
        repo.save(t);
    }
}
