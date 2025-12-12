@isTest
public class ProjectTriggerHandlerTest {
    // Shared test data for test methods
    @testSetup
    static void setupTestData() {
        TestDataFactory.createTestProject();
    }
    
    // +Ve Case : Project is created, Kickoff task created after automatically
	@isTest
    static void testCreateProject() {

        Test.startTest();
        Project__c project = TestDataFactory.createTestProject();
        Test.stopTest();

        Assert.areNotEqual(null, project.Id, 'Project should have an Id');
        
        // kickoff task created
        Integer tasks = [SELECT COUNT() FROM Project_Task__c WHERE Project__c = :project.Id AND Name__c ='Kickoff Task'];
        Assert.areEqual(1, tasks, 'Create kickoff task automatically');
    }   
    
    // +Ve Case: Kickoff Task due date = Start Date + 2 days
    @isTest
    static void testKickoffTaskDueDate() {
        Project__c project = new Project__c(
            Name__c = 'Test Project',
            Start_Date__c = Date.today()
        );
        
        Test.startTest();
        insert project;
        Test.stopTest();

		Project_Task__c task = [SELECT Id, Due_Date__c FROM Project_Task__c WHERE Project__c = :project.Id LIMIT 1];
        Assert.areEqual(Date.today().addDays(2), task.Due_Date__c, 'Kickoff task due date is start date + 2');
    }
    
    // Bulk Insert : Insert multiple projects & verify kickoff tasks
    @isTest
    static void testAddBulkProjects(){
        List<Project__c> multipleProjects = TestDataFactory.createTestProjects(55, true);
        
        Test.startTest();
        // happen's in data factory
        Test.stopTest();
        
        Integer tasksAdded = [SELECT COUNT() FROM Project_Task__c WHERE Name__c = 'Kickoff Task'];
        Assert.areEqual(55, tasksAdded, 'Tasks and Project total number should be same');
    }
    
    // Bulk Test: Projects without Start Date(set to today)
    @isTest
    static void testAddBulkProjectsNoStartDate() {
        List<Project__c> noStartDateProjects = new List<Project__c>();
        
        for(integer i = 0; i < 25; i++) {
            noStartDateProjects.add(new Project__c(
                Name__c = 'No Start Date '+ i
            ));
        }
        Test.StartTest();
        insert noStartDateProjects;
        Test.stopTest();

        for (Project__c project : [SELECT Start_Date__c FROM Project__c WHERE Name__c LIKE 'No Start Date%']){
            System.debug('project '+project);
            Assert.areEqual(Date.today(), project.Start_Date__c, 'All projects should have today as start date');
        }
    }
}