// Use .apex files to store anonymous Apex.
// You can execute anonymous Apex in VS Code by selecting the
//     apex text and running the command:
//     SFDX: Execute Anonymous Apex with Currently Selected Text
// You can also execute the entire file by running the command:
//     SFDX: Execute Anonymous Apex with Editor Contents

string tempvar = 'Enter_your_name_here';
System.debug('Hello World!');
System.debug('My name is ' + tempvar);


BatchEx1 batch = new BatchEx1();
Database.executeBatch(batch, 2);

BatchEx4 batch4 = new BatchEx4();
Database.executeBatch(batch4, 6);

countprocessedrecords records = new countprocessedrecords();
Database.executeBatch(records, 5);

System.enqueueJob(new QueueableExampleClass());

System.enqueueJob(new QueueableExampleClass());




List<customer__c> newList = new List<customer__c>();
for(integer i=0;i<10000;i++){
customer__c cs =new customer__c();
cs.customername__c = 'Sathvika ' + i;
newList.add(cs);
}
Database.Insert(newList, true);



Id jobId = System.enqueueJob(new CreatingAccConTask());

Database.executeBatch(new LeadConversionBatch(), 10);

String cronExp = '0 0 * * * ?'; 
System.schedule('Hourly Lead Conversion System Job', cronExp, new LeadConversionScheduler());



LeadDeduplicateAndConvertBatch batchInstance = new LeadDeduplicateAndConvertBatch();
Id jobId = Database.executeBatch(batchInstance, 100);
System.debug('Batch successfully started with Job ID: ' + jobId);


Id jobId = Database.executeBatch(new LeadConversion(), 50);
System.debug('Batch Job Id: ' + jobId);

// QTOrgOneCalloutClass.sendLeadToOrgB('00QgK00000VLKMrUAP');


// Database.executeBatch(new QTSyncBatch(), 10);

// Id sourceLeadId = '00QgK00000UoOJAUA3';
// System.enqueueJob(new QTOrgOneCalloutClass(sourceLeadId));


//LeadCreationFromOrgOne.leadTransfer('00QgK00000VLPcfUAH');

CreateQtApexclass.dummyLeads(
    '00QgK00000VLoHhUAL'
);



System.schedule(
    'Hourly Lead Deduplication',
    '0 0 * * * ?',
    new HourlyLeadDeduperScheduler()
);

Database.executeBatch(new LeadMergeService(), 100);

set<Id> leadIds = new set<Id>{'00QgK00000VTEQjUAP', '00QgK00000VTNgvUAH'};

LeadMergeService.mergeDuplicates(leadIds);