/**
 * @description       : 
 * @author            : Sathvika B
 * @group             : 
 * @last modified on  : 07-16-2026
 * @last modified by  : Sathvika B
**/

public with sharing class Test6Handler {
    public static void Test6HandlerMethod(List<Account> newList, Map<Id, Account> oldMap) {   
        Map<ID, String> accMap = new Map<ID, String>();
        for(Account acc : newList){
            Account newAcc = oldMap.get(acc.ID);
                if(newAcc.phone != acc.phone){
                       accMap.put(acc.Id, acc.phone);
                }
            }
        List<Contact> contactList = [
                 select Id, Name, HomePhone, AccountId
                 FROM Contact
                 WHERE AccountId IN : accMap.keySet()
      ];
        for(Contact con : contactList){
            con.Homephone = accMap.get(con.AccountId);
        }
        if(!contactList.isEmpty()){
            update contactList;
        }
    }
}