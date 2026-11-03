// If Email is blank, prevent the Contact from being saved.
// If Email is provided, convert it to lowercase.
// If the Contact's Department is "Sales", automatically set LeadSource to Web.
// Otherwise, set LeadSource to Other.

public with sharing class ContactEmailBlankHandler {
    public static void ContacttMethodOne(List<Contact> contacts) {
            for(Contact con : contacts){
                if(String.isBlank(con.Email)){
                    con.Email.addError('Email is required');
                }else {
                    con.Email = con.Email.toLowerCase();
                }if(con.Department == 'Sales'){
                    con.LeadSource = 'Web';
                }else{
                    con.LeadSource = 'Other';
                }
            }
    }
}