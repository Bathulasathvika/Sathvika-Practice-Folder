public class UpdateContact {
    public static void updateContactIndustry(List<Account> newAccounts, Map<Id, Account> oldMap){
        Set<Id> accountIds = new Set<Id>();
        for(Account acc : newAccounts){
            if(acc.Industry != oldMap.get(acc.Id).Industry){
                accountIds.add(acc.Id);
            }
        }
        List<Contact> contactList = [
            SELECT Id, AccountId, Industry__c
            FROM Contact
            WHERE AccountId IN :accountIds
        ];
        
        Map<Id, String> accountIndustryMap = new Map<Id, String>();

        for(Account acc : newAccounts){
            if(accountIds.contains(acc.Id)){
                accountIndustryMap.put(acc.Id, acc.Industry);
            }
        }
        for(Contact con : contactList){
            con.Industry__c = accountIndustryMap.get(con.AccountId);
        }
        if(!contactList.isEmpty()){
            update contactList;
        }
    }
}