public with sharing class BatchEx3 implements Database.Batchable<sObject>{
    public Database.QueryLocator start(Database.BatchableContext bc){
          return Database.getQueryLocator([Select id, caseNumber from case where CreatedDate <= :System.now().addDays(-10) AND status = 'New']);
    }
       public void execute(Database.BatchableContext bc, List<Case> scope){
          for(Case cs : scope){
           cs.status = 'Closed';
          }
          if(!scope.isEmpty()){
            update scope;
          }
        }
            public void finish(Database.BatchableContext bc){
                   System.debug('Batch Completed');
        }   
     
    }