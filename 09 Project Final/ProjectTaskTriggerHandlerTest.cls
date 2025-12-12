@isTest
public class ProjectTaskTriggerHandlerTest {
    // Shared test data for test methods
    @testSetup
    static void setupTestData() {
        TestDataFactory.createTestProject();
    }
    // +Ve Case: Create a valid project task 
	@isTest
    static void testCreateValidTask() {
        Project__c project = [SELECT Id FROM Project__c LIMIT 1];

        Test.startTest();
        Project_Task__c task = TestDataFactory.createTestProjectTask(project);
        Test.stopTest();

        Assert.areNotEqual(null, task.Id, 'Task Id should not be null');
    }
    // -Ve Case: Due Date in the past
    @isTest
    static void testDueDateInThePast() {
        Project__c project = [SELECT Id FROM Project__c LIMIT 1];
        
        Project_Task__c task = new Project_Task__c(
            Project__c = project.Id,
            Name__c = 'Task with Due Date Past',
            Due_Date__c = Date.today().addDays(-5), // 5 days in the past
            Status__c = 'Not Started',
            isCompleted__c = false,
            Priority__c = 'Medium'
        );
        try {
            insert task;
            Assert.fail('Insert should have throw an error beacuse Due Date in the past');
        } catch (DmlException error) {
            Assert.isTrue(error.getMessage().contains('The Due Date must be in the future'), 'Expected Due Date error');
        }
    }
    // -Ve Case: New Task marked completed
    @isTest
    static void testNewTaskConnotBeCompleted() {
        Project__c project = [SELECT Id FROM Project__c LIMIT 1];
        Project_Task__c task = new Project_Task__c(
            Project__c = project.Id,
            Name__c = 'Task with Completed',
            Due_Date__c = Date.today().addDays(-5), // 5 days in the past
            Status__c = 'Not Started',
            isCompleted__c = true, // not allowed
            Priority__c = 'Medium'
        );
        try {
            insert task;
            Assert.fail('Insert should have throw an error beacuse isCompleted__c = true');
        } catch (DmlException error) {
            Assert.isTrue(error.getMessage().contains('A New Task cannot be Marked as Completed'), 'Expected isCompleted error');
        }
    }
    // Bulk Insert
    @isTest
    static void testBulkInsertTasks() {
        Project__c project = [SELECT Id FROM Project__c LIMIT 1];
        
        List<Project_Task__c> tasks = new List<Project_Task__c>();
        for(Integer i = 1; i <= 55; i++) {
            tasks.add(new Project_Task__c(
                Project__c = project.Id,
                Name__c = 'Ohana Task ' + i,
                Due_Date__c = Date.today().addDays(5 + i),
                Status__c = 'Not Started',
                isCompleted__c = false,
                Priority__c = 'Medium'
            ));            
        }

		Test.startTest();
        insert tasks;
        Test.stopTest();
        
        // Count added tasks
        Integer addedTasks = [SELECT COUNT() FROM Project_Task__c WHERE Project__c = :project.Id AND Name__c LIKE 'Ohana Task%'];
        System.debug('tasks '+tasks);
        System.debug('addedTasks '+addedTasks);
        Assert.areEqual(55, addedTasks, '55 tasks added successfully!');
    }
    // Update : Marking task completed
    @isTest
    static void testUpdateTaskToCompleted() {
        Project__c project = [SELECT Id FROM Project__c LIMIT 1];
        Project_Task__c task = TestDataFactory.createTestProjectTask(project);
        
        // Update task to completed
        task.isCompleted__c = true;
        
        Test.startTest();
        update task;
        Test.stopTest();
        
        Project_Task__c updatedTask = [SELECT Status__c, isCompleted__c FROM Project_Task__c WHERE Id = :task.Id];
        Assert.areEqual('Completed', updatedTask.Status__c, 'Automatically sets Status__c = "Completed" if isCompleted__c is set to true during update');
        Assert.areEqual(true, updatedTask.isCompleted__c, 'if Status becomes Completed, set isCompleted true');
    }
    // -Ve Case: Lower priority from High
    @isTest
    static void testCannotLowerHighPriority() {
        Project__c project = [SELECT Id FROM Project__c LIMIT 1];
        
        Project_Task__c task = new Project_Task__c(
            Project__c = project.Id,
            Name__c = 'Task - High Priority!',
            Due_Date__c = Date.today().addDays(5),
            Status__c = 'Not Started',
            isCompleted__c = false,
            Priority__c = 'High'
        );

        insert task;

        // Lower priority
        task.Priority__c = 'Medium';

        try {
            update task;
            Assert.fail('Should throw High Priority error');
        } catch (DmlException error) {
            Assert.isTrue(error.getMessage().contains('Priority cannot be lowered from High.'), 'Expected High Priority error');
        }
    }
}