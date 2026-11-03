trigger AutopopulateTrigger on Account (before insert) {
    for(Account ac : Trigger.new){
        if(ac.Description == null){
            ac.Description = 'new description is created with trigger';
        }
    }
}