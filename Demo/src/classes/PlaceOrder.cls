Public class PlaceOrder{
List<productwrapper> productList = new List<productwrapper>();
List<Product2> selectedProducts = new List<Product2>();
public Id Id{get;set;}
public String Discountl ;
  
    
 public List<productwrapper> getProducts()
      {		productList.clear();
          for(Product2 a : [select ProductCode,Name,Description,Discount__c from Product2 limit 5])
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

 public PageReference createOrder(){
 	if(selectedProducts.size()==0)
 	{
 	  ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Select Atleast One Product From The List');
      ApexPages.addMessage(myMsg); 
       return null;
 	}
    Pattern isnumbers = Pattern.Compile('^[0-9]+$');
    Matcher postalMatch;
    for(Product2 pneww : selectedProducts)
	{
		String ssnew=String.valueOf(pneww.Discount__c);
	 postalMatch = isnumbers.matcher(ssnew);
	
	}
	if(postalMatch.Matches()){
    //has only numbers
    
    	  OrderDetail__c od;
          List<OrderDetail__c> odList;
          Decimal subTotal=0;
          Decimal Amount=0;
          Decimal DAmount=0;
           //String orderid = Apexpages.currentPage().getParameters().get('MyorderId');
           
          //System.debug('oid'+orderid);
          
          Order__c o=[Select ID,Opportunity_Name__c from Order__c order by Order_No__c Desc limit 1];
           List<PriceBookEntry > PricebookList=new List<PriceBookEntry >();
          for(PriceBookEntry at:[Select p.UseStandardPrice, p.UnitPrice, p.SystemModstamp, p.ProductCode, p.Pricebook2Id, p.Name, p.LastModifiedDate, p.LastModifiedById, p.IsDeleted,p.Product2Id, p.IsActive, p.Id From PricebookEntry p  where p.Product2Id IN :selectedProducts  AND PriceBook2.isStandard=true ] )
          {
            
              PricebookList.add(at);
          }
        
         /* for(PriceBookEntry pb:PricebookList)
          {
              System.debug('unitprice'+pb.UnitPrice);
             subTotal=subTotal+pb.UnitPrice;
         }
         system.debug('total'+subTotal);*/
          for(PriceBookEntry pb:PricebookList)
          { 
             // subTotal=pb.UnitPrice+subTotal;
            od=new OrderDetail__c(Order_No__c=o.ID ,Product_Name__c=pb.Product2Id,ProductCode__c=pb.ProductCode,Quantity__c=1,UnitPrice__c=pb.UnitPrice);
              insert od; 
               OrderDetail__c odupdate=[Select Discount__c from OrderDetail__c where Product_Name__c=:pb.Product2Id Limit 1 ];
             for(Product2 p:selectedProducts)
             {
                
                String s=String.valueOf(p.Discount__C);
                Decimal myDecimal = decimal.valueOf(s);
                odupdate.Discount__c=myDecimal;
             }  
             update odupdate;
         }
        
      // o.TotalCost__c=subTotal;
      // update o;
      system.debug('idopp'+o.Opportunity_Name__c);
      Order__c ordernew=[Select ID,TotalCost__c from Order__c order by Order_No__c Desc limit 1];
      
     /*  Opportunity op=[Select ID,TotalRevenue__c from Opportunity  where ID=:o.Opportunity_Name__c limit 1];
        system.debug('opid'+op.TotalRevenue__c);
        String sn=String.valueOf(ordernew.TotalCost__c);
      Decimal myDecimalnew = decimal.valueOf(sn);
      op.TotalRevenue__c=myDecimalnew;
     update op;*/
      
        PageReference reRend1 = new PageReference('https://na15.salesforce.com/a06/o'); 
          return reRend1;
	}
	
    else{
       	ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.WARNING,'Enter only Numeric Value');
      ApexPages.addMessage(myMsg); 
       return null;
       }
      }



}