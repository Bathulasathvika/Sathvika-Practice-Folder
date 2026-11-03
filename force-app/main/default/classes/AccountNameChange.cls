public class AccountNameChange {
    public static void changeName(List<Account> accountList, Map<ID, Account> accOldMap){
        for(Account newAcc : accountList){
            Account oldAcc = accOldMap.get(newAcc.Id);
            if(newAcc.Name != oldAcc.Name){
                newAcc.Name.addError('Account name cant be updated');
            }
        
    }
}
}