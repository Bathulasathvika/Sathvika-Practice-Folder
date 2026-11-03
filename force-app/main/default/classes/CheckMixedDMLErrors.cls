public with sharing class CheckMixedDMLErrors{
    @future
    public static void CheckMixedDMLErrorsforAccount(){
    User us = new User();
    us.FirstName='ragviandVishwa';
    us.LastName='Tech';
    us.Alias='techhh';
    us.Email='ragvivishwatech@gmail.com';
    us.Username='rvtech@new.com';
    us.ProfileId='00egK00000BZ14XQAT';
    us.TimeZoneSidKey='Asia/Kolkata';
    us.LocaleSidKey='en_US';
    us.EmailEncodingKey='UTF-8';
    us.LanguageLocaleKey='en_US';
    insert us;
  
    Account acc = new Account();
    acc.name = 'newSathvikaAcc';
    insert acc;
    }
}