public class NewContactTriggerHandler {

    public static void handleBeforeInsert(List<Contact> contacts) {

        for (Contact con : contacts) {

            if (con.Department == 'Sales') {
                con.LeadSource = 'Web';
            }
        }
    }
}