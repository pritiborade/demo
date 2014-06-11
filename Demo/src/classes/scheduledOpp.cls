global class scheduledOpp implements Schedulable {

global scheduledOpp (){
        scheduledOpp p = new scheduledOpp();
        
        String sch = '0 30 19 ? * MON-FRI';
        system.schedule('time sheet',sch,p);
        }
       global void execute(SchedulableContext SC) {
      DailyOppAmountAggregate M = new DailyOppAmountAggregate(); 
   } 
   
}