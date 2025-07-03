trigger TicketTrigger on Ticket__c (before insert, after insert, before update, after update) {
    if (!TicketTriggerHandler.isTriggerEnabled()) {
        return;
    }

    TicketTriggerHandler handler = new TicketTriggerHandler(
        Trigger.new, Trigger.old, Trigger.newMap, Trigger.oldMap
    );

    switch on Trigger.operationType {
        when BEFORE_INSERT {
            handler.handleBeforeInsert();
        }
        when AFTER_INSERT {
            handler.handleAfterInsert();
        }
        when BEFORE_UPDATE {
            handler.handleBeforeUpdate();
        }
        when AFTER_UPDATE {
            handler.handleAfterUpdate();
        }
    }
}
