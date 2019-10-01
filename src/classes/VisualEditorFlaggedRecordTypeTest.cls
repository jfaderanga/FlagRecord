/**
  * @author Jayson Faderanga (jfaderanga@deloitte.co.nz)
  * @date October 2019
  * @class VisualEditorFlaggedRecordType
  **/
@isTest
public with sharing class VisualEditorFlaggedRecordTypeTest {

    @isTest
    static void visualEditorFlaggedTypeTest() {

        // No assertion required
        VisualEditorFlaggedRecordTypes visualEditor = new VisualEditorFlaggedRecordTypes();
        visualEditor.getDefaultValue();
        visualEditor.getValues();
    }
}