public class PreventContactEmailRemoval {
    public static void preventEmailRemoval(List<Contact> newConList, Map<ID, Contact> newMapconList){
        for(Contact conList : newConList){
            Contact conn = newMapconList.get(conList.ID);
            if(conList.email != null && conn.email == null){
               conn.email.addError('Cant remove the email');
            }
        }
    }
}