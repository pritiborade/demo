public class MyController8 {

    public Student__c stud;
    public String flg{get; set;}
    Public String Selectedlanguage{get;set;}
    public MyController8(ApexPages.StandardController controller ) {
     stud =(Student__c)controller.getRecord() ;
    }
        public Student__c getDetails() {
        return stud;
    }
    public PageReference save() {
        try {
            insert(stud);
            
        } catch(System.DMLException e) {
            ApexPages.addMessages(e);
            return null;
        }
        flg='true';
      PageReference pageRef = new PageReference('/apex/StudentRegistration');
      return pageRef;
    }
    
    
    public PageReference doSearch() {
      system.debug('---Selectedlanguage---'+Selectedlanguage);
      Id uId=userinfo.getUserId() ;
     User usr=[Select Id,Name,LocaleSidKey,LanguageLocaleKey  from User where Id=:uId];
     System.debug('aaaaaaa'+usr);
     usr.LanguageLocaleKey = Selectedlanguage;
      update usr;
       PageReference pageRef = new PageReference('/apex/StudentRegistration');
       pageref.setRedirect(true);
        return pageRef ;
    }
}