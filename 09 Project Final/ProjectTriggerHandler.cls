public class ProjectTriggerHandler {
    public static void handleBeforeInsert(List<Project__c> lstProjects) {
        validateNewProjects(lstProjects);       
    }
    
    public static void handleAfterInsert(List<Project__c> lstProjects) {
        List<Project_Task__c> tasksToCreate = new List<Project_Task__c>();
            
        for(Project__c project: lstProjects){
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
        
        // Only insert if the list has tasks
        if (!tasksToCreate.isEmpty()) {
            insert tasksToCreate;
        }      
    }
    
    private static void validateNewProjects(List<Project__c> lstProjects){
        Date today = Date.today();

        // No Start date
        for (Project__c project : lstProjects) {
            if (project.Start_Date__c == null) {
                project.Start_Date__c = today;
            }
        } 
    }
    
    // private static List<Project_Task__c> createKickoffTasks(List<Project__c> lstProjects){}
}