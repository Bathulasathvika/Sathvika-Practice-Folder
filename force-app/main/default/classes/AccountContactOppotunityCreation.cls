public  class AccountContactOppotunityCreation {
    public static void AccConOpp(List<Account> accIds) {

        List<Contact> InsertContact = new List<Contact>();
        List<Opportunity> InsertOpportunity = new List<Opportunity>();

        for(Account acc : accIds){
            if(acc.Contact__c == true){
                 Contact con = new Contact();
                con.LastName = 'SathwikaRT';
                con.Email = 'RTRetail@gmail.com';

                InsertContact.add(con);
            }    
              if(acc.Opportunity__c == true && acc.Active__c == 'Yes'){
                Opportunity opp = new Opportunity();
                opp.Name = 'SathwikaRTOpp';
                opp.CloseDate = Date.newInstance(2026, 10, 31);
                opp.StageName = 'Prospecting';

                InsertOpportunity.add(opp);
              }
              if(!InsertContact.isEmpty()){
                insert InsertContact;
              }

              if(!InsertOpportunity.isEmpty()){
                insert InsertOpportunity;
              }
            }
        }
    }