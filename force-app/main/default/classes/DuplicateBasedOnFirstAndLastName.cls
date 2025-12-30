

public with sharing class DuplicateBasedOnFirstAndLastName {

   public static void DuplicateFirstAndLastName(List<Contact> conList)
    {
        Set<String> FirstNames = new Set<String>();
        Set<String> LastNames = new Set<String>();
        
        Map<String,Id> maptoName = new Map<String,Id>();
        
        for(Contact con : conList)
        {
            if(String.isNotBlank(con.FirstName) && String.isNotBlank(con.LastName))
            {
                FirstNames.add(con.FirstName);
                LastNames.add(con.LastName);
            }
        }
        if(!FirstNames.isEmpty())
        {
            List<Contact> contactList = [SELECT Id,LastName,FirstName FROM Contact WHERE FirstName IN : FirstNames AND LastName IN : LastNames];
            
            for(Contact con : contactList)
            {
                String key = con.LastName+'-'+con.FirstName;
                
                maptoName.put(key,con.Id);
            }
            
            for(Contact con : conList)
            {
                if(String.isNotBlank(con.FirstName) && String.isNotBlank(con.LastName))
                {
                    String key = con.LastName +'-'+ con.FirstName;
                    
                    if(maptoName.containskey(key))
                    {
                        con.addError('Duplicate First and Last name : Cannot insert');
                        
                    }
                }
            }
        }
    }
}