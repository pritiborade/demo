@isTest

private class ApexRestSampleTest {

    static testMethod void myUnitTest() {

        
         System.debug('STATUS:BEFORE Apex CLASS CALL');
         Map<String,String> result= MyRestResource.doPost('priti','borade','1234','p@gmail.com','espl');
         //Map<String,String> result1= MyRestResource.doDelete();
         String res=MyRestResource.doUpdate('a','a');
         System.debug('STATUS:AFTER*** Apex CLASS CALL');

         System.assert(true);

   }

}