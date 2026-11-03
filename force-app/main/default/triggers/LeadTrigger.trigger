trigger LeadTrigger on Lead (before insert, before update, after update) {
    for(Lead ld : Trigger.new){
        ld.Industry='Agriculture';
        ld.City='Hyderabad';
    }
}