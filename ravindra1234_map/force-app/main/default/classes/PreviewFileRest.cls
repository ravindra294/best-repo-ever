@RestResource(urlMapping='/PreviewFile/*')
global class PreviewFileRest{
	
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
}