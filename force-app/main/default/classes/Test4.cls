public class Test4 {
    public static void accOppCon(List<Account> AccRecList){
        
        List<Contact> conList = new List<Contact>();
        List<Opportunity> oppList = new List<Opportunity>();
        
        for(Account acRec : AccRecList){
            if(acRec.Contact__c == true){
                Contact con = new Contact();
                con.Lastname = acRec.Name + ' contact';
                con.AccountId = acRec.Id;
                
                conList.add(con);
            } 
         }
        for(Account acRec : AccRecList){
                if(acRec.Opportunity__c && acRec.Active__c =='Yes'){
                Opportunity opp = new Opportunity();
                opp.Name = acRec.Name + ' opportunity';
                opp.Amount = 100000;
                opp.StageName = 'Closed won';
                opp.CloseDate = System.today();
                opp.AccountId = acRec.Id;
                
                oppList.add(opp);
            }
        }
        if(!conList.isEmpty()){
            insert conList;
        }
        if(!oppList.isEmpty()){
            insert oppList;
        }
    }
}