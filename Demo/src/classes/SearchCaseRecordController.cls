public class SearchCaseRecordController {

  String searchText;
  String searchStatus ;
  List<Case> allresults=new List<Case>();
   // List<Contact> results1=new List<Contact>();
   // List<Case> results2=new List<Case>();

    public String getSearchText() {
        return searchText;
    }

   public void setSearchText(String s) {
        searchText = s;
    }
    
    public String getSearchStatus() {
        return searchStatus;
    }

   public void setSearchStatus(String se) {
        searchStatus= se;
    }

        public List<Case> getAllresults() {
        return allresults;
   } 
        
         public void setAllresults(List<Case> c) {
         allresults=c;
   } 
   
    public SearchCaseRecordController(){
       allresults=[Select Id, CaseNumber, Status, Priority, CreatedDate, Subject FROM case];
    }    


    public PageReference doSearch() {
         allresults= (List<Case>)[FIND:searchText IN ALL FIELDS RETURNING Case(Id, CaseNumber, CreatedDate, Subject, Priority,Status  WHERE Status=:searchStatus ) ][0];
         system.debug('searchStatus'+allresults);
      /* results1 = (List<Contact>)[FIND :searchText RETURNING Contact][0];
        results2 = (List<Case>)[FIND :searchText RETURNING Case][0];*/
        return null;
    }

    

}