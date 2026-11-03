// global class LeadDeduplicateAndConvertBatch implements Database.Batchable<SObject>, Database.Stateful {
    
//     global Database.QueryLocator start(Database.BatchableContext bc) { 
//         return Database.getQueryLocator([ 
//             SELECT Id, Name, Email, Phone 
//             FROM Lead 
//             WHERE IsConverted = false 
//             ORDER BY CreatedDate ASC 
//         ]); 
//     } 
    
//     global void execute(Database.BatchableContext bc, List<SObject> scope) { 

//         Set<String> names = new Set<String>(); 
//         Set<String> emails = new Set<String>(); 
//         Set<String> phones = new Set<String>(); 
        
//         for (SObject s : scope) { 
//             Lead l = (Lead)s; 
//             if (!String.isBlank(l.Name)) names.add(l.Name); 
//             if (!String.isBlank(l.Email)) emails.add(l.Email); 
//             if (!String.isBlank(l.Phone)) phones.add(l.Phone); 
//         } 
        
//         List<Lead> queriedScope = [ 
//             SELECT Id, Name, Email, Phone 
//             FROM Lead 
//             WHERE IsConverted = false 
//             AND (Name IN :names OR Email IN :emails OR Phone IN :phones) 
//             ORDER BY CreatedDate ASC 
//         ]; 

//         Map<String, Lead> masterByNameEmail = new Map<String, Lead>();
//         Map<String, Lead> masterByNamePhone = new Map<String, Lead>();
//         Map<String, Lead> masterByEmailPhone = new Map<String, Lead>();
        
//         List<Lead> allDuplicateLeads = new List<Lead>();
//         Map<Id, Id> duplicateToMasterIdMap = new Map<Id, Id>();
        
//         for (Lead ld : queriedScope) {
//             Lead foundMaster = null;
            
//             String ln = String.isBlank(ld.Name) ? '' : ld.Name.toLowerCase();
//             String em = String.isBlank(ld.Email) ? '' : ld.Email.toLowerCase();
//             String ph = String.isBlank(ld.Phone) ? '' : ld.Phone;

//             String nameEmailKey = (!String.isBlank(ln) && !String.isBlank(em)) ? (ln + '||' + em) : null;
//             String namePhoneKey = (!String.isBlank(ln) && !String.isBlank(ph)) ? (ln + '||' + ph) : null;
//             String emailPhoneKey = (!String.isBlank(em) && !String.isBlank(ph)) ? (em + '||' + ph) : null;
            
//             if (nameEmailKey != null && masterByNameEmail.containsKey(nameEmailKey)) {
//                 foundMaster = masterByNameEmail.get(nameEmailKey);
//             } else if (namePhoneKey != null && masterByNamePhone.containsKey(namePhoneKey)) {
//                 foundMaster = masterByNamePhone.get(namePhoneKey);
//             } else if (emailPhoneKey != null && masterByEmailPhone.containsKey(emailPhoneKey)) {
//                 foundMaster = masterByEmailPhone.get(emailPhoneKey);
//             }
            
//             if (foundMaster != null && foundMaster.Id != ld.Id) {
//                 allDuplicateLeads.add(ld);
//                 duplicateToMasterIdMap.put(ld.Id, foundMaster.Id);
//             } else {

//                 if (nameEmailKey != null && !masterByNameEmail.containsKey(nameEmailKey)) {
//                     masterByNameEmail.put(nameEmailKey, ld);
//                 }
//                 if (namePhoneKey != null && !masterByNamePhone.containsKey(namePhoneKey)) {
//                     masterByNamePhone.put(namePhoneKey, ld);
//                 }
//                 if (emailPhoneKey != null && !masterByEmailPhone.containsKey(emailPhoneKey)) {
//                     masterByEmailPhone.put(emailPhoneKey, ld);
//                 }
//             }
//         }

//         Map<Id, List<Lead>> chunkMap = new Map<Id, List<Lead>>();
        
//         for (Lead duplicateLead : allDuplicateLeads) {
//             Id masterId = duplicateToMasterIdMap.get(duplicateLead.Id);
         
//             if (!chunkMap.containsKey(masterId)) {
//                 chunkMap.put(masterId, new List<Lead>());
//             }
            
//             chunkMap.get(masterId).add(duplicateLead);

//             if (chunkMap.get(masterId).size() == 2) {
//                 try {
//                     Database.merge(new Lead(Id = masterId), chunkMap.get(masterId));
//                 } catch (DmlException e) {
//                     System.debug('Merge error for Master ' + masterId + ': ' + e.getMessage());
//                 }
//                 chunkMap.remove(masterId);
//             }
//         }
        
//         for (Id masterId : chunkMap.keySet()) {
//             try {
//                 Database.merge(new Lead(Id = masterId), chunkMap.get(masterId));
//             } catch (DmlException e) {
//                 System.debug('Merge error for leftover Master ' + masterId + ': ' + e.getMessage());
//             }
//         }
//     } 

//     global void finish(Database.BatchableContext bc) { 
//         System.debug('Hourly Lead Deduplication Completed. Chain launching Lead Conversion Batch...'); 
        
//     }  
// }