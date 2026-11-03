public class AccPhoneUpdate {
    public static void phoneFieldUpdate(List<Account> accList, Map<Id, Account> oldValues) { 
        for(Account acc : accList){
            Account oldAcc = oldValues.get(acc.Id);
            
            if(acc.Phone != oldAcc.Phone){
                acc.Description = 'Phone field is updated' + ' New phone' + acc.phone + ' Old Phone' + oldAcc.Phone; 
            }
        }
    }
}