public class copyBillingTriggerHandler {
    public static void copyBillingMethod(List<Account> AccList) {
         for(Account acc : AccList){
            if(acc.CopyBillingToShipping__c){
                acc.ShippingCountry = acc.BillingCountry;
                acc.ShippingStreet = acc.BillingStreet;
                acc.ShippingCity = acc.BillingCity;
            }
         }
    }
}