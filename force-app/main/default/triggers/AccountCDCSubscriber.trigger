trigger AccountCDCSubscriber on AccountChangeEvent (after insert) {
    CDCExample.handleContactChangeEvent(Trigger.New);
}
