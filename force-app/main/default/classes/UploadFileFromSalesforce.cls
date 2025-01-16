@RestResource(urlMapping='/UploadFile/*')
global class UploadFileFromSalesforce {
    
	@httppost
    global static Boolean uploadFile(String base64, String fileName, String contactId){
        System.debug(base64+'>>>>>'+fileName+'>>>>>'+contactId);
        String cdlId = FileUploaderClass.uploadFile(base64, fileName, contactId); 
        if(cdlId != null){
        	System.debug('Uploaded succesfully');
            return true;
        } else{
        	System.debug('Upload error');
            return false;
        }
    }   
}