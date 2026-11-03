public class Test2Handler {
    public static void caseOnAcc(List<case> caseList){
        Set<Id> caseSet = new Set<Id>();
        for(Case cs : caseList){
           caseSet.add(cs.AccountId);
        }
        Map<ID, Account> mapAcc = new Map<ID, Account>([  //getting account ids which are in case
            select id, name, latest_case_number__c from Account where id in : caseSet
        ]);
        for(Case cs : caseList){
            if(mapAcc.containsKey(cs.AccountId)){
                Account newAcc  = mapAcc.get(cs.AccountId);
                newAcc.latest_case_number__c = cs.CaseNumber;
            }
        }
        if(!mapAcc.isEmpty()){
        update mapAcc.values();
        }
    }
}