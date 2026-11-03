public class LeadTriggerHandler {

    public static void afterInsert(Set<Id> leadIds) {
        if (leadIds == null || leadIds.isEmpty()) {
            return;
        }

        Set<Id> survivingIds =
            LeadMergeService.mergeDuplicates(leadIds);

        // Keep the existing Target Org sync class unchanged.
        if (!survivingIds.isEmpty()) {
            LeadSyncService.sendLeadsToDummyOrg(survivingIds);
        }
    }

    public static void afterUpdate(
        List<Lead> newLeads,
        Map<Id, Lead> oldMap
    ) {
        Set<Id> changedLeadIds = new Set<Id>();
        Set<Id> leadsToConvert = new Set<Id>();

        for (Lead ld : newLeads) {
            Lead oldLead = oldMap.get(ld.Id);

            if (oldLead == null) {
                continue;
            }

            if (
                ld.Email != oldLead.Email ||
                ld.Phone != oldLead.Phone
            ) {
                changedLeadIds.add(ld.Id);
            }

            if (
                ld.Status == 'Closed Converted' &&
                !ld.IsConverted
            ) {
                leadsToConvert.add(ld.Id);
            }
        }

        if (!changedLeadIds.isEmpty()) {
            LeadMergeService.mergeDuplicates(changedLeadIds);
        }

        if (!leadsToConvert.isEmpty()) {
            LeadConversionService.convertLeads(leadsToConvert);
        }
    }
}


