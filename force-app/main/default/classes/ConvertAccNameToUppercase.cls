public class ConvertAccNameToUppercase {
    public static void convertUppercase(List<Account> accList){
        for(Account acc : accList){
            if(acc.Name != null){
            acc.Name = acc.Name.toUpperCase();
        } 
        }
}
}