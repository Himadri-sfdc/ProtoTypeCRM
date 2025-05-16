trigger checkPrimaryContactTrig on Contact (before insert,before update) {

    if(trigger.isBefore && trigger.isInsert)
    {
        PrimaryContactHandler.beforeInsert(trigger.new);
    }
    else if(trigger.isBefore && trigger.isUpdate)
    {
        PrimaryContactHandler.beforeUpdate(trigger.new,trigger.oldMap);
    }
}