public with sharing class CreatingAccConTask implements Queueable{
    public void execute(QueueableContext qc) {
       List<Account> accList = new List<Account>();
       for(Integer i=0;i<5;i++){
        Account newAcc = new Account();
        newAcc.Name = 'sathvika'+i;
        accList.add(newAcc);
       }

       if(!accList.isEmpty()){
        insert accList;
       }
    }
}