public with sharing class FutureApexOne {
    public static void ApexOneMethod(List<Account> accList, Map<ID, Account> oldMap) {
       Set<ID> newIds = new Set<ID>();
       for(Account acc : accList){
           if(acc.id != oldMap.get(acc.id).Industry){
            newIds.add(acc.id);
           }
       }
    }
}
