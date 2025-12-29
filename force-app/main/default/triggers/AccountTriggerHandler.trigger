
trigger AccountTriggerHandler on Account (before insert,after update) {

    //AccountPhoneEmailHnadler.PreventDuplicateEmail(trigger.new);

    UpdateContactPhoneFromAcc.updatePhone(trigger.new,trigger.oldMap);
}