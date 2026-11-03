//create contact whenever account is created
public class relatedContacts {
   public static void checkRecords(List<Account> newAcc){
       List<Contact> newList = new List<Contact>();
        for(Account acc : newAcc){
            contact con = new contact();
            con.LastName=acc.name + 'contact';
            con.AccountId=acc.Id;
            
            newList.add(con);
       }
       if(!newList.isEmpty()){
           insert newList;
       }
        
}
}