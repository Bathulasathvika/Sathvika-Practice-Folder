trigger NewAccountTrigger on Account (before delete) {
    if(Trigger.isBefore && Trigger.isInsert){
        AccountHandler.newAccount(Trigger.new);
    }
    if(Trigger.isBefore && Trigger.isDelete){
        AccountoppDeletion.accOpp(Trigger.Old);
    }
}