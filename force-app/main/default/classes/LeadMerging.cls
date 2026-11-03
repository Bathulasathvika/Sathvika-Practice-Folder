public class LeadMerging implements Database.Batchable<SObject> {
    public Database.getQueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(
            [Select Id, Name, Email, Phone from Lead Where IsConverted=false]
        );
    }
    public void execute(Database.BatchableContext bc, List<Lead> scope){
       Set<String> leadEmails = new Set<String>();
       Set<String> leadPhones = new Set<String>();
       Set<String> leadNames = new Set<String>();

       for(Lead ld : scope){
        

       }
    }
}