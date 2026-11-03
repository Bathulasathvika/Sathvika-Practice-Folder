public with sharing class NewCaseforRelatedAcc {
    public static void CaseRelatedAcc(List<Case> newCase){
         Set<Id> accIds = new Set<Id>();
         for(Case cs : newCase){
            if(cs.AccountId != null){
                accIds.add(cs.AccountId);
            }
         }
         List<Account> accList = [Select Id, latest_case_number__c from Account where id in : accIds];
         if(accList.latest_case_number__c != null){
            for(Account acc : accList){
                acc.latest_case_number__c = cs.CaseNumber;
            }
        }
        if(!accList.isEmpty()){     
            update accList;
         }
    } 
}