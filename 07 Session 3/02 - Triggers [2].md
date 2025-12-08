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