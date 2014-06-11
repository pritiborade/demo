trigger NewTaskCreateTrigger on Account (After insert) 
{
    if(trigger.isInsert && trigger.isAfter)
        {
        
              HandlerNewTaskCreate obj  =new HandlerNewTaskCreate();
              obj.checktaskCreate(trigger.new);
        }
      
}