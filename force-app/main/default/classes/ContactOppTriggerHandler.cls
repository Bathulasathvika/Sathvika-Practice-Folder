public with sharing class ContactOppTriggerHandler {
    public static void ContactOppMethodOne(List<Contact> conList, Map<ID, Contact> oldMap) {
       Set<id> setIds = new Set<id>();
       for(Contact con : conList){
        if(con.AccountId != null && con.Department == 'Admin' && con.Department != oldMap.get(con.Id).Department){
            setIds.add(con.AccountId);
        }
       }
       if(setIds.isEmpty()){
        return;
       }
       List<Opportunity> oppList = [
        select Id, AccountId, stageName from Opportunity where AccountId in : setIds
       ];
       for(Opportunity opp : oppList){
        opp.stageName = 'closed Lost';
       }
       if(!oppList.isEmpty()){
        Update oppList;
       }
    }
}