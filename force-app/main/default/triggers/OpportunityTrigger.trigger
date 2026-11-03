trigger OpportunityTrigger on Opportunity (after insert) {
if(Trigger.isAfter && Trigger.isInsert){
    OppAmountonAcc.OppAmount(Trigger.New);
}
}