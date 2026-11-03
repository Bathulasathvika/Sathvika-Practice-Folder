/**
 * @description       : 
 * @author            : Sathvika B
 * @group             : 
 * @last modified on  : 07-16-2026
 * @last modified by  : Sathvika B
**/
public with sharing class OpportunityTaskHandler {
    private static Boolean isExecuted=false;
    public static void createTask(List<Opportunity> newOpp, Map<Id, Opportunity> oldMap){
        List<Task> tsk = new List<Task>();
        if(isExecuted){
            return;
        }
        isExecuted = true;
        for(Opportunity Opp : newOpp){
            Opportunity oppList = oldMap.get(opp.Id);
            if(oppList.StageName != opp.StageName && opp.StageName == 'Closed Won'){
                Task t = new Task();
                t.Subject = 'Follow Up';
                t.WhatId = opp.Id;
                t.OwnerId = opp.OwnerId;
                t.Status = 'Not Started';
                t.Priority = 'Normal';
                tsk.add(t);
            }
        }
            if(!tsk.isEmpty()){
              insert tsk;
        }
    }
}