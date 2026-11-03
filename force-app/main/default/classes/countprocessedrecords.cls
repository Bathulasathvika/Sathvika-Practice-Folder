public with sharing class countprocessedrecords implements Database.Batchable<sObject>, Database.stateful{
    Integer Recordcount = 0;
    public Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator([Select id, name from Account]);
    }
    public void execute(Database.BatchableContext bc, List<Account> scope) {
        for(Account acc : scope){
            RecordCount++;
        }
    }
    public void finish(Database.BatchableContext bc){
        System.debug(RecordCount);
    }
}