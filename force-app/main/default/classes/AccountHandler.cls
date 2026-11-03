public class AccountHandler {
    public static void newAccount(List<Account> newaccList){
        for(Account acc : newaccList){
            acc.ShippingStreet = acc.BillingStreet;
            acc.ShippingCity = acc.BillingCity;
              
        }
    }
}