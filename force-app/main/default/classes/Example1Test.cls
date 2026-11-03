@isTest
public with sharing class Example1Test {
    @isTest
    static void ExtestMethod() {
       Integer result = Example1.add(10, 20);
       System.assertEquals(30, result);
    }
}