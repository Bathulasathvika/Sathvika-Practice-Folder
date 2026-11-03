public class TaskManager{
public static void createTask(String subject, String description) {
Task t = new Task();
t.Subject = subject;
t.Description = description;
insert t;
}

public static void updateTask(Id taskId, String subject, String description) {
    Task t = [SELECT Id, Subject, Description FROM Task WHERE Id = :taskId];
    t.Subject = subject;
    t.Description = description;
    update t;
}

public static void deleteTask(Id taskId) {
    Task t = [SELECT Id FROM Task WHERE Id = :taskId];
    delete t;
}
}