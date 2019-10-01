({
	init : function(component, event, helper) {
			
		var recordId = component.get('v.recordId');
		var bannerType = component.get('v.bannerType');
		var theme = component.get('v.theme');

		var broadcastBanner = component.get('v.broadcastBanner');
		var iconpath = component.get('v.iconpath');

		component.set('v.themeClass', helper.themeDefault[theme]);

		if (!iconpath) {
			// get default value
			component.set('v.iconpath', helper.iconDefault[theme]);
		}

		if (broadcastBanner) {
			// if the banner is added to broadcast a message, just show it
			component.set('v.showBanner', broadcastBanner);
			return;
		}

		var isFlaggedAction = component.get('c.isFlagged');
		isFlaggedAction.setParams({'recordId' : recordId, 'type' : bannerType});

		isFlaggedAction.setCallback(this, function(response) {

			if (response.getState() === 'SUCCESS') {

				component.set('v.showBanner', response.getReturnValue());
			}
		});

		$A.enqueueAction(isFlaggedAction);
	}
})