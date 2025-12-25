
trigger AccountTriggerHandler on Account (before insert) {

    AccountPhoneEmailHnadler.PreventDuplicateEmail(trigger.new);
}