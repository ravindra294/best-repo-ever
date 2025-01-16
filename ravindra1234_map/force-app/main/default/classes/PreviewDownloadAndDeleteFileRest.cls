@RestResource(urlMapping='/PreviewDownloadDeleteFile/*')
global class PreviewDownloadAndDeleteFileRest{	
    @httppost
    global static ContentDistribution previewFile(String contDocId){
        ContentVersion cv = [select id,Title from contentversion where contentdocumentid =:contDocId];
        List<ContentDistribution> cdList = [SELECT ContentDocumentId,ContentDownloadUrl,DistributionPublicUrl FROM ContentDistribution WHERE ContentDocumentId =:contDocId LIMIT 1];
        if(cdList.isEmpty()){
			ContentDistribution cd = new ContentDistribution();
            cd.Name = cv.Title;
            cd.ContentVersionId = cv.id;
            cd.PreferencesAllowViewInBrowser= true;
            cd.PreferencesLinkLatestVersion=true;        
            cd.PreferencesNotifyOnVisit=false;        
            cd.PreferencesPasswordRequired=false;        
            cd.PreferencesAllowOriginalDownload= true;        
            insert cd;
            return [SELECT ContentDocumentId,ContentDownloadUrl,DistributionPublicUrl FROM ContentDistribution WHERE ContentDocumentId =:contDocId LIMIT 1][0];
        }
        else 
            return cdList[0];        
    }
    @httpdelete
    global static void deleteFile(){
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        System.debug('res>>>'+req);
        String contDocId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        List<ContentDocument> cd = [select id,Title from ContentDocument where Id =:contDocId LIMIT 1];
        try{
	        delete cd;
          	res.statusCode = 200;
        	res.responseBody = Blob.valueOf('file Successfully');
        }
        catch(Exception e){
           	res.statusCode = 204;
        	res.responseBody = Blob.valueOf(e.getMessage()); 
        }       	
    }
}