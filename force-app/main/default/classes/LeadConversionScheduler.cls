public class LeadConversionScheduler implements Schedulable {
    public void execute(SchedulableContext sc) {
        LeadConversionBatch batch = new LeadConversionBatch();
        Database.executeBatch(batch, 100);
    }
}