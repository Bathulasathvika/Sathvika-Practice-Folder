public with sharing class MethodInMethod {
    public static void MethodInMethod1() {
          String str = 'sathvika';
          MethodInMethod2();
    }
    public static void MethodInMethod2(){
        String str2 = 'swathi';
    }
    MethodInMethod mm = new MethodInMethod();
    mm.MethodInMethod1();
}