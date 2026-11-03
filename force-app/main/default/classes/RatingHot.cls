//when rating is hot cant be modified to another rating
public class RatingHot {
    public static void checkRating(List<Account> newAcc, Map<ID, Account> oldmapRating){
        for(Account acc : newAcc){
            Account status = oldmapRating.get(acc.ID);
            if(status.Rating == 'Hot' && acc.Rating != 'Hot'){
                acc.rating.addError('Rating must be Hot');
            }
        }
    }
}