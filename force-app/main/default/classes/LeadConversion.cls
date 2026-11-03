// global class LeadConversion implements Database.Batchable<SObject>, Database.Stateful {

//     global Database.QueryLocator start(Database.BatchableContext bc) {

//         return Database.getQueryLocator([
//             SELECT Id, FirstName, LastName, Company, Email, Phone, Status
//             FROM Lead
//             WHERE IsConverted = false
//             AND Status = 'Approved'
//         ]);
//     }

//     global void execute(
//         Database.BatchableContext bc,
//         List<SObject> scope
//     ) {

//         LeadStatus convertedStatus = [
//             SELECT MasterLabel
//             FROM LeadStatus
//             WHERE IsConverted = true
//             LIMIT 1
//         ];

//         List<Database.LeadConvert> leadsToConvert =
//             new List<Database.LeadConvert>();

//         for (SObject s : scope) {

//             Lead lead = (Lead)s;

//             if (lead.Status != 'Approved') {
//                 continue;
//             }

//             Database.LeadConvert leadConvert =
//                 new Database.LeadConvert();

//             leadConvert.setLeadId(lead.Id);
//             leadConvert.setConvertedStatus(
//                 convertedStatus.MasterLabel
//             );
//             leadConvert.setDoNotCreateOpportunity(true);

//             leadsToConvert.add(leadConvert);
//         }

//         if (!leadsToConvert.isEmpty()) {

//             Database.LeadConvertResult[] results =
//                 Database.convertLead(
//                     leadsToConvert,
//                     false
//                 );

//             for (Database.LeadConvertResult result : results) {

//                 if (result.isSuccess()) {

//                     System.debug(
//                         'Lead converted successfully: ' +
//                         result.getLeadId()
//                     );

//                 } else {

//                     for (Database.Error error :
//                         result.getErrors()) {

//                         System.debug(
//                             'Lead conversion failed for ' +
//                             result.getLeadId() +
//                             ': ' +
//                             error.getMessage()
//                         );
//                     }
//                 }
//             }
//         }
//     }

//     global void finish(Database.BatchableContext bc) {

//         System.debug(
//             'Approved Lead Conversion Batch Completed.'
//         );
//     }
// }