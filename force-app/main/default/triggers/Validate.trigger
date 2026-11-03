trigger Validate on Trigger1_example__c (before insert, before update) {
    for(Trigger1_example__c tre : Trigger.new){
        if(tre.Salary__c != null && tre.Salary__c > 100000){
            tre.Salary_validation__c = 'Positive';
        }else{
            tre.Salary_validation__c = 'Negative';
        }
    }
}