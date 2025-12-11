Apex Trigger + Unit Testing Scenario – Project Phase 1
==
This week you will begin building a mini Salesforce Project Management App using Project__c and Project_Task__c.

⭐ 1. Create the Parent Object – Project__c
==

Fields:
- Name (standard)
- Start_Date__c (Date)
- End_Date__c (Date)
- Description__c (Long Text Area)

⭐ 2. Create the Child Object – Project_Task__c
==

Fields:
- Project__c (Master Detail to Project__c)
- Name (Text) (Standard Field)
- Due_Date__c (Date) (Required field)
- Status__c (Picklist): (Default Value Not Started)
    - Not Started
    - In Progress
    - Completed
- isCompleted__c (Checkbox) (Default Unchecked)
- Priority__c (Picklist): (Required Field)
    - Low
    - Medium
    - High

⭐ 3. Trigger on Project_Task__c
==

1. Ensures Due_Date__c is in the future
    - Applies when inserting a new record
    - Applies when a user updates an existing record
    - Block the action if the date is Today or in the past

2. Automatically sets Status__c = 'Completed' if isCompleted__c is set to true during update

3. Prevent lowering priority: If Priority__c was previously 'High', users cannot change it to Medium or Low.

4. Prevent setting isCompleted__c = true when inserting new Task

⭐ 4. Trigger on Project__c
==
1. For every new Project__c record, automatically create one Project_Task__c child record:
    - Name: “Kickoff Task”
    - Due_Date__c = Project.Start_Date__c + 2 days
    - Priority__c = Medium
    - Status__c = Not Started

⭐ 5. Unit Testing Requirements
==
- Use a Test Data Factory
- Use @testSetup where appropriate
- Cover for all your code:
    - Positive cases
    - Negative (validation error) cases
    - Bulk operations for both Project__c and Project_Task__c


Goal:
----

Aim for 75%+ coverage, but more importantly, test every branch of your logic.