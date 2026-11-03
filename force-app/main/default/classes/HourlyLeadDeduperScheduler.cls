global class HourlyLeadDeduperScheduler implements Schedulable {
     global void execute(SchedulableContext sc) {
        Database.executeBatch(
            new LeadMergeService(),
            100
        );
    }
}
