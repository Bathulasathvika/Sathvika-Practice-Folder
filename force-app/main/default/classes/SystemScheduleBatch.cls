public with sharing class SystemScheduleBatch implements Database.Batchable<sObject> {
    public Database.QueryLocator start(Database.BatchableContext bc) {
          return Database.getQueryLocator([select id, Description from Account]);
    }
    public void execute(Database.BatchableContext bc, List<Account> scope){
        List<Account> accountsToUpdate = new List<Account>();
        for(Account acc : scope){
            if(acc.Description == null){
                acc.Description = 'This is the practice example for System.scheduleBatch';
                accountsToUpdate.add(acc);
            }   
        } 
        if(!accountsToUpdate.isEmpty()){
        update accountsToUpdate;
        }
    }
    public void finish(Database.BatchableContext bc){
        System.debug('completed successfully');
    }
}