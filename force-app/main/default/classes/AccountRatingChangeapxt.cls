public with sharing class AccountRatingChangeapxt{
    public static void AccountRatingChangeapxtMethod(List<Account> account) {
        for(Account acc : account){
            if(acc.Amount != null && acc.AnnualRevenue >= 1000000){
                acc.Rating = 'Hot';
            }else{
                acc.Rating = 'Warm';
            }
        }
    }  
}