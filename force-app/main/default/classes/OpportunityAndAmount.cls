//if opportunity is closed won then amount can't be changed
public class OpportunityAndAmount {
    public static void oppAmount(List<Opportunity> newOpp, Map<Id, Opportunity> oldOpp){
        for(Opportunity opp : newOpp){
            Opportunity mapOpp = oldOpp.get(opp.id);
            if(opp.Amount == mapOpp.Amount){
                return;
            }else if(opp.StageName == 'closed won'){
                opp.addError('Amount cant be modified');
            }
        }
    }
}