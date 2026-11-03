/**
 * @description       : 
 * @author            : Sathvika B
 * @group             : 
 * @last modified on  : 07-15-2026
 * @last modified by  : Sathvika B
**/

public with sharing class AccIndustry {
     private static Boolean isExecuted = false;
public static void AccIndustryMethod(List<Account> newAcc,Map<Id, Account> oldMap) {
      if(isExecuted) {
            return;
      }
      isExecuted = true;
       Map<ID, String> accMap = new Map<ID, String>();
          for(Account acc : newAcc){
            Account oldAcc = oldMap.get(acc.ID);
              if(oldAcc.phone != acc.phone){
                accMap.put(acc.ID, acc.phone);           
             }
          }
          if(!accMap.isEmpty()){
            return;
          }
          List<Contact> conList = [
            Select id, name , AccountID, Homephone from Contact where AccountID in : accMap.keySet()
          ];
          for(Contact con : conList){
            con.HomePhone = accMap.get(con.AccountID);
          }
          if(!conList.isEmpty()){
            update conList;
          }
    }
}