public class Controller_imgwrapclass
{
    public String email;
    public String body;
    public String subject { get; set; }
    Public List<wrapperclass> wrapList {get;set;}
    public Messaging.EmailFileAttachment efa;
    public string getEmail()
    {
        return email;
    }
    public void setEmail(String str)
    {
        email=str;
    }
    
     public string getBody()
    {
        return body;
    }
    public void setBody(String str1)
    {
        body=str1;
    }

    public List<wrapperclass> getWrapList ()
    {
        return wrapList ;
    }

    public void setWrapList(List<wrapperclass> listwrap)
    {
        wrapList = listwrap;
    }
    
    public Controller_imgwrapclass(){
    wrapList = New List<wrapperclass>();
    
    }

    Public List<wrapperclass> getWrapperList(){
    
       for(Attachment acc:[Select id from Attachment limit 5])
       {
         wrapList.add(New wrapperclass(acc));
       }
   return wrapList;
  }

    public PageReference emailSend()
    {
        Messaging.SingleEmailMessage emailnew = new Messaging.SingleEmailMessage(); 
         list< Messaging.EmailFileAttachment> fileat = new list<Messaging.EmailFileAttachment>();
          
        List<Id> selectedAttachment = new List<Id>();

          for(wrapperclass a:wrapList) {
         
              if(a.checkFlag == true) {
                  selectedAttachment.add(a.accRec.id );
              }
          }
          
           System.debug('These are the selected Contacts...');
          for(Attachment at:[Select Name,Body from Attachment where id IN :selectedAttachment ] ) {
           efa = new Messaging.EmailFileAttachment();
           efa.setFileName(at.Name);
           efa.setBody(at.Body);
           
           fileat.add(efa);
          system.debug('record new'+at.Name);
          
          }
          
        String[] toAddresses = email.split(',', 0);
        emailnew.setSubject('fgdfdf');
        emailnew.setplainTextBody('sdhfgsdfk');
        emailnew.setToAddresses(toAddresses );
        emailnew.setSenderDisplayName('Support');
         emailnew.setSubject('Mail has been sent');
         emailnew.setBccSender(false);
         emailnew.setUseSignature(false);
        emailnew.setFileAttachments(fileat);
         Messaging.SendEmailResult [] r = 
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] {emailnew}); 
          wrapList =null;
          return null;
    
    }
    
    
     Public class wrapperclass{
   Public Attachment accRec{get;set;}
   
   public Attachment getAccRec()
   {
       return accRec;
   }
   
   public void setAccRec(Attachment accRec) {
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
  
   Public wrapperclass(Attachment acc){
    accRec = acc;
    checkFlag = false;
   }
  }

}