trigger NewContactTrigger on Contact (before insert) {

    NewContactTriggerHandler.handleBeforeInsert(Trigger.new);
}