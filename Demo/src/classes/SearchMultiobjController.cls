public class SearchMultiobjController {

    String searchText;
    List<Account> results=new List<Account>();
   // List<Contact> results1=new List<Contact>();
   // List<Case> results2=new List<Case>();

    public String getSearchText() {
        return searchText;
    }

   public void setSearchText(String s) {
        searchText = s;
    }

    public List<Account> getResults() {
        return results;
   }     
        
   /* public List<Contact> getResults1() {
        return results1;
        
     }   */
   /* public List<Case> getResults2() {
        return results2;
        
    }
*/
    public PageReference doSearch() {
        results = (List<Account>)[FIND:searchText RETURNING Account(Name,Full_Name__c)][0];
  /*      results1 = (List<Contact>)[FIND :searchText RETURNING Contact][0];
        results2 = (List<Case>)[FIND :searchText RETURNING Case][0];*/
        return null;
    }
    

}