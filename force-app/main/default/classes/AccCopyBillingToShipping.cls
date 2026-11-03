public class AccCopyBillingToShipping {
    public static void copyAddress(List<Account> accList, Map<Id, Account> oldMap){
        for(Account acc : accList){
            Account oldValue = oldMap.get(acc.Id);
            if(acc.CopyBillingToShipping__c == True){
               acc.BillingAddress = oldValue.ShippingAddress;
            }
        }
    }
}