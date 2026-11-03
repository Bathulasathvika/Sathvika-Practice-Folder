public with sharing class LogDeletedAccounts {
    public static void deletedAccounts(List<Account> delAcc){
        if(delAcc == null || delAcc.isEmpty()){
            return;
        }
        List<Deleted_Account_log__c> delLogs = new List<Deleted_Account_log__c>();
        for(Account acc : delAcc){
            Deleted_Account_log__c AccDel = new Deleted_Account_log__c();
            AccDel.Name= acc.Name;
            AccDel.Deleted_Date__c = System.today();
            delLogs.add(AccDel);
        }
        if(!delLogs.isEmpty()){ 
            insert delLogs;
        }
        
    } 

}
