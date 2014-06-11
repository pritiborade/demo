public class Controller_wrapclass
{
    public String email;
    Public List<wrapperclass> wrapList {get;set;}

    public string getEmail()
    {
        return email;
    }
    public void setEmail(String str)
    {
        email=str;
    }

    public List<wrapperclass> getWrapList ()
    {
        return wrapList ;
    }

    public void setWrapList(List<wrapperclass> listwrap)
    {
        wrapList = listwrap;
    }
    
    public Controller_wrapclass(){}

    Public List<wrapperclass> getWrapperList(){
    wrapList = New List<wrapperclass>();
       for(Account acc:[Select name,id from account limit 5])
       {
         wrapList.add(New wrapperclass(acc,false));
       }
   return wrapList;
  }

     Public class wrapperclass{
   Public account accRec{get;set;}
   
   public account getAccRec()
   {
       return accRec;
   }
   
   public void setAccRec(account accRec) {
       this.accRec= accRec;
    }
   
   Public boolean checkFlag{get;set;}
   
   public boolean getCheckFlag()
   {
       return checkFlag;
   }
   
   public void setCheckFlag(boolean checkFlag) {
       this.checkFlag= checkFlag;
    }
  
   Public wrapperclass(account acc,boolean flag){
    accRec = acc;
    checkFlag = flag;
   }
  }

}