@RestResource(urlMapping='/ContactsAndFiles/*')
global class GetContactsAndFilesFromOtherSalesforce {

    @HttpGet
    global static List<Contact> getContacts(){
        return [SELECT Id,Name From Contact];
    }
    
	@HttpPost
    global static List<ContentVersion> getFiles(String linkedEntityId){
        List<ContentDocumentLink> contentDocumentLinks = [SELECT ContentDocumentId FROM ContentDocumentLink WHERE LinkedEntityId =:linkedEntityId];
        System.debug(contentDocumentLinks);
        List<Id> cdlId = new List<Id>();
        for(Integer i = 0 ; i < contentDocumentLInks.size() ; i++){
            cdlId.add(contentDocumentLinks[i].ContentDocumentId);
        }
        List<ContentVersion> cv = [SELECT FileType,Title,ContentDocumentId FROM ContentVersion WHERE ContentDocumentId IN : cdlId];
        System.debug(cv);
		return cv;
    }
}