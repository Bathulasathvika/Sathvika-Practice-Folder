trigger OrderTrigger on Order (after insert) {
   if(Tigger.isAfter && Trigger.isInsert){
    OrderApexHandler.OrderApexHandlerMethod();
   }
}