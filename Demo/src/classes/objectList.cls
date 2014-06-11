public class objectList{
       Public string ObjectSelected{get;set;}
       Public List<string> FieldSelected{get;set;}
       Public List<string> rightselected{get;set;}
       public string query{get;set;}
       public String val {get;set;}
       public List<Sobject> records{get;set;} 
       Public string  MaxRecordSelected{get;set;}
       Public  Set<string> leftvalues;
       Public  Set<string> rightvalues;
       Public Map<String, Schema.SObjectType> AllObjmap;
       public String selectedField{get;set;}
       public String radio{get;set;}
    Public objectList(){
    AllObjmap = New Map<String, Schema.SObjectType>();
    AllObjmap = Schema.getGlobalDescribe();
    radio='ASC';
    FieldSelected=new List<string>() ;
    rightselected=new List<string>() ;
    leftvalues = new Set<string>();
    rightvalues = new Set<string>();
    records=new List<Sobject>();
    System.debug('******All object Names :'+ AllObjmap.keyset());
   
    
    }
    
    Public List<selectoption> getObjList(){
    List<selectoption> objList = new List<selectoption>();
    objList.add(new SelectOption('','---Select Object---'));
    for(Schema.SObjectType obj : AllObjmap.values()){
        if(obj.getDescribe().isQueryable() ){
        objList.add(new SelectOption(obj.getDescribe().getName(),obj.getDescribe().getLabel()));
        }
    }
    system.debug('objlist size'+ objList.size());
    objList.sort();
      return objList;   
     }
     
     
      Public List<selectoption> getFieldList(){
      Map<String,Schema.SObjectType> gd = Schema.getGlobalDescribe();
      List<selectoption> fieldList = new List<selectoption>();
      Schema.SObjectType objName;
        if(ObjectSelected!=null)
      {
      objName = gd.get(ObjectSelected);
   
      system.debug('objname'+objName );
       Map<String,Schema.SObjectField> AllFieldmap = objName.getDescribe().fields.getMap();
     system.debug('name'+AllFieldmap );
    //  Schema.DescribeSObjectResult fName =objName.getDescribe();
       
        for(string f:AllFieldmap.keyset()){
        if(!rightvalues.contains(f))
        {
        fieldList.add(new selectoption(f,f));
        }
        }
        
        fieldList.sort();
   
      }
      
      return fieldList ;   
    }
    

    public PageReference selectclick(){
        rightselected.clear();
        //rightvalues.add('name');
       // leftvalues.remove('name');
        for(String s : FieldSelected){ 
            leftvalues.remove(s);
            rightvalues.add(s);
        }
     
        return null;
    }
     
    public PageReference unselectclick(){
        FieldSelected.clear();
        for(String s : rightselected){
            rightvalues.remove(s);
            leftvalues.add(s);
        }

        return null;
    }
    
    public List<SelectOption> getSelectedValues(){
        List<SelectOption> options1 = new List<SelectOption>();
        List<string> tempList = new List<String>();
        tempList.addAll(rightvalues);
        tempList.sort();
        for(String s : tempList)
            options1.add(new SelectOption(s,s));
        return options1;
    }
  
      public List<SelectOption> getMaxRecord() {
        List<SelectOption> MaxRecordc= new List<SelectOption>();
        MaxRecordc.add(new SelectOption('500','500'));
        MaxRecordc.add(new SelectOption('1000','1000'));
        MaxRecordc.add(new SelectOption('5000','5000'));
        MaxRecordc.add(new SelectOption('50000','50000'));
        return MaxRecordc;
    }
    
     public PageReference displayQuery(){
        set<string> fld=new set<string>();
        string flds='';
        string firstelement='';
      if(!rightvalues.isEmpty()){
       fld =  rightvalues;
     
      for(string s:fld)
      {
     if(flds=='')
     {
     
     flds=s;
     firstelement='Id';
     }
     else
     {
     flds=flds+','+s;
     }
      }
      
      if(flds!='' &&  !fld.isEmpty())
      {
       query='select '+' '+flds+ ' '+ 'from ' + ObjectSelected + ' order by ' + ' '+ firstelement + ' ' + radio + ' ' +' LIMIT ' + ' ' +MaxRecordSelected;
      }
       if(query != '')
       {
      List<sobject> campaigns;
       Map<String,Schema.SObjectType> gd = Schema.getGlobalDescribe();
     
      if(ObjectSelected !=null)
      {
      Schema.SObjectType sobjType = gd.get(ObjectSelected ); 
     
      for(String s:rightvalues )
      { 
      rightselected.add(s);
      }
      records = Database.query(query);
       if(records.size()==0){
       ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Record Doesnot Exist');
      ApexPages.addMessage(myMsg); 
    
      }
      
       }
       
        }
      
      }
      else{
      ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Please Select Atleast One Field');
      ApexPages.addMessage(myMsg); 
      
      
      }
    
      
        return null;
    }
    
     public List<SelectOption> getRadioItems() {
        List<SelectOption> options = new List<SelectOption>(); 
        options.add(new SelectOption('ASC','Ascending')); 
        options.add(new SelectOption('DESC','Descending')); 
        return options; 
    }
    
    
    public PageReference clearpicklist()
    {
        
        rightvalues.clear();
         leftvalues.clear();
          query='';
         records.clear();
        return null;
    }
    
   
 }