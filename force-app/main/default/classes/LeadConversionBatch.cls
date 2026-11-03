public class LeadConversionBatch implements Database.Batchable<sObject> {
    
    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator([
            SELECT Id, Status 
            FROM Lead 
            WHERE Status = 'Qualified' AND IsConverted = false
        ]);
    }
    
    public void execute(Database.BatchableContext bc, List<Lead> scope) {
        List<Database.LeadConvert> leadConverts = new List<Database.LeadConvert>();
        LeadStatus convertStatus = [SELECT MasterLabel FROM LeadStatus WHERE IsConverted = true LIMIT 1];
        
        for (Lead leadRecord : scope) {
            Database.LeadConvert lc = new Database.LeadConvert();
            lc.setLeadId(leadRecord.Id);
            lc.setConvertedStatus(convertStatus.MasterLabel);
            leadConverts.add(lc);
        }
        
        if (!leadConverts.isEmpty()) {
            Database.LeadConvertResult[] lcrList = Database.convertLead(leadConverts, false);
        }
    }
    
    public void finish(Database.BatchableContext bc) {
        System.debug('Lead conversion batch process finished.');
    }
}
