global class BatchEx1 implements Database.Batchable<sObject>, Database.stateful{
    Integer Counter = 0;
    global Database.QueryLocator start(Database.BatchableContext bc){

        return Database.getQueryLocator([
            SELECT Id, Description FROM Account limit 6
        ]);
    }

    global void execute(Database.BatchableContext bc, List<Account> scope){

        for(Account acc : scope){
          
            acc.Description = 'Updated By Batch Apex';
            Counter = Counter + scope.size();

        }

        if(!scope.isEmpty()){
            update scope;
        }

    }


public void finish(Database.BatchableContext bc){
        BatchEx2 ex = new BatchEx2();
        Database.ExecuteBatch(ex, 5);
        System.debug(bc.getJobId());
     
    }
}