Public Class HandlerNewTaskCreate
{
    List<Task> listt=new List<Task>();
    public void checktaskCreate(list<Account> listacc)
    {
    
        for(Account a: listacc)  
         {
             TriggerSetting__c CS = TriggerSetting__c.getInstance();
            if(CS.DisableTrigger__c == false)       
            { Task t=new Task(Subject='Meetings'
                             /*Assigned To='hitesh patil',Priority='High',Status='Completed',Unique Name='Projectcreated',
                             Due Date='11/11/14'*/+a.Name);
             listt.add(t);
            }
         }
         insert listt;
    }
}