trigger UpdateFutureTrigger on Account (After insert) {
   if(Trigger.isAfter && Trigger.isInsert){
    updateAccountDescFuture.futureMethodEx(Trigger.newMap.keySet());
   }
}