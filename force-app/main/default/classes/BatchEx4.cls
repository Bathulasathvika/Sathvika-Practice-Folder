global with sharing class BatchEx4 implements Database.Batchable<sObject>{
      global Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator([select Amount from Opportunity]);
        }
          global void execute(Database.BatchableContext bc, List<Opportunity> scope){
            for(Opportunity opp : scope){
                opp.Amount += opp.Amount * 10 / 100;
            }
            if(!scope.isEmpty()){
                update scope;
            }
          }
         global void finish(Database.BatchableContext bc){
            System.debug('Batch Completed');
          }
        }
