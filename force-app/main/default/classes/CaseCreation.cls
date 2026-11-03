//whenever a case is created with origin as email then set status as new and priority as medium
public class CaseCreation {
    public static void newCaseTask(List<Case> caseList){
        for(case newCase : caseList){
            if(newCase.Origin == 'email'){
                newCase.status='priority';
                newCase.priority='medium';
            }
        }
    }
}