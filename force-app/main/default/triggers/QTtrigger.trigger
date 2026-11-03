trigger QTtrigger on Lead (after insert) {
    for (Lead ld : Trigger.new) {
        QTOrgOneCalloutClass.sendLeadToOrgB(ld.Id);
    }
}

