trigger LeadMasterTrigger on Lead (after insert, after update) {

    if (Trigger.isAfter && Trigger.isInsert) {
        LeadTriggerHandler.afterInsert(Trigger.newMap.keySet());
    }

    if (Trigger.isAfter && Trigger.isUpdate) {
        LeadTriggerHandler.afterUpdate(
            Trigger.new,
            Trigger.oldMap
        );
    }
}






