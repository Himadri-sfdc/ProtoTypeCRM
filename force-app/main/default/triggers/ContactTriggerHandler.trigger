trigger ContactTriggerHandler on Contact (before insert,after update) {

    UpdateAccAndNonPriConFromPriContact.AccPhoneNonPriConUpdate(trigger.new, trigger.oldMap);

    DuplicateBasedOnFirstAndLastName.DuplicateFirstAndLastName(trigger.new);
}