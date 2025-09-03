trigger caseCreateConatct on Case (before insert) {

    CreateContactUpdateCase.createUpdateContact(trigger.new);
}