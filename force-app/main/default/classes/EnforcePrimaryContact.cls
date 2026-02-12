
public with sharing class EnforcePrimaryContact {

    public static void PrimaryContactCheck(List<Contact> conList,Map<Id,Contact> oldMap)
    {
        Set<Id> accId = new Set<Id>();
        Set<Id> conWithPri = new Set<Id>();

        for(Contact newCon : conList)
        {
            if(String.isNotBlank(newCon.AccountId) && newCon.PrimaryContact__c == TRUE)
            {
                if(oldMap != null)
                {
                    Contact oldCon = oldMap.get(newCon.Id);

                    if(oldCon == null || newCon.AccountId != oldCon.AccountId || newCon.PrimaryContact__c != oldCon.PrimaryContact__c)
                    {
                        accId.add(newCon.AccountId);
                    }
                }
                else
                {
                    accId.add(newCon.AccountId);
                }
            }
        }
        if(!accId.isEmpty())
        {
            for(Contact con : [SELECT AccountId,PrimaryContact__c FROM Contact WHERE AccountId IN : accId AND PrimaryContact__c = TRUE])
            {
                conWithPri.add(con.AccountId);
            }
        }
        for(Contact newCon : conList)
        {
            if(String.isNotBlank(newCon.AccountId) && newCon.PrimaryContact__c == TRUE)
            {
                newCon.addError('Primary Contact is Linked With Account');
            }
        }
    }
}