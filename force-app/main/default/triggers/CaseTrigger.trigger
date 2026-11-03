trigger CaseTrigger on Case (After insert) {
    if(Trigger.isAfter && Trigger.isInsert){
       UpdateCaseIdInAcc.UpdateAcc(Trigger.new);
    }
}