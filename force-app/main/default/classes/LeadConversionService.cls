public class LeadConversionService {

    public static void convertLeads(Set<Id> leadIds) {

        if (leadIds.isEmpty()) {
            return;
        }

        LeadStatus status = [
            SELECT MasterLabel
            FROM LeadStatus
            WHERE IsConverted = true
            LIMIT 1
        ];

        List<Lead> leads = [
            SELECT Id
            FROM Lead
            WHERE Id IN :leadIds
            AND IsConverted = false
        ];

        List<Database.LeadConvert> conversions =
            new List<Database.LeadConvert>();

        for (Lead ld : leads) {
            Database.LeadConvert request =
                new Database.LeadConvert();

            request.setLeadId(ld.Id);
            request.setConvertedStatus(status.MasterLabel);
            request.setDoNotCreateOpportunity(true);

            conversions.add(request);
        }

        if (!conversions.isEmpty()) {
            List<Database.LeadConvertResult> results =
                Database.convertLead(conversions, false);

            for (Database.LeadConvertResult result : results) {
                if (!result.isSuccess()) {
                    System.debug(
                        'Conversion failed: ' +
                        result.getErrors()[0].getMessage()
                    );
                }
            }
        }
    }
}

