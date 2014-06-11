Public Class PlacePo{

 List<productwrapper> productList = new List<productwrapper>();
 List<Product2> selectedProducts = new List<Product2>();
 public Id Id{get;set;}
    
   // private final Order__c order;
    ApexPages.StandardController controller;
    // The extension constructor initializes the private member
    // variable acct by using the getRecord method from the standard
    // controller.
    public PlacePo(ApexPages.StandardController stdController) {
        //this.order= (Order__c)stdController.getRecord();
        controller=stdController;
    }
    
 public List<productwrapper> getProducts()
      {
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
      
      public PageReference save()
      {
      
       controller.save();
       String oid=ApexPages.currentPage().getParameters().get('Id');
       System.debug('oid****************'+oid);
        
         PageReference reRend1 = new PageReference('/apex/PlacePO');  
        reRend1.getParameters().put('MyorderId',oid);
        return reRend1; 
}

     
}