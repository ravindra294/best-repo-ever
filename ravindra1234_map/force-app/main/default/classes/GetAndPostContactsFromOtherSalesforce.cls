@RestResource(urlMapping='/Contact/*')
global class GetAndPostContactsFromOtherSalesforce {
	
    @HttpGet
    global static List<Contact> getContacts(){
        return [SELECT Id,LastName From Contact];
    }
    
    @HttpPost
    global static Contact createContact(String contactLastName){
        Contact con = new Contact();
        con.LastName = contactLastName;
        
        insert con;    
        return con; 
    }   
}