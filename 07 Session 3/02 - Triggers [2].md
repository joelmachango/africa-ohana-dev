trigger AccountTrigger on Account (before insert) {

    for (Account accountObj : Trigger.new) {
        if (accountObj.Industry==null) {
            accountObj.Industry='Technology';
        }
    }
}

// LOGIC in Trigger - NOT Best Practice
trigger AccountTrigger on Account (before insert, after insert, before update) {
    
    if(Trigger.isBefore){
        
        if(Trigger.isInsert) {
            // Before Insert
            for (Account accountObj : Trigger.new) {
                if (accountObj.Industry==null) {
                    accountObj.Industry='Technology';
                } 
            }
        } else if (Trigger.isUpdate){
            // Before Update
            for(Account accountObj: trigger.new) {
                
                Account oldAccountObj = Trigger.oldMap.get(accountObj.id);
                
                if (accountObj.AnnualRevenue<1000000 && accountObj.AnnualRevenue != oldAccountObj.AnnualRevenue && oldAccountObj.AnnualRevenue >= 1000000) {
                    accountObj.addError('Annual Revenue cannot be reduced below $1,000,000');
                }
            }
        }  
        
    } else if(Trigger.isAfter){        
        List<Task> tasks = new List<Task>();
        
        for (Account acc: Trigger.new){
            Task welcomeTask = new Task (Subject = 'Welcome to Salesforce!', WhatId = acc.Id, OwnerId = acc.OwnerId, Status = 'Not Started', Priority = 'Normal');
            tasks.add(welcomeTask);
        }
        
        if (!tasks.isEmpty()){
            insert tasks;
        }
    }    
}

 Part 2: Handlers, Switch Case, and Best Practices

// Upsert:
Account acc = new Account(Name='TestSalyCode');
upsert acc;

System.debug('Acc ID '+acc.Id);

// Simplify Triggers with Switch Statements

// LOGIC in Trigger - NOT Best Practice
trigger AccountTrigger on Account (before insert, after insert, before update, after update) {
    
    switch on Trigger.OperationType {
        when BEFORE_INSERT {
            for (Account accountObj : Trigger.new) {
                if (accountObj.Industry==null) {
                    accountObj.Industry='Technology';
                } 
            }
        }
        
        when AFTER_INSERT {
            List<Task> tasks = new List<Task>();
        
            for (Account acc: Trigger.new){
                Task welcomeTask = new Task (Subject = 'Welcome to Salesforce!', WhatId = acc.Id, OwnerId = acc.OwnerId, Status = 'Not Started', Priority = 'Normal');
                tasks.add(welcomeTask);
            }
            
            if (!tasks.isEmpty()){
                insert tasks;
            }
        }
        
        when BEFORE_UPDATE {
            for(Account accountObj: trigger.new) {
                
                Account oldAccountObj = Trigger.oldMap.get(accountObj.id);
                
                if (accountObj.AnnualRevenue<1000000 && accountObj.AnnualRevenue != oldAccountObj.AnnualRevenue && oldAccountObj.AnnualRevenue >= 1000000) {
                    accountObj.addError('Annual Revenue cannot be reduced below $1,000,000');
                }
            }
        }
        
        when AFTER_UPDATE {
            if(Trigger.isInsert){
            List<Task> tasks = new List<Task>();
        
            for (Account acc: Trigger.new){
                Task welcomeTask = new Task (Subject = 'Welcome to Salesforce!', WhatId = acc.Id, OwnerId = acc.OwnerId, Status = 'Not Started', Priority = 'Normal');
                tasks.add(welcomeTask);
            }
            
            if (!tasks.isEmpty()){
                insert tasks;
            }
        }
        else if(Trigger.isUpdate){
            
        }
        }
        
        when BEFORE_DELETE {
            for(Account acc: Trigger.old) {
                Integer oppCount = [SELECT COUNT() FROM Opportunity WHERE AccountId = :acc.Id];
                
                if (oppCount > 0) {
                    acc.addError ('You cannot delete this Account because it has associated Opportunities.');
                }
            }
        }
        
        when AFTER_UNDELETE {
            List<Task> tasks = new List<Task>();
            
            for (Account acc: Trigger.new) {
                Task restoreTask = new Task (
                    Subject = 'Review Restored Account',
                    WhatId = acc.Id,
                    OwnerId = acc.OwnerId,
                    Status = 'Not Started',
                    Priority = 'High'
                );
                tasks.add(restoreTask);
            }
            
            if(!tasks.isEmpty()){
                insert tasks;
            }
        }
    }    
   
}

Why Use a Trigger Handler?
- Seperation of concerns
- Easier Maintainance
- Scalability

public class AccountTriggerHandler {
    public static void handleBeforeInsert(List<Account> lstNewAccounts, Map<Id, Account> mapNewAccounts){
        setInitialIndustry(lstNewAccounts);
        setPriority(lstNewAccounts);
    }
    
    public static void handleBeforeUpdate(List<Account> lstNewAccounts, List<Account> lstOldAccounts, Map<Id, Account> mapNewAccounts, Map<Id, Account> oldMapAccounts){
      	validateAnnualRevenue(lstNewAccounts, oldMapAccounts);
    }
    
    
    ////////////////////// Start Private Methods ////////////////////////
    private static void validateAnnualRevenue(List<Account> lstNewAccounts, Map<Id, Account> mapOldAccounts){
        for (Account accountObj: lstNewAccounts) {
            Account oldAccountObj = mapOldAccounts.get(accountObj.id);
                
            if (accountObj.AnnualRevenue<1000000 && accountObj.AnnualRevenue != oldAccountObj.AnnualRevenue && oldAccountObj.AnnualRevenue >= 1000000) {
                accountObj.addError('Annual Revenue cannot be reduced below $1,000,000');
            }  
        }        
    }
        
    private static void setInitialIndustry(List<Account> lstNewAccounts){
        for (Account accountObj : lstNewAccounts) {
            if (accountObj.Industry==null) {
                accountObj.Industry='Technology';
            } 
        }
    }
    
    private static void setPriority(List<Account> lstNewAccounts){}
}