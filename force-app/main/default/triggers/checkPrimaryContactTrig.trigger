trigger checkPrimaryContactTrig on Contact (before insert,before update) {

    if(trigger.isbefore && (trigger.isInsert || trigger.isUpdate))
    {
        //PrimaryContactHandler.validPrimaryContact(trigger.new,trigger.oldMap);
    }
    if(trigger.isBefore && trigger.isInsert)
    {
        PreventEmailContactDuplicateHandler.preventEmailDuplication(trigger.new);
    }
}