trigger Test1Trigger on Opportunity (before insert, before update) {
    if(Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate)){
        Test1.oppAmount(Trigger.new);
    }
}