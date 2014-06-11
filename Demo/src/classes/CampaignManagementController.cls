public class CampaignManagementController {

  public Campaign campobj{get; set;}
  
    public CampaignManagementController(){
       campobj=[Select ID,Owner.Name,Name,StartDate,EndDate,CreatedDate,Description,LastModifiedDate,Type,NumberSent,Parent.Name,Status 
                    FROM Campaign WHERE id='701i0000000ebze'];
    }    
    

}