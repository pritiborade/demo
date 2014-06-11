Public class campcontroller
{

    List<Campaign> campaigns = [SELECT Id, Name, StartDate, EndDate, Type, Status, Description, Owner.Name,NumberOfLeads, NumberOfContacts, NumberOfOpportunities,
    NumberOfWonOpportunities,AmountAllOpportunities,IsActive,LastModifiedDate FROM Campaign where  IsActive=TRUE ORDER BY LastModifiedDate  DESC];
  
    ApexPages.StandardSetController ssc = new ApexPages.StandardSetController(campaigns);
  public List<Campaign> accounts{get;set;} 
  
     Public Campaign cmp;

    private final Campaign acct;
   Public string passedParam1 = Apexpages.currentPage().getParameters().get('myParam');
 
    public campcontroller(ApexPages.StandardSetController stdController)
     {
      accounts=campaigns;
        this.acct=(Campaign )ssc.getRecord();
     }
 public String selectedIso {get;set;}
     public List<selectOption> isoCodes {
        get {
            List<selectOption> options = new List<selectOption>();
       options.add(new SelectOption('003','Recently Modified'));
        options.add(new SelectOption('001','All Active Campaign  '));
        options.add(new SelectOption('002','All Inactive Campaign '));
       
        options.add(new SelectOption('004','All Campaigns'));
        // options.add(new SelectOption('005','My Active Campaigns'));
          return options;
        }
        set;
    }
    
 public PageReference work() 
    {
     
     if(selectedIso =='004'){
     campaigns = [SELECT Id, Name, StartDate, EndDate, Type, Status, Description, Owner.Name,NumberOfLeads, NumberOfContacts, NumberOfOpportunities,
    NumberOfWonOpportunities,AmountAllOpportunities,LastModifiedDate    FROM Campaign ORDER BY StartDate DESC];

     // cmp=(Campaign )ssc.getRecord();
      System.debug('11111111111111'+accounts);
      accounts=campaigns;
       System.debug('222222'+accounts);
       System.debug('yyyyyyy'+selectedIso );
       }
       if(selectedIso =='003')
       {
        campaigns = [SELECT Id, Name, StartDate, EndDate, Type, Status, Description, Owner.Name,NumberOfLeads, NumberOfContacts, NumberOfOpportunities,
    NumberOfWonOpportunities,AmountAllOpportunities,LastModifiedDate  FROM Campaign ORDER BY LastModifiedDate  DESC];

     
   
      accounts=campaigns;
    
       }
       if(selectedIso =='001')
       {
       campaigns = [SELECT Id, Name, StartDate, EndDate, Type, Status, Description, Owner.Name,NumberOfLeads, NumberOfContacts, NumberOfOpportunities,
    NumberOfWonOpportunities,AmountAllOpportunities,IsActive,LastModifiedDate FROM Campaign where  IsActive=TRUE ORDER BY StartDate DESC];

      accounts=campaigns;
       }
         if(selectedIso =='002')
       {
       campaigns = [SELECT Id, Name, StartDate, EndDate, Type, Status, Description, Owner.Name,NumberOfLeads, NumberOfContacts, NumberOfOpportunities,
    NumberOfWonOpportunities,AmountAllOpportunities,IsActive,LastModifiedDate FROM Campaign where  IsActive=FALSE ORDER BY LastModifiedDate  DESC];

      accounts=campaigns;
       }
      return null;
       
    }
}