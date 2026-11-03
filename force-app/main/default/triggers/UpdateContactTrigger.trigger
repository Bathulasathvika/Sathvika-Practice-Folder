trigger UpdateContactTrigger on Account (after update) {
    if(Trigger.isUpdate && Trigger.isAfter){
        UpdateContact.updateContactIndustry(Trigger.new, Trigger.oldMap);
    }
}