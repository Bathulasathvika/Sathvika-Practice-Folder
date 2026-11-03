public class CreateQtApexclass {

    
    @future(callout=true)
    public static void dummyLeads(Id leadId) {
        Lead ld = [
            SELECT FirstName, LastName, Company,
                   Email, Phone, Title, Status
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
        
       
        req.setEndpoint('callout:Sourceorg_Nc/services/apexrest/Lead/');
        req.setMethod('POST');
        req.setHeader('Content-Type', 'application/json');
        req.setBody(JSON.serialize(leadData));

        Http http = new Http();
        
        try {
            HttpResponse res = http.send(req);
            System.debug('Status Code: ' + res.getStatusCode());
            System.debug('Response: ' + res.getBody());

            
            if (res.getStatusCode() == 201) {
                Map<String, Object> responseData = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
                
              
                String targetLeadId = (String) responseData.get('id');
                System.debug('Target Org Lead ID: ' + targetLeadId);

                
                ld.Dummy_Org_Lead_Id__c = targetLeadId;
                
                
                LeadTriggerHandler.isFirstRun = false; 
                update ld;
                LeadTriggerHandler.isFirstRun = true;
            } else {
                System.debug('Lead transfer failed with code ' + res.getStatusCode() + ': ' + res.getBody());
            }
        } catch(Exception e) {
            System.debug('Callout Error encountered: ' + e.getMessage());
        }
    }
}
