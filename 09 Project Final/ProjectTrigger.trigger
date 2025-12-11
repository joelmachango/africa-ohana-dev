trigger ProjectTrigger on Project__c (before insert, after insert) { 
    switch on Trigger.OperationType {
        when BEFORE_INSERT {
             ProjectTriggerHandler.handleBeforeInsert(Trigger.new);           
        }
        
        when AFTER_INSERT {
            ProjectTriggerHandler.handleAfterInsert(Trigger.new);            
        }
    }
}