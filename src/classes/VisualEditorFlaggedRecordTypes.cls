/**
  * Used in FlagRecordBanner.cmp to have a dynamic design attributes
  * 
  * @author Jayson Faderanga (jfaderanga@deloitte.co.nz)
  * @date September 2019
  * @test VisualEditorFlaggedRecordTypeTest
  **/
global class VisualEditorFlaggedRecordTypes extends VisualEditor.DynamicPickList {

    global override VisualEditor.DataRow getDefaultValue() {

        return new VisualEditor.DataRow('For Delete', 'For Delete');
    }

    global override VisualEditor.DynamicPicklistRows getValues() {

        VisualEditor.DynamicPicklistRows types = new VisualEditor.DynamicPickListRows(); 

        for (PicklistEntry entry : Flagged_Record__c.Type__c.getDescribe().getPicklistValues()) {

            types.addRow(new VisualEditor.DataRow(entry.getLabel(), entry.getValue()));
        }
        
        return types;
    }
}