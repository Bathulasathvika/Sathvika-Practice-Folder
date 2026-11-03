public class OpportunityTaskCreation {
    public static void createTask(List<Opportunity> newOppList){
        Map<ID, String> stageMap = new Map<ID, String>();
        for(Opportunity opp : newOppList){
            if(opp.StageName == 'Closed Won'){
               stageMap.put(opp.ID, opp.StageName);
            }
        }
        
        for(Opportunity opp1:newOppList){
            Task tsk = new Task();
            tsk.WhatId = opp1.Id;
            
            tsk.Subject ='closed won task';
            tsk.ActivityDate = system.today().addDays(30);
        }
        
        
            
    }
}