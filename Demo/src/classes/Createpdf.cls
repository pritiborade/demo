public class Createpdf{
List<QuoteLineItem> quoteitemList = new List<QuoteLineItem>();
String quoteid;
public Createpdf(){
 

}

 public List<QuoteLineItem> getQuoteLine()
      {
          quoteid = Apexpages.currentPage().getParameters().get('MyQuoteId');
         System.debug('id+++++'+quoteid );
         quoteitemList = [ select id,ListPrice,PriceBookEntry.Product2Id ,Subtotal,UnitPrice,TotalPrice,Quantity from QuoteLineItem where QuoteId=:quoteid];
          
     
          return quoteitemList;
      }


        public PageReference approveQuote()
        {
            PageReference reRend1 = new PageReference('/apex/ManageProduct');  
             reRend1.setRedirect(true);
               return reRend1;
        }    
}