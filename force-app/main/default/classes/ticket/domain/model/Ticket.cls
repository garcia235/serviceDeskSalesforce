public class Ticket {
    public Id id;
    public String title;
    public String description;
    public String priority;
    public String status;
    public Id createdBy;
    public Id assignedTo;
    public Datetime createdDate;

    public Ticket(Id id, String title, String description, String priority, String status, Id createdBy, Id assignedTo, Datetime createdDate) {
        this.id = id;
        this.title = title;
        this.description = description;
        this.priority = priority;
        this.status = status;
        this.createdBy = createdBy;
        this.assignedTo = assignedTo;
        this.createdDate = createdDate;
    }
}