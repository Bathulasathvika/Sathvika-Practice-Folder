@isTest
private with sharing class ContactEmailHandlerTest {
    @TestSetup
    static void makeData(){
       Contact con = new Contact();
       con.LastName = 'Sathvikaaaa';
       con.Email = 'sathvi@gmail.com';
    }
    System.Assert()
}
