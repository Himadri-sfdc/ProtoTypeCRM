

trigger AssignMangerToUser on User (before insert) {

    AssignManagerBasedOnTeam.AsignManager(trigger.new);
}