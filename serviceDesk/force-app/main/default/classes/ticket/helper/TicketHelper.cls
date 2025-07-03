public with sharing class TicketHelper {
    public static void beforeInsert(List<Ticket__c> newTickets) {
        for (Ticket__c t : newTickets) {
            if (String.isBlank(t.Status__c)) {
                t.Status__c = 'Open';
            }
        }
    }

    public static void beforeUpdate(List<Ticket__c> newTickets, List<Ticket__c> oldTickets, 
                                    Map<Id, Ticket__c> newMap, Map<Id, Ticket__c> oldMap) {
       for (Integer i = 0; i < newTickets.size(); i++) {
            Ticket__c oldT = oldTickets[i];
            Ticket__c newT = newTickets[i];
            if (oldT.Status__c != newT.Status__c) {
                
                System.debug('Status changed from ' + oldT.Status__c + ' to ' + newT.Status__c);
            }
        }
    }

    public static void afterInsert(List<Ticket__c> newTickets) {
        for (Ticket__c t : newTickets) {
            System.debug('New ticket created with ID: ' + t.Id);
        }
    }

    public static void afterUpdate(List<Ticket__c> newTickets, List<Ticket__c> oldTickets,
                                    Map<Id, Ticket__c> newMap, Map<Id, Ticket__c> oldMap) {
        for (Ticket__c ticket : newTickets) {
            Ticket__c oldTicket = oldMap.get(ticket.Id);
            if (oldTicket != null && ticket.AssignedTo__c != oldTicket.AssignedTo__c) {
                System.debug('Ticket assigned to ' + ticket.AssignedTo__c);
            }
        }
    }
}