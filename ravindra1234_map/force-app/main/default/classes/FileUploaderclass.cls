public with sharing class FileUploaderclass{
    public static string uploadFile(String base64, String filename, string recordId) {
        ContentVersion cv = createContentVersion (base64, filename);
        ContentDocumentLink cdl = createContentLink(cv.Id, recordId);
        if (cv == null || cdl == null) {
        	return null;
        }
        return cdl.Id;
    }
    public static void upload(ContentVersion cv){
        
    }
    private static contentversion createContentversion(string base64, string filename) {
        Contentversion cv = new contentversion();
        cv.versionData = Encodingutil.base64Decode (base64);
        cv.Title = filename;
        cv.PathonClient = filename;
        try {
            insert cv;
            return cv;
        } catch(DMLException e) {
            System.debug(e);
            return null;
        }
    }
    private static contentDocumentLink createContentLink(String contentversionId, String recordId) { 
        if (contentVersionId == null || recordId == null) {
            return null;
        }
        ContentDocumentLink cdl = new contentDocumentLink();
        cdl.contentDocumentId = [SELECT ContentDocumentId FROM contentversion WHERE Id=: contentversionId ].contentDocumentId; 
        cdl.LinkedEntityId = recordId;
        try {
            insert cdl;
            return cdl;
        } catch(DMLException e) {
            System.debug(e);
            return null;
        }
    }
}