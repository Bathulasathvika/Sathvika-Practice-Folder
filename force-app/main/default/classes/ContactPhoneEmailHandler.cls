public with sharing class ContactPhoneEmailHandler {

    public static void setPhoneEmailFieldManadatory(List<Contact> conNewList){
        for(Contact con : conNewList){
            if(String.isBlank(con.Email)){
                con.addError('Email is required');
            }
            if(String.isBlank(con.Phone)){
                con.addError('Phone is required');
            }
        }
    }
}