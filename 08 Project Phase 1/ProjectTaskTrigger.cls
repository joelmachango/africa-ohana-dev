// https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_triggers_context_variables.htm
// Not Best Practice
trigger ProjectTaskTrigger on Project_Task__c (before insert, before update) {
    if(Trigger.isBefore){
        if(Trigger.isInsert){
            // BEFORE INSERT
            for(Project_Task__c task: Trigger.new) {
                // Ensures Due_Date__c is in the future 
                // Block the action if the date is Today or in the past
                if(task.Due_Date__c != null && task.Due_Date__c <= Date.today()){
                    task.addError('The Due Date must be in the future.');
                }
                
                // Prevent setting isCompleted__c = true when inserting new Task 
                if(task.isCompleted__c == true) {
                    task.addError('A New Task cannot be Marked as Completed.');
                }
            }            
        } else if (Trigger.isUpdate){
            // BEFORE UPDATE
            Map<Id, Project_Task__c> oldMapObj = Trigger.oldMap;
            
            for(Project_Task__c task: Trigger.new){
                Project_Task__c oldRecord = oldMapObj.get(task.id);
                // Ensures Due_Date__c is in the future 
                // Block the action if the date is Today or in the past
                if(task.Due_Date__c != null && task.Due_Date__c <= Date.today()){
                    task.addError('The Due Date must be in the future.');
                }
                // Automatically sets Status__c = 'Completed' if isCompleted__c is set to true during update
                if(task.isCompleted__c == true && oldRecord.isCompleted__c == false){
                    task.Status__c = 'Completed';                    
                }
                // Prevent lowering priority: High → Medium/Low
                if(oldRecord.Priority__c == 'High' && task.Priority__c != 'High'){
                    task.addError('Priority cannot be lowered from High.');
                }
            }            
        }               
    } else if (Trigger.isAfter){}
}

/**
trigger ProjectTaskTrigger on Project_Task__c (before insert) {
    switch on Trigger.OperationType {
        when BEFORE_INSERT {
            
        }
        
        when BEFORE_UPDATE {
            
        }
    }
}**/