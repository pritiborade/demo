public class ManagePo{

List<powrapper> orderList = new List<powrapper>();
List<order__c> selectedPO = new List<order__c>();

 public List<powrapper> getOrders()
      {
      	 orderList.clear();
          for(order__c a : [select Name,Opportunity_Name__c,Order_date__c,Order_No__c from order__c ])
          orderList.add(new powrapper(a));
          return orderList;
      }
      
   public PageReference getSelected()
      {
          selectedPO.clear();
          for(powrapper accwrapper : orderList)
          if(accwrapper.selected == true)
          selectedPO.add(accwrapper.acc);
          return null;
      }
       
      public List<order__c> GetSelectedPO()
      {
          if(selectedPO.size()>0)
          return selectedPO ;
          else
          return null;
      }   
       
      public class powrapper
      {
          public order__c acc{get; set;}
          public Boolean selected {get; set;}
          public powrapper(order__c a)
          {
              acc = a;
              selected = false;
          }
      }
      
      
      public PageReference  deletePO()
     {
     	if(selectedPO.size()==0)
 		{
 	  ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Select Atleast One Order From The List');
      ApexPages.addMessage(myMsg); 
       return null;
 		}
        List<order__c> o=[Select Id from order__c where Id IN :selectedPO ];
        
        for(order__c od:o)
        {
         delete od;
        }
        PageReference reRend1 = new PageReference('https://na15.salesforce.com/a06/o '); 
          return reRend1;
     }
     public PageReference updatePO()
     {
     	PageReference reRend1 = new PageReference('/apex/OrderMassEdit');  
          return reRend1;
     }

}