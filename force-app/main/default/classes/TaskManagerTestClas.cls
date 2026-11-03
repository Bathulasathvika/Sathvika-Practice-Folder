@isTest
public class TaskManagerTestClas {
   @isTest
   public static void testCreateTask() {
    String subject = 'Test Subject'=;
    String description = 'Test description';

    Test.startTest();
    TaskManager.createTask(subject, description);
    Test.stopTest();

    List<Task> taskList = [SELECT Id, Subject, Description FROM Task WHERE Subject = :subject];

   System.assertEquals(1, taskList.size(), 'Task should have been created');
}

@isTest
public static void testUpdateTask() {
    Task t = new Task(Subject = 'Old Subject', Description = 'Old description');
    insert t;

    String newSubject = 'New Subject';
    String newDescription = 'New description';

    Test.startTest();
    TaskManager.updateTask(t.Id, newSubject, newDescription);
    Test.stopTest();

    Task updatedTask = [SELECT Id, Subject, Description FROM Task WHERE Id = :t.Id];

    System.assertEquals(newSubject, updatedTask.Subject, 'Subject should be updated');
    System.assertEquals(newDescription, updatedTask.Description, 'Description should be updated');
}

@isTest
public static void testDeleteTask() {

    Task t = new Task(Subject = 'Delete test', Description = 'Delete test');
    insert t;

    Test.startTest();
    TaskManager.deleteTask(t.Id);
    Test.stopTest();

    List<Task> deletedTaskList = [SELECT Id FROM Task WHERE Id = :t.Id];

    System.assertEquals(0, deletedTaskList.size(), 'Task should be deleted');
}
}