@isTest 
private class QueryBuilderTestClass {
    static testMethod void validateQueryBuild() {
       Boolean pagenullref=false;
        objectList obj=new objectList();
         obj.rightvalues.add('Id');
        obj.rightvalues.add('Name');
        obj.radio='ASC';
        obj.MaxRecordSelected='500';
        
        List<selectoption> newobjlist=obj.getObjList();

       System.assertEquals(215,newobjlist.size());
       
       obj.ObjectSelected='Account';
       List<selectoption> fieldList=obj.getFieldList();
        
        System.assertNotEquals(0,fieldList.size());
        
        
        List<SelectOption> maxlist=obj.getMaxRecord();
         System.assertEquals(4,maxlist.size());
         
         List<SelectOption> radiolist=obj.getRadioItems();
         System.assertEquals(2,radiolist.size());
         
         try
         {
         PageReference page = obj.displayQuery();
         }
         catch(System.NullPointerException e)
         {
             pagenullref =true;
         }
         system.assertEquals(pagenullref,true);
        
          
          List<SelectOption> val=obj.getSelectedValues();
          
           System.assertNotEquals(0,val.size());
           
          try
         {
         PageReference page = obj.selectclick();
         }
         catch(System.NullPointerException e)
         {
             pagenullref =true;
         }
         system.assertEquals(pagenullref,true);
          
            try
         {
         PageReference page = obj.unselectclick();
         }
         catch(System.NullPointerException e)
         {
             pagenullref =true;
         }
         system.assertEquals(pagenullref,true);
           
    }

}