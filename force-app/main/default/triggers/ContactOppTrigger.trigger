trigger ContactOppTrigger on Contact (After Update) {
   if(Trigger.isAfter && Trigger.isUpdate){
    ContactOppTriggerHandler.ContactOppMethodOne(Trigger.new, Trigger.oldMap);
   }
}