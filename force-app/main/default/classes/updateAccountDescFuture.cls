public with sharing class updateAccountDescFuture  {
    @future
    public static void futureMethodEx(Set<ID> AccountIDS) {
        List<Account> acc = [
            Select id, name, Description from Account where id in : AccountIDS
        ];

        for(Account accList : acc){
            accList.Description = 'Created using future Apex';
        }
        if(!acc.isEmpty()){
            update acc;
        }
    }
}