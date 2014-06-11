public class CreatePo
  {
      public String oppname{get;set;}
      public String quotename{get;set;}
      public String quoteaddress{get;set;}
      public String quotetoname{get;set;}
      public String quoteid{get;set;}
      public Static String new_id;
       public Date oppDate{get;set;}
       public Opportunity oppid;
      public List<QuoteLineItem> quoteLineItems{get;set;}
      public string OppStageSelected{get;set;}
       public List<Opportunity> oppIdList=new List<Opportunity>();
       public Opportunity opp;
       public Quote quote;
      public quote q;
        QuoteLineItem qli;
      Apexpages.Standardcontroller controller;
     public List<productwrapper> productList = new List<productwrapper>();
     public List<Product2> selectedProducts = new List<Product2>();
           public CreatePo(){
           q=new quote();
           quote =new Quote();
           }
      public List<productwrapper> getProducts()
      {	
      	  productList.clear();
          for(Product2 a : [select ProductCode,Name,Description from Product2 limit 5])
          productList.add(new productwrapper(a));
          return productList ;
      }
       
      public PageReference getSelected()
      {
          selectedProducts.clear();
          for(productwrapper accwrapper : productList)
          if(accwrapper.selected == true)
          selectedProducts.add(accwrapper.acc);
          return null;
      }
       
      public List<Product2> GetSelectedProducts()
      {
          if(selectedProducts.size()>0)
          return selectedProducts;
          else
          return null;
      }   
       
     public class productwrapper
      {
          public Product2 acc{get; set;}
          public Boolean selected {get; set;}
          public productwrapper(Product2 a)
          {
              acc = a;
              selected = false;
          }
      }
      public PageReference createOpp()
      {
             if(selectedProducts.size()!=0)
 			{
 				 List<OpportunityLineItem> oliList = new List<OpportunityLineItem>();
              List<QuoteLineItem > qliList = new List<QuoteLineItem >();
          opp=new Opportunity(Name=oppname,StageName=OppStageSelected,CloseDate=system.today()+30);
          insert opp;
          
          
          oppid=[Select id from Opportunity  where Name=:oppname];
          
          List<PriceBookEntry > PricebookList=new List<PriceBookEntry >();
          for(PriceBookEntry at:[Select p.UseStandardPrice, p.UnitPrice, p.SystemModstamp, p.ProductCode, p.Product2Id, p.Pricebook2Id, p.Name, p.LastModifiedDate, p.LastModifiedById, p.IsDeleted, p.IsActive, p.Id From PricebookEntry p  where p.Product2Id IN :selectedProducts  AND PriceBook2.isStandard=true ] )
          {
            
              PricebookList.add(at);
          }
      for (PriceBookEntry d: PricebookList) {
   
      
      OpportunityLineItem oli = new OpportunityLineItem(OpportunityId=opp.Id,PricebookEntryId=d.Id,Quantity=1,UnitPrice=d.UnitPrice );
      oliList.add(oli); 
     
      }
       insert oliList;
        
       
       
         q.Name=oppname;
         q.OpportunityId=oppid.Id;
     list<OpportunityLineItem >   lt =[Select PricebookEntryId,OpportunityId from OpportunityLineItem  where OpportunityId=:oppid.Id limit 1];
      PriceBookEntry   lt1 =[Select Pricebook2Id from PriceBookEntry  where Id=:lt[0].PricebookEntryId limit 1];
    q.Pricebook2Id=lt1.Pricebook2Id ;
    insert q;
     
     Quote qn=[Select id from Quote where Name=:q.Name];
    
       for (PriceBookEntry d: PricebookList) {
         qli=new QuoteLineItem(QuoteId=q.Id,PricebookEntryId=d.Id,Quantity=1,UnitPrice=d.UnitPrice);
      qliList.add(qli); 
     
      }
       insert qliList;
      
   
         PageReference pageRef = new PageReference('https://na15.salesforce.com/'+qn.id);
 
          return pageRef;
 				
 			}
 		else{
 	 			 ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Select Atleast One Product From The List');
     			 ApexPages.addMessage(myMsg); 
      			 return null;
 		}
         
 	
         
      }
      public List<SelectOption> getOpportyStage() {
        List<SelectOption> oppstagelist= new List<SelectOption>();
        oppstagelist.add(new SelectOption('Negotiation','Negotiation'));
        oppstagelist.add(new SelectOption('Proposal','Proposal'));
        oppstagelist.add(new SelectOption('Qualification','Qualification'));
        oppstagelist.add(new SelectOption('Closed Won','Closed Won'));
        oppstagelist.add(new SelectOption('Closed Lost','Closed Lost'));
        return oppstagelist;
    }
      
    /* public PageReference createQuote()
      {
            
            for(product2 s:selectedProducts){
            System.debug('list'+s.Name);
            } 
        String opportname = Apexpages.currentPage().getParameters().get('MyVariable');
         System.debug('id+++++'+opportname);
          oppid=[Select id from Opportunity  where Name=:opportname];
          Quote q=new Quote(Name=quotename,QuoteToName=quotetoname,OpportunityId=oppid.Id);
          insert q;
          PageReference reRend1 = new PageReference('/apex/ManageProduct');  
         reRend1.setRedirect(true);
        return reRend1;
        
      }*/
     public PageReference  getQuoteItem()
     {
           String qquoteid = Apexpages.currentPage().getParameters().get('MyVariable');
            PageReference reRend1 = new PageReference('/apex/PDF');  
         reRend1.getParameters().put('MyQuoteId',qquoteid );
        return reRend1;
     }
      
     public void demoMethod()
     {
     	system.debug('demoMethod');
     }
         
         public void demoMethod1()
        {
     	system.debug('demoMethod');
         }
  }