public class CDCExample{
    public static void handleContactChangeEvent(List<ContactChangeEvent> events) {
        EventBus.ChangeEventHeader header = event.ChangeEventHeader;
        // Extract required metadata fields
        String changeType = header.changeType; // CREATE, UPDATE, DELETE, UNDELETE
        Long commitTimestamp = header.commitTimestamp; // Change Timestamp
        List<String> recordIds = header.recordIds; // Record IDs affected
        List<String> changedFields = header.changedFields; // List of modified fields
        
        System.debug('--- CDC Notification Received ---');
        System.debug('Record IDs: ' + recordIds);
        System.debug('Change Type: ' + changeType);
        System.debug('Commit Timestamp: ' + commitTimestamp);
        System.debug('Changed Fields: ' + changedFields);
        System.debug('Account Name Field Payload: ' + event.Name);
    }
}
