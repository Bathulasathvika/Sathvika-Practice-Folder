trigger ContactNotificationTrigger on Contact (after insert) {
    if(Trigger.isInsert){
       Integer recordCount = Trigger.new.size();
        Set<String> recipientIds = new Set<String>{UserInfo.getUserId()};
            
    CustomContactNotification.notifyUsers(recipientIds, recordCount);
    }
    
}