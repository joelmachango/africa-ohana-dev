@isTest
public class TestDataFactory {
	// Create a test Project
    public static Project__c createTestProject() {
        Project__c project = new Project__c(
            Name__c = 'CodeWithSaly Website Revamp Project',
            Start_Date__c = Date.newInstance(2026, 1, 15),
            End_Date__c = Date.newInstance(2026, 3, 30),
            Description__c = 'A project focused on redesigning the CodeWithSaly platform, improving UI/UX, content structure, and performance.'
        );
        insert project;
        return project;
    }
    // Create test Projects
    public static List<Project__c> createTestProjects(Integer count, Boolean hasStartDate) {
        List<Project__c> projects = new List<Project__c>();
        
        for (integer i = 1; i < count; i++) {
            projects.add(new Project__c(
                Name__c = 'Project Salesforce Dev ' + i,
                Start_Date__c = hasStartDate ? Date.today().addDays(i) : null,
                End_Date__c = hasStartDate ? Date.today().addDays(i + 10) : null,
                Description__c = 'Project Salesforce Dev Description ' + i
            ));
        }
       
        insert projects;
        return projects;
    }
	// Create a test Project Task
    public static Project_Task__c createTestProjectTask(Project__c project) {
        Project_Task__c task = new Project_Task__c(
            Project__c = project.Id,
            Name__c = 'Kickoff Task',
			Due_Date__c = Date.newInstance(2026, 3, 30),         
            Status__c = 'Not Started',
            isCompleted__c = false,
            Priority__c = 'Medium'
        );
        insert task;
        return task;
    }
}