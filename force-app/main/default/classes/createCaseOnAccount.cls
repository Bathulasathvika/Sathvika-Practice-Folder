public class createCaseOnAccount {
    public static void caseCreation(List<Account> ace){
        List<Case> newCase= new List<Case>();
        for(Account axe : ace){
           Case cse = new Case();
            cse.Origin = 'phone';
            cse.AccountId = axe.Id;
            cse.Status='new';
            cse.priority='high';
            
            newCase.add(cse);
            
        }
        if(!newCase.isEmpty()){
            insert newCase;
        }
        
    }
}