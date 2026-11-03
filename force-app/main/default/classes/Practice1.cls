public class Practice1 {
    public static void newpracticeMethod(List<contact> newContactList){
        System.debug('Inserted contacts' + newContactList);
        for(contact con : newContactList){
            if(con.email == null){
                con.addError('Email is mandatory');
            }
        }
    }
}