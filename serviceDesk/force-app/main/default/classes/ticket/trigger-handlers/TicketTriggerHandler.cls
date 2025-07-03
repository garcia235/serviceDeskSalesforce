public with sharing class TicketTriggerHandler {

    public static Boolean triggerEnabled;
    private static Boolean isExecuting;


    static{
        triggerEnabled = true;
        isExecuting = false;
    }

    public static Boolean isTriggerEnabled() {
        return triggerEnabled;
    }

    public static void disableTrigger() {
        triggerEnabled = false;
    }

    public static void enableTrigger() {
        triggerEnabled = true;
    }

    public static Boolean start() {
        if (isExecuting) {
            return false;
        }
        isExecuting = true;
        return true;
    }

    public static void stop() {
        isExecuting = false;
    }

    List<Ticket__c> newTickets;
    List<Ticket__c> oldTickets;
    Map<Id, Ticket__c> newMap;
    Map<Id, Ticket__c> oldMap;

    public TicketTriggerHandler(List<Ticket__c> newTickets, List<Ticket__c> oldTickets, 
                                Map<Id, Ticket__c> newMap, Map<Id, Ticket__c> oldMap) {
        this.newTickets = newTickets;
        this.oldTickets = oldTickets;
        this.newMap = newMap;
        this.oldMap = oldMap;
    }


    public void handleBeforeInsert() {
        TicketHelper.beforeInsert(newTickets);
    }

    public void handleBeforeUpdate() {
        TicketHelper.beforeUpdate(newTickets, oldTickets, newMap, oldMap);
    }

    public void handleAfterInsert() {
        TicketHelper.afterInsert(newTickets);
    }

    public void handleAfterUpdate() {
        TicketHelper.afterUpdate(newTickets, oldTickets, newMap, oldMap);
    }
}