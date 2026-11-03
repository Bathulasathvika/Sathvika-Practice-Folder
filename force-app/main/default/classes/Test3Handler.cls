public class Test3Handler {
    public static void oppAcc(List<Opportunity> oppList){
        Set<Id> oppId = new Set<Id>();
        for(Opportunity opp : oppList){
            if(opp.AccountId != null){
            oppId.add(opp.AccountId);
        }
     }
        Map<Id, Account> accId = new Map<Id, Account>([
            select id, name, Total_Purchase__c from Account where ID in : oppId
        ]);
            for(Opportunity opp : oppList){
                if(accId.containsKey(opp.AccountId)){
                    Account acc = accId.get(opp.AccountId);
                    acc.Total_Purchase__c = opp.Amount;
                }
            }
        if(!accId.isEmpty()){
            update accId.values();
        }
    }
}