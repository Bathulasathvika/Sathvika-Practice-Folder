public class LeadSyncService {

    @future(callout=true)
    public static void sendLeadsToDummyOrg(Set<Id> leadIds) {

        List<Lead> leads = [
            SELECT Id, FirstName, LastName, Company, Email, Status
            FROM Lead
            WHERE Id IN :leadIds
        ];>

        List<Map<String, Object>> payload =
            new List<Map<String, Object>>();

        for (Lead ld : leads) {
            payload.add(new Map<String, Object>{
                'sourceLeadId' => String.valueOf(ld.Id),
                'firstName' => ld.FirstName,
                'lastName' => ld.LastName,
                'company' => ld.Company,
                'email' => ld.Email,
                'status' => ld.Status
            });
        }

        HttpRequest req = new HttpRequest();
        req.setEndpoint(
            'callout:Sourceorg_Nc/services/apexrest/Lead/'
        );
        req.setMethod('POST');
        req.setHeader('Content-Type', 'application/json');
        req.setBody(JSON.serialize(payload));

        try {
            Http http = new Http();
            HttpResponse res = http.send(req);

            System.debug('Status: ' + res.getStatusCode());
            System.debug('Response: ' + res.getBody());

            if (res.getStatusCode() != 200) {
                return;
            }

            List<Object> responses =
                (List<Object>) JSON.deserializeUntyped(res.getBody());

            List<Lead> updates = new List<Lead>();

            for (Object item : responses) {
                Map<String, Object> data =
                    (Map<String, Object>) item;

                if (data.get('status') == 'Success'
                    && data.get('sourceLeadId') != null
                    && data.get('targetLeadId') != null) {

                    updates.add(new Lead(
                        Id = (Id) String.valueOf(
                            data.get('sourceLeadId')
                        ),
                        Dummy_Org_Lead_Id__c =
                            String.valueOf(data.get('targetLeadId'))
                    ));
                }
            }

            if (!updates.isEmpty()) {
                update updates;
            }

        } catch (Exception e) {
            System.debug('Lead sync error: ' + e.getMessage());
        }
    }
}

