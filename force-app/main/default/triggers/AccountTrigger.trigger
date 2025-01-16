trigger AccountTrigger on Account (after update) {
	if(trigger.isUpdate && trigger.isAfter){
        List<String> accountIds = new List<String>();
        for(Account acc : trigger.new){
          	Account oldAcc = Trigger.oldMap.get(acc.Id);
            if(oldAcc != null && acc.Rating != oldAcc.Rating){
                accountIds.add(acc.Id);
            }
        }
        List<Test_Object__c> testRecords = new List<Test_Object__c>();
        testRecords = [SELECT Id, Account__c, Account__r.OwnerId FROM Test_Object__c WHERE Account__c IN : accountIds];
      	List<Test_Object__Share> lstTestShareRecordsToInsert = new List<Test_Object__Share>();
        
        for(Test_Object__c testObject: testRecords){
            Test_Object__Share testObjShare = new Test_Object__Share();
            testObjShare.AccessLevel = 'Edit'; // Access level as defined on the Participant record
            testObjShare.ParentId = testObject.Id; // The Loan Record Id to be Shared
            testObjShare.UserOrGroupId = testObject.Account__r.OwnerId; //The user with whom the loan record is to be shared
            lstTestShareRecordsToInsert.add(testObjShare);
        }
        
        if(!lstTestShareRecordsToInsert.isEmpty()){
            insert lstTestShareRecordsToInsert;
        }
    }
}