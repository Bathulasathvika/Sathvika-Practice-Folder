public class AccountoppDeletion {
    public static void accOpp(List<Account> oldAccounts){
        Map<Id, Account> accWithopp = new Map<Id, account>([
            Select id from Account where id IN: oldAccounts AND Id IN
                                     (select AccountId from opportunity)
        ]);
        for(Account acc : oldAccounts){
            if(accWithopp.containsKey(acc.ID)){
                acc.addError('this account cannot be deleted as it is associated with opp');
            }
        }
        
    }
}