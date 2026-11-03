trigger ConvertnametoUppercase on Trigger1_example__c (before insert, before update) {
    for(Trigger1_example__c tr : Trigger.new){
        if(tr.name__c != null){
            tr.name__c = tr.name__c.toUpperCase();
        }
    }
}