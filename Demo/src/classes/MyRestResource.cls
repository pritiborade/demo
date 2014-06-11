@RestResource(urlMapping='/LeadService/*')
global with sharing class MyRestResource {
  @HttpPost
    global static Map<String,String> doPost(String FirstName,String LastName, String Phone, String Email,String Company) {
         Map <String,String> responseResult= new Map <String,String>();
        Lead leadobj= new Lead ();
        leadobj.FirstName= FirstName;
        leadobj.LastName= LastName;
        leadobj.Email= Email;
        leadobj.Phone= Phone;
        leadobj.Company= Company;
     
        Database.SaveResult db = Database.insert(leadobj, false);
        if(db.isSuccess())
        {
            responseResult.put('isSuccess','True');
            responseResult.put('leadId',leadobj.Id);
            responseResult.put('status','Success');
        }
        else
        {
            responseResult.put('isSuccess','False');
            responseResult.put('leadId','');
            responseResult.put('status','failure');
            db.getErrors();
        }
        return responseResult;
        
    }
    
    @HttpDelete
    global static Map<String,String> doDelete() {
         Map <String,String> responseResdelete= new Map <String,String>();
        String firstName = RestContext.request.params.get('firstname');
        String lastName = RestContext.request.params.get('lastname');
        String email = RestContext.request.params.get('emailid');
        String phone = RestContext.request.params.get('phoneno');
        Lead lead = [SELECT Id FROM Lead WHERE FirstName=:firstName and LastName=:lastName and Email=:email and Phone=:phone];
        
        Database.DeleteResult dbDelete = Database.delete(lead,false);
         if(dbDelete.isSuccess())
        {
            responseResdelete.put('isSuccess','True');
            responseResdelete.put('leadId',lead.Id);
            responseResdelete.put('status','Success');
        }
        else
        {
            responseResdelete.put('isSuccess','False');
            responseResdelete.put('leadId','');
            responseResdelete.put('status','failure');
            dbDelete.getErrors();
        }
        return responseResdelete;
      
    }
    
    @HttpPatch
    global static String doUpdate(String firstName,String lastName) {
        Lead lead = [SELECT Email,Phone FROM Lead WHERE FirstName=:firstName and LastName =:lastName];
        lead.Email='p.pritib@gmail.com';
        lead.phone='1234566';
        update lead;
        return 'success';
    }
    
    }