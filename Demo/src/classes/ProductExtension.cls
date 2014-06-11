public with sharing class ProductExtension
{
public List<product2> f1 {get; set;}
public Boolean flag{get;set;}

public ProductExtension(ApexPages.standardController con) 
{
f1=new list<product2>();
   /* for(integer i=0;i<5;i++)
    {
        f1.add(new product2()); 
    }
    flag=false;*/
    f1.add(new product2());
}

  public void AddRow()
    {
        f1.add(new product2()); 
    } 
public class wrapper
{

}
public PageReference save()
{
    insert f1;
    PageReference pageRef = new PageReference('https://na15.salesforce.com/01t/o');
    return pageRef;
} 
public PageReference abc()
{
     flag=true;
    return null;
} 
public PageReference  massEdit()
{
    flag=false;
 PageReference pageRef = new PageReference('https://na15.salesforce.com/01t');
    return pageRef;
}
}