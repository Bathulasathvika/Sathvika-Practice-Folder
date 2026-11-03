public with sharing class CreatingBulkRecords implements Database.Batchable<sObject>{
    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator([select name from customer__c]);

    }
    public void execute(Database.BatchableContext bc, List<customer__c> scope){
        for(Integer i = 0; i<10000; i++){
            customer__c cs = new customer__c();
            cs.customername__c = 'sathvika ' + i;
        }
        insert scope;     
    }
    public void finish(Database.BatchableContext bc){
        System.debug('Inserting 10000 records');
    }
}