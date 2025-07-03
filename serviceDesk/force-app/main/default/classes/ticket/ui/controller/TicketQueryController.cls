public with sharing class TicketQueryController {
    @AuraEnabled(cacheable=true)
    public static List<Ticket__c> getTickets(String statusFilter, String priorityFilter) {
        String query = 'SELECT Id, Title__c, Priority__c, Status__c, AssignedTo__c, AssignedTo__r.Name, CreatedDate FROM Ticket__c WHERE CreatedDate != NULL';

        if (!String.isBlank(statusFilter)) {
            query += ' AND Status__c = :statusFilter';
        }
        if (!String.isBlank(priorityFilter)) {
            query += ' AND Priority__c = :priorityFilter';
        }

        query += ' ORDER BY CreatedDate DESC';

        return Database.query(query);
    }
}
