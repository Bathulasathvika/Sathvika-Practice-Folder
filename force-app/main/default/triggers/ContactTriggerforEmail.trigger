trigger ContactTriggerforEmail on Contact (before insert) {
 if(Trigger.isBefore && Trigger.isInsert){
    ContactEmailHandler.ContactEmailMethod(Trigger.New), Trigger;
 }
}