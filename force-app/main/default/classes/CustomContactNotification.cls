public with sharing class CustomContactNotification {
    public static void notifyUsers(Set<String> recipientIds, Integer recordCount){
        CustomNotificationType notificationType = 
          [Select ID, DeveloperName from CustomNotificationType
            Where DeveloperName = 'New_Contact_Notification'
            With USER_MODE];
        Messaging.CustomNotification notification = new Messaging.CustomNotification();
        notification.setTitle('Trailhead Trigger Tutorial');
        notification.setBody(recordCount + 'contacts were inserted');
           notification.setNotificationTypeId(notificationType.Id);
        notification.setTargetId('000000000000000AAA');
        
        try{
            notification.send(recipientIds);
            System.debug('Sent successfully');
        }catch (Exception e){
            System.debug('error catched');
        }
    }
}