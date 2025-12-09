// Not Best Practice
trigger ProjectTrigger on Project__c (before insert, after insert) {
    if(Trigger.isBefore){
        
    } else if (Trigger.isAfter){
        if(Trigger.isInsert){
            List<Project_Task__c> tasksToCreate = new List<Project_Task__c>();
            
            for(Project__c projObj: Trigger.new){
                // For every new Project__c record, automatically create one Project_Task__c child record
                Project_Task__c koTask  = new Project_Task__c();
                koTask.Name__c = 'Kickoff Task';
                koTask.Project__c = projObj.Id;
                koTask.Priority__c = 'Medium';
                koTask.Status__c = 'Not Started';
                
                // Due date = Start date + 2 days
                if (projObj.Start_Date__c != null){
                    koTask.Due_Date__c = projObj.Start_Date__c + 2;  
                }   
                
                tasksToCreate.add(koTask);
            }
            
            insert tasksToCreate;
        }
    }
}