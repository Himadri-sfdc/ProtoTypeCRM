public with sharing class PrimaryContactHandler{
    
    public static void EnforcePrimaryContact(List<Contact> conList,Map<Id,Contact> oldMap)
    {
        Set<Id> conId = new Set<Id>();
        Set<Id> conWithAcc = new Set<Id>();
        
        for(Contact newCon : conList)
        {
            if(newCon.PrimaryContact__c == true && String.isNotBlank(newCon.AccountId))
            {
                if(oldMap != null)
                {
                    Contact oldCon = oldMap.get(newCon.Id);
                    
                    if(newCon.PrimaryContact__c != oldCon.PrimaryContact__c || newCon.AccountId != oldCon.AccountId)
                    {
                        conId.add(newCon.AccountId);
                    }
                }
                else
                {
                    conId.add(newCon.AccountId);
                }
            }
        }
        if(!conId.isEmpty())
        {
            for(Contact con : [SELECT AccountId,PrimaryContact__c FROM Contact WHERE AccountId IN : conId AND PrimaryContact__c = TRUE])
            {
                conWithAcc.add(con.AccountId);
            }
        }
        
        for(Contact con : conList)
        {
            if(String.isNotBlank(con.AccountId) && con.PrimaryContact__c == TRUE)
            {
                if(conWithAcc.contains(con.AccountId))
                {
                    con.addError('Primary Contact Already Present');
                }
            }
        }
    }
}