public class OppAmountonAcc {
    public static void OppAmount(List<Opportunity> opp) {
     Set<Id> accIds = new Set<Id>();
     for(Opportunity oppList : opp){
        if(oppList.AccountId != null){
             accIds.add(oppList.AccountId);
        }
     }
     List<Account> accList = [
        Select Id, Recent_Opportunity_Amount__c from Account Where Id IN: accIds
     ];
      for(Opportunity oppList : opp){
        for(Account acc : acclist){
            if(oppList.AccountId == acc.Id){
                acc.Recent_Opportunity_Amount__c = oppList.Amount;
            }
        }
      }
         if(!accList.isEmpty()){
            update accList;
         }
    }
}