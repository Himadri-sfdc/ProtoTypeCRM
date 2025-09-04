

public class AssignManagerBasedOnTeam {

    public static void AsignManager(List<User> listUser)
    {
        Set<String> setUser = new Set<String>();
        Map<String,Id> userMap = new Map<String,Id>();

        for(User newUser : listUser)
        {
            if(String.isNotBlank(newUser.Team__c))
            {
                setUser.add(newUser.Team__c);
            }
        }
        if(!setUser.isEmpty())
        {
            List<User> userList = [SELECT Team__c,Assign_Manager__c from User WHERE Team__c IN : setUser AND Assign_Manager__c = true];

            for(User user : userList)
            {
                userMap.put(user.Team__c,user.Id);
            }
        }
        for(User newUser : listUser){

            if(String.isNotBlank(newUser.Team__c) && userMap.containskey(newUser.Team__c)){

                newUser.ManagerId = userMap.get(newUser.Team__c);
            }
            else
            {
                newUser.addError('User is not Matching CanNot assign manager');
            }
        }
    }
}