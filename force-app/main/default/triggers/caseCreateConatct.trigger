trigger caseCreateConatct on Case (before insert) {

    CreateContactUpdateCase.UpdateCreateContact(trigger.new);
}