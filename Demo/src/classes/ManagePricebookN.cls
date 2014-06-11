Public class ManagePricebookN{
 
 Public string pnameSelected{get;set;}
 Public List<Pricebook2> pbooknamelist;
 
 Public ManagePricebookN(){
 pbooknamelist=new List<Pricebook2>();
 }
 
 Public List<selectoption> getPnameList(){
    List<selectoption> pnmList = new List<selectoption>();
    pnmList.add(new SelectOption('','---Select Price Book---'));
    
    pbooknamelist=[Select Name from Pricebook2];
    
    for(Pricebook2 p : pbooknamelist){
       
        pnmList.add(new SelectOption(p.Name,p.Name));
        
    }
    system.debug('objlist size'+ pnmList.size());
    pnmList.sort();
      return pnmList;   
     }
     
       public PageReference getPBookId()
       {
       
       Pricebook2 p1=[SELECT Id FROM Pricebook2 WHERE Name=:pnameSelected];
       PageReference pageRef = new PageReference('https://na15.salesforce.com/'+p1.Id);
       return pageRef;
       }
     
 }