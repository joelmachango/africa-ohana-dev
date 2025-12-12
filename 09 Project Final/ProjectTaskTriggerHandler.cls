public class ProjectTaskTriggerHandler {
    public static void handleBeforeInsert(List<Project_Task__c> lstNewTasks) {
        validateNewTasks(lstNewTasks);       
    }
    
    public static void handleBeforeUpdate(List<Project_Task__c> lstNewTasks, Map<Id, Project_Task__c> mapOldTasks) {
        validateUpdatedTasks(lstNewTasks, mapOldTasks);            
    }
    
    private static void validateNewTasks(List<Project_Task__c> lstNewTasks){
        Date today = Date.today();
        
        for(Project_Task__c task: lstNewTasks) {
            // Ensures Due_Date__c is in the future 
            // Block the action if the date is Today or in the past
            if(task.Due_Date__c != null && task.Due_Date__c <= today){
                task.addError('The Due Date must be in the future.');
            }
            // Prevent setting isCompleted__c = true when inserting new Task 
            if(task.isCompleted__c == true) {
                task.addError('A New Task cannot be Marked as Completed.');
            }            
        }
    }
    
    private static void validateUpdatedTasks(List<Project_Task__c> lstNewTasks, Map<Id, Project_Task__c> mapOldTasks){
        Date today = Date.today();
        
        for(Project_Task__c task: lstNewTasks){
            Project_Task__c oldTask = mapOldTasks.get(task.id);
            // Ensures Due_Date__c is in the future 
            // Block the action if the date is Today or in the past
            if(task.Due_Date__c != null && task.Due_Date__c <= today){
                task.addError('The Due Date must be in the future.');
            }
            // Automatically sets Status__c = 'Completed' if isCompleted__c is set to true during update
            if(task.isCompleted__c == true && oldTask.isCompleted__c == false){
                task.Status__c = 'Completed';                    
            }
            // if Status becomes Completed, need to set isCompleted true - [gap 1]
            if(oldTask.Status__c != 'Completed' && task.Status__c == 'Completed'){
                task.isCompleted__c = true;
            } 
            // if Status becomes Not Completed, need to set isCompleted false - [gap 2]
            if(task.Status__c != 'Completed'){
                task.isCompleted__c = false;
            }
            // Prevent lowering priority: High → Medium/Low
            if(oldTask.Priority__c == 'High' && task.Priority__c != 'High'){
                task.addError('Priority cannot be lowered from High.');
            }
        }  
    }
}