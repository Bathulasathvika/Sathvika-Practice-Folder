public class FlowLeadConverter {
    @InvocableMethod(label='Convert Qualified Leads From Flow' category='Lead')
    public static void convertLeads(List<Id> leadIds) {
        List<Database.LeadConvert> leadConverts = new List<Database.LeadConvert>();
        LeadStatus convertStatus = [SELECT MasterLabel FROM LeadStatus WHERE IsConverted = true LIMIT 1];
        
        for (Id leadId : leadIds) {
            Database.LeadConvert lc = new Database.LeadConvert();
            lc.setLeadId(leadId);
            lc.setConvertedStatus(convertStatus.MasterLabel);
            leadConverts.add(lc);
        }
        
        if (!leadConverts.isEmpty()) {
            Database.convertLead(leadConverts, false);
        }
    }
}
