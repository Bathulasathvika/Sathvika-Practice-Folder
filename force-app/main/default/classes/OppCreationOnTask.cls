//whenever opportunity is created automatically create task
public class OppCreationOnTask {
    public static void newOpp(List<Opportunity> listOpp){
        List<Task> newTask = new List<Task>();
        for(Opportunity op : listOpp){
            Task ts = new Task();
            ts.subject ='Task created';
            ts.Status ='prospecting';
            ts.priority ='Medium';
            ts.whatId=op.id;
            
            newTask.add(ts);
        
    }
        if(!newTask.isEmpty()){
            insert newTask;
   }
  }
}