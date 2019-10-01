/**
  * @author Jayson Faderanga (jfaderanga@deloitte.co.nz)
  * @date October 2019
  * @class FlaggedRecordBannerController
  **/
@isTest
public with sharing class FlaggedRecordBannerControllerTest {

    @isTest
    static void getFlagTypesTest() {

        // No assertion required - admin might add new picklist values or totally remove all values
        FlaggedRecordBannerController.getFlagTypes();
    }

    @isTest
    static void getFlaggedRecordTest() {

        Flagged_Record__c flaggedRecord = new Flagged_Record__c(
            RecordId__c = 'SomeRecordId', Type__c = 'SomeType', Object__c = 'SomeObject');

        insert flaggedRecord;
        
        System.assert(!FlaggedRecordBannerController.getRecordFlags(flaggedRecord.RecordId__c).isEmpty());
        System.assert(FlaggedRecordBannerController.isFlagged(flaggedRecord.RecordId__c, flaggedRecord.Type__c));
    }

    @isTest
    static void performFlaggedActionTest() {

        Account account = new Account(Name = 'New Account');
        insert account;
        
        FlaggedRecordBannerController.performFlaggedAction(account.Id, 'SomeType');

        System.assertEquals(1, [SELECT count() FROM Flagged_Record__c]);
    }
}