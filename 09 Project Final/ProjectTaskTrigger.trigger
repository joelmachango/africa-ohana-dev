trigger ProjectTaskTrigger on Project_Task__c (before insert, before update) {    
    switch on Trigger.OperationType {
        when BEFORE_INSERT {
             ProjectTaskTriggerHandler.handleBeforeInsert(Trigger.new);
        }
        
        when BEFORE_UPDATE {
            ProjectTaskTriggerHandler.handleBeforeUpdate(Trigger.new,Trigger.oldMap);           
        }
    }
}