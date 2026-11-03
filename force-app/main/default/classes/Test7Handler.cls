/**
 * @description       : 
 * @author            : Sathvika B
 * @group             : 
 * @last modified on  : 07-16-2026
 * @last modified by  : Sathvika B
**/
public class Test7Handler {
    public static void AccountMethd(List<Account> newAcc){
             for(Account acc : accList){
                if(acc.CreatedDate == System.now().addDays(-7)){
                    acc.addError('This record cant be deleted as it is created 7 days back');
                }
       }
    }          
}