@isTest
  private class DailyOppAmountTest  { 
     
static testMethod void checkDailyOpp (){
 date mydate = date.parse('05/11/2012');
   Opportunity accRec = new Opportunity( Name ='pritiOpp',
Amount = 100,
IsAggregated__c =false,
StageName='Closed Won',
CloseDate=system.today());
   insert accRec ;
   Test.StartTest();
   DailyOppAmountAggregate  objBatch = new DailyOppAmountAggregate ();
   ID batchprocessid = Database.executeBatch(objBatch);
   Test.StopTest();
  
     Opportunity newopp=[Select IsAggregated__c from Opportunity where  Name ='pritiOpp'] ;
   List<AsyncApexJob> apexJob = [SELECT Status FROM AsyncApexJob where id=:batchprocessid ];
        for(AsyncApexJob aj : apexJob )
      {  if(aj.status=='Completed')     
   System.assertEquals(true,newopp.IsAggregated__c);
  }
  }
}