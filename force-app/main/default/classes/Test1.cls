public class Test1 {
    public static void oppAmount(List<Opportunity> oppList){
        for(Opportunity opp : oppList){
            if(opp.Amount != null && opp.Amount > 100000){
                opp.Description='Hot Opportunity';
            }
        }
    }
}