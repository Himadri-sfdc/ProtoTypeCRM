
trigger TriggerHandlerStageDuraion on Order__c (before update) {

    CalculatingStageDuration.trackingStageduration(trigger.new,trigger.oldMap);
}