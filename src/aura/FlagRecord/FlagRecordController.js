({
	init : function(component, event, helper) {
		
		var recordId = component.get('v.recordId');

		var getFlaggedRecord = component.get('c.getRecordFlags');
		var getFlagTypes = component.get('c.getFlagTypes');

		getFlagTypes.setCallback(this, function(response) {
			
			var flagTypes = [];
			var flags = response.getReturnValue();

			for (var key in flags) {
					
				var flag = flags[key];

				flagTypes.push({
					"label" : flag,
					"value" : flag
				});
			}
			component.set('v.flagTypes', flagTypes);
		});

		$A.enqueueAction(getFlagTypes);

		getFlaggedRecord.setParams({'recordId' : recordId});
		getFlaggedRecord.setCallback(this, function(response) {

			if (response.getState() === 'SUCCESS') {
				
				var values = [];
				var flaggedRecords = response.getReturnValue();

				for (var key in flaggedRecords) {
					
					var flaggedRecord = flaggedRecords[key];

					values.push(flaggedRecord.Type__c);
				}
				component.set('v.flagValues', values);
			}
		});

		$A.enqueueAction(getFlaggedRecord);
	},

	saveFlagAction : function (component, event, helper) {
		
		var performFlaggedAction = component.get('c.performFlaggedAction');
		
		var recordId = component.get('v.recordId');
		var selected = component.find('flag_types').get('v.value');

		var selectedFlags = '';

		for (var key in selected) {
			selectedFlags += ';' + selected[key];
		}

		selectedFlags = selectedFlags.substring(1);

		performFlaggedAction.setParams({'recordId' : recordId, 'flags' : selectedFlags});

		performFlaggedAction.setCallback(this, function(response) {

			var toastEvent = $A.get("e.force:showToast");

			if (response.getState() === 'SUCCESS') {
				
				var message = 'Record flag(s) has been updated!.';
				
				toastEvent.setParams({"type" : 'success', "title": 'Success!', "message": message});
				$A.get("e.force:closeQuickAction").fire();

			} else {
				toastEvent.setParams({"type" : 'error',"title": 'Error!', "message": 'Unexpected error occured!'});
			}

			toastEvent.fire();
			$A.get('e.c:FlagActionEvent').fire();
		});
		$A.enqueueAction(performFlaggedAction);	
	},

	cancel : function (component, event, helper) {
		$A.get("e.force:closeQuickAction").fire();
	}
})