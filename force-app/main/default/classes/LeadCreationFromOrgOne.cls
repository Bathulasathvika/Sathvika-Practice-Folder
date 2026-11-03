public class LeadCreationFromOrgOne {

   
    public static void leadTransfer(Id leadId) {
        try {
            
            Lead ld = [
                SELECT FirstName, LastName, Company, Email, Phone, Title, Status
                FROM Lead
                WHERE Id = :leadId
                LIMIT 1
            ];
 
            Map<String, Object> leadData = new Map<String, Object>();
            leadData.put('FirstName', ld.FirstName);
            leadData.put('LastName', ld.LastName);
            leadData.put('Company', ld.Company);
            leadData.put('Email', ld.Email);
            leadData.put('Phone', ld.Phone);
            leadData.put('Title', ld.Title);
            leadData.put('Status', ld.Status);

            HttpRequest req = new HttpRequest();
            req.setEndpoint('callout:QTNamedCredential/services/data/v65.0/sobjects/Lead/');
            req.setMethod('POST');
            req.setHeader('Content-Type', 'application/json');
            req.setBody(JSON.serialize(leadData));
            req.setTimeout(120000);

            
            Http http = new Http();
            HttpResponse res = http.send(req);

            
            System.debug('HTTP Status Code: ' + res.getStatusCode());
            System.debug('Response Body: ' + res.getBody());

            if (res.getStatusCode() == 201) {
                System.debug('SUCCESS: Lead created successfully in Target Org.');
            } else {
                System.debug('FAILED: Lead was not created. Check response details.');
            }

        } catch (Exception e) {
            System.debug('ERROR: ' + e.getMessage());
            System.debug('LINE: ' + e.getLineNumber());
        }
    }
}
