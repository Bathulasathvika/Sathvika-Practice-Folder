public with sharing class QueueableExampleClass implements Queueable {
    public void execute(QueueableContext qc) {
      List<Account> accList = new List<Account>();
      for(Account acc : accList){
        Account acc = new Account();
        acc.Name = 'QueueableApex Account';
        acc.Industry = 'Agriculture'; 
      }
      Insert acc;
    }
}