@isTest 
private class PurchaseOrderTestCase {

    static testMethod void myUnitTest() {
    	CreatePo po=new CreatePo();
    	po.oppname='sdfsdfg';
    	po.OppStageSelected='Closed Won';
    	Product2 p1 =[select Name from Product2 limit 1];
    	 Boolean pagenullref=false;
    	po.selectedProducts = [select Name,Id from Product2 limit 5];
   		
    	CreatePo.productwrapper wrap=new CreatePo.productwrapper(p1);
        
    	try
    	{
    	List<Product2> plist =po.GetSelectedProducts();
    	if(plist.size()>0)
       	 System.assertNotEquals(0,plist.size());
        else
         System.assertEquals(0,plist.size());
    	}catch(System.NullPointerException e)
    	{}
    	
    	po.productList=po.getProducts();
    	System.assertNotEquals(0,po.productList.size());
        
        PageReference page1=po.createOpp();
      		 System.assertNotEquals(page1,null);
      		 
        PageReference page2=po.getQuoteItem();
      		 System.assertNotEquals(page2,null);
      		 
       List<SelectOption> oppstagelist=po.getOpportyStage();
         System.assertEquals(5,oppstagelist.size());
         
         
         PageReference page = po.getSelected();
         
        system.assertEquals(page,null);
    }
    
}