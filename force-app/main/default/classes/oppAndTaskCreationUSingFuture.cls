public with sharing class oppAndTaskCreationUSingFuture {
@future
   public static void oppMethod(List<ID> OppIDs) {
       List<Opportunity> listids = [
        select id, name, stageName from Opportunity where id in : OppIDs
       ];
        
       List<Task> newTask = new List<Task>();
          for(Opportunity opp : listids){
            if(opp.StageName == 'Not Started'){
                Task ts = new Task();
                ts.subject = 'new task created using future apex';
                ts.Status = 'prospecting';
                ts.WhatId = opp.id;
                newTask.add(ts);
            }
          }
          if(!newTask.isEmpty()){
            insert newTask;
          }
    }
}