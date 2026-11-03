trigger CreateContactAutomaticallyWhenAccountIsCreated on Account (after insert) {
    List<Contact> contacts = new List<Contact>();
    for(Account ac : Trigger.new){
        Contact con = new Contact();
        con.LastName = ac.name + 'Contact';
        con.AccountId = ac.id;
        con.Phone = '8885755404';
        contacts.add(con);
    }
    if(!contacts.isEmpty()){
        insert contacts;
    }
}