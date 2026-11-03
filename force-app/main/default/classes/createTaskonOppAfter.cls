public class createTaskonOppAfter {
    public static void newTask(List<Opportunity> oppTask){
        List<Task> tsk = new List<Task>();
        for(Opportunity opt : oppTask){
            if(opt.stagename == 'closed won'){
                task ts = new task();
                ts.Subject='congratualations';
                
                
                tsk.add(ts);
            }
        }
        if(!tsk.isEmpty()){
            insert tsk;
        }
}
}