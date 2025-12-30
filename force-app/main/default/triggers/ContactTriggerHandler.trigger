trigger ContactTriggerHandler on Contact (after update) {

    UpdateAccAndNonPriConFromPriContact.AccPhoneNonPriConUpdate(trigger.new, trigger.oldMap);
}