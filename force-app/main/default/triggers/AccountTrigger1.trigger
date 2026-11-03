trigger AccountTrigger1 on Account(before Insert,before Update){
   if(Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate)){
      AccPhoneUpdate.phoneFieldUpdate(Trigger.new, Trigger.oldMap);
   }
}