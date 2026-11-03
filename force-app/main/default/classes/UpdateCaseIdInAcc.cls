// When a Case is created on any Account, put the latest case number 
// on the Account in the 'Latest Case Number' field.

public class UpdateCaseIdInAcc {
    public static void UpdateAcc(List<Case> caseIds) {
       Set<Id> accids = new Set<Id>();
      for(Case cs : caseIds){
         if(cs.AccountId != null){
            accids.add(cs.AccountId);
         }
      }
      List<Account> acc = [
        Select Id, latest_case_number__c from Account where Id IN: accids
      ];
      for(Case cs : caseIds){
        for(Account newIds : acc){
            if(newIds.Id == cs.AccountId){
               newIds.latest_case_number__c = cs.CaseNumber;
            }
        }
      }
       if(!acc.isEmpty()){
        update acc;
       }
    }
}

