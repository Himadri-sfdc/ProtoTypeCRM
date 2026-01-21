
public with sharing class PreventEmailContactDuplicateHandler {

    public static void preventEmailDuplication(List<Contact> conList)
    {
        Set<String> setCon = new Set<String>();
        Map<String,Id> existingEmailMap = new Map<String,Id>();

        for(Contact con : conList)
        {
            if(String.isNotBlank(con.Email))
            {
                setCon.add(con.Email);
            }
        }
        if(!setCon.isEmpty()) return;

        for(Contact con : [SELECT Id,Email FROM Contact WHERE Email IN : setCon])
        {
            existingEmailMap.put(con.Email,con.Id);
        }
        for(Contact con : conList)
        {
            if(existingEmailMap.containskey(con.Phone) && existingEmailMap.get(con.Phone) != con.Id)
            {
                con.addError('Duplicate email Found : CanNot be Inserted');
            }
        }
    }
}