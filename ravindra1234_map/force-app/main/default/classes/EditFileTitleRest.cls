@RestResource(urlMapping='/EditFileTitle/*')
global class EditFileTitleRest{	
    @httppost
    global static void editFile(String contDocId,String Name){
        RestResponse res = RestContext.response;
		List<ContentDocument> cd = [select id,Title from ContentDocument where Id =:contDocId LIMIT 1];
        try{
            ContentDocument cdFirst = cd[0];
            cdFirst.Title = Name;
            update cdFirst;
            System.debug('update successfull' + cdFirst);
            List<ContentVersion> cv = [SELECT FileType,Title,ContentDocumentId FROM ContentVersion WHERE ContentDocumentId =: contDocId LIMIT 1];
            Blob str = Blob.valueOf(cv[0].toString());
            System.debug('bb - - ' + Blob.valueOf(cv[0].toString()));
            
            res.statusCode = 200;
            res.responseBody = str;
        }
        catch(Exception e){
            SYstem.debug('ex -- ' + e.getMessage());
           	res.statusCode = 204;
        	res.responseBody = Blob.valueOf(e.getMessage()); 
        }
    }
}