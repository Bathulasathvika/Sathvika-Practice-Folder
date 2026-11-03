public with sharing class OrderApexHandler {

    public static void OrderApexHandlerMethod() {

        List<Order_Confirmed_Event__e> events =
            new List<Order_Confirmed_Event__e>();

        for (Order orderRecord : Trigger.New) {

            Order oldOrder =
                (Order) Trigger.OldMap.get(orderRecord.Id);

            if (
                orderRecord.Status == 'Confirmed' &&
                oldOrder.Status != 'Confirmed'
            ) {

                Order_Confirmed_Event__e eventRecord =
                    new Order_Confirmed_Event__e();
                eventRecord.Order_Number__c = orderRecord.Order_Number__c;
                eventRecord.Customer_Name__c = orderRecord.Customer_Name__c;
                events.add(eventRecord);
            }
        }
        if (!events.isEmpty()) {
            EventBus.publish(events);
        }
    }
}