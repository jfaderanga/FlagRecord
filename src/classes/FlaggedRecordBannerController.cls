/**
  * FlagRecord component controller to display record specific message
  * or global broadcast message on object records 
  *
  * @author Jayson Faderanga (jfaderanga@deloitte.co.nz)
  * @date October 2019
  * @test FlaggedRecordBannerControllerTest
  **/
public without sharing class FlaggedRecordBannerController {

    @AuraEnabled
    public static Boolean isFlagged(String recordId, String type) {
        return [SELECT count() FROM Flagged_Record__c WHERE RecordId__c = :recordId AND Type__c = :type] > 0;
    }

    @AuraEnabled
    public static List<Flagged_Record__c> getRecordFlags(String recordId) {
        
       return [SELECT Id, RecordId__c, Type__c
                 FROM Flagged_Record__c
                WHERE RecordId__c = :recordId
             ORDER BY CreatedDate];
    }
    
    @AuraEnabled
    public static void performFlaggedAction(String recordId, String flags) {

        // flags is a multi select values i.e For Delete, For Deactivation etc.
        delete [SELECT Id FROM Flagged_Record__c WHERE RecordId__c = :recordId];

        if (String.isNotBlank(flags)) {

            Set<String> flagSet = new Set<String>();

            flagSet.addAll(flags.split(';'));
                
            List<Flagged_Record__c> newFlags = new List<Flagged_Record__c>();
        
            for (String flag : flagSet) {

                newFlags.add(new Flagged_Record__c(
                    RecordId__c = recordId,
                    Type__c = flag,
                    Object__c = String.valueOf(((Id) recordId).getSObjectType()),
                    Flagged_By__c = UserInfo.getUserId(),
                    Flagged_Date__c = System.now()
                ));
            }
            
            insert newFlags;
        }
    }

    @AuraEnabled
    public static List<String> getFlagTypes() {

        List<String> types = new List<String>();

        for (PicklistEntry entry : Flagged_Record__c.Type__c.getDescribe().getPicklistValues()) {

            types.add(entry.getValue());
        }
        return types;
    }
}