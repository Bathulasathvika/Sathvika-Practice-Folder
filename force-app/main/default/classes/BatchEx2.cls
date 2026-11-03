public with sharing class BatchEx2 implements Database.Batchable<sObject>{
      Integer Counter = 0;
      public Database.QueryLocator start(Database.BatchableContext bc){
           return Database.getQueryLocator([select ID, Phone, HomePhone from Contact]);
      } 
         public void execute(Database.BatchableContext bc, List<Contact> scope){
             for(Contact con : scope){
                   if(con.HomePhone == null){
                        con.HomePhone = con.Phone;
                   }
            } 
            if(!scope.isEmpty()){
                update scope;
            } 
        }
     public void finish(Database.BatchableContext bc){
        Messaging.SingleEmailMessage emailmsg = new Messaging.SingleEmailMessage();
        emailmsg.setToAddresses(new String[]{'sathvika.bathula@raagvitech.com'});
        emailmsg.setSubject('Batch completed email');
        emailmsg.setPlainTextBody('Hey you have completed your batch process');
        Messaging.sendEmail(new Messaging.SingleEmailMessage[]{emailmsg});
        system.debug('Batch Completed');
    }

}