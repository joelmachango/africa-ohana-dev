trigger ProjectTrigger on Project__c (before insert, after insert) {
    if(Trigger.isBefore){
        if(Trigger.isInsert) {
            // BEFORE INSERT 
            Date today = Date.today();

            // No Start date
            for (Project__c project : Trigger.new) {
                if (project.Start_Date__c == null) {
                    project.Start_Date__c = today;
                }
            }
        }
        
    } else if (Trigger.isAfter){
        if(Trigger.isInsert){
            // AFTER INSERT
            List<Project_Task__c> tasksToCreate = new List<Project_Task__c>();
            
            for(Project__c project: Trigger.new){
                // For every new Project__c record, automatically create one Project_Task__c child record
                Project_Task__c task  = new Project_Task__c();
                task.Name__c = 'Kickoff Task';
                task.Project__c = project.Id;
                task.Priority__c = 'Medium';
                task.Status__c = 'Not Started';
                
                // Due date = Start date + 2 days
                if (project.Start_Date__c != null){
                    task.Due_Date__c = project.Start_Date__c + 2;  
                }            
                
                tasksToCreate.add(task);
            }
            
            insert tasksToCreate;
        }
    }
}