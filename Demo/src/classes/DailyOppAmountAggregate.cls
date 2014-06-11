global class DailyOppAmountAggregate implements Database.Batchable<sObject>,Database.stateful
{
   global Decimal TotalAmount=0;
   global Integer i=0;
   global Double hours=0;
   global Database.QueryLocator start(Database.BatchableContext BC){
      return Database.getQueryLocator([SELECT ID,Name,Amount FROM Opportunity WHERE StageName='Closed Won' AND CreatedDate=TODAY  ]);
   }

   global void execute(Database.BatchableContext BC, List<Opportunity> scope){
      List<Opportunity> ListOpportunity=new List<Opportunity>();
      
     for(Opportunity sobj : scope){
         i++;
      //   Opportunity opp= (Opportunity)sobj ;
         TotalAmount = TotalAmount+sobj .Amount;
        // opp.Name=opp.Name+'ABC';
        sobj .IsAggregated__c=true;
         ListOpportunity.add(sobj );
     }
     
        
         update ListOpportunity;
         system.debug('total amount'+Totalamount);     
    }

   global void finish(Database.BatchableContext BC){
    List<String> emailid=new List<String>();
    List<User> user_email=[select user.Email FROM user , user.profile where user.profile.name='System Administrator'];
        for(User u:user_email)
        {
            if(u.Email!=Null)
            {
            emailid.add(u.Email);
            }
        }
    
   Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        
        mail.setToAddresses(emailid);
        mail.setSenderDisplayName('Batch Processing');
        mail.setSubject('Daily Opportunity Amount Aggregator Job Complete');
        AsyncApexJob a = [SELECT CreatedDate,CompletedDate FROM AsyncApexJob WHERE Id = :BC.getJobId()];
        if(a.CompletedDate != NULL &&  a.CreatedDate!= NULL)
        {
            hours = ((a.CompletedDate.getTime()  - a.CreatedDate.getTime()) / (1000.0*60.0*60.0));
        }
        mail.setHtmlBody('The batch job for Daily Opportunity Amount Aggregation is completed successfully. The details associated with the job are as follows Total Opportunity Amount for today '+TotalAmount+'<br>Start date'+a.CreatedDate+'<br> End DATE'+a.CompletedDate+'Number of Opportunities Closed Won Today'+i+'Total Duration for Job Completion in Hours'+hours );
    
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail});
   }
   
   }