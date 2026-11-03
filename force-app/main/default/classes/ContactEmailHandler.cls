public with sharing class ContactEmailHandler {
    public static void ContactEmailMethod(List<contact> conList) {
       for(Contact con : conList){
        if(String.isBlank(con.Email)){
            con.addError('email is mandatory');
        }
       }
    }
}