// The Contact's Email must be unique.
// If another Contact already has the same email, don't allow the new Contact to be created.
// The email comparison should be case-insensitive.
// These should all be considered the same email.
// If there is no duplicate, convert the new Contact's email to lowercase before saving.


public with sharing class PreventDuplicateContacts {
    public static void DuplicateContacts(List<Contact> contacts) {
        //new mails
        Set<String> newEmails = new Set<String>();
        for(Contact con : contacts){
            if(!String.isBlank(con.Email)){
               newEmails.add(con.Email.toLowerCase());
            }
        }
        //Querying Contacts with these Emails 
        List<Contact> oldEmails = [
            Select Id, Lastname, Email from contacts Where Email IN: newEmails
        ];
      //storing Contacts which have same email 
      Set<String> ExistingEmails = new Set<String>();

      for(Contact oldCon : oldEmails){
        ExistingEmails.add(con.oldMails.toLowerCase());
      }
      for(Contact conEmail : Contacts){
        if (!String.isBlank(con.Email)) {
                String email = con.Email.toLowerCase();
      if(ExistingEmails.contains(newEmails)){
        conEmail.Email.addError('Email Already Exists');
      }else{
        con.Email = email;
      }
    }
}
}
}