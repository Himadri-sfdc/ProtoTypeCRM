
public with sharing class UpdateAccAndNonPriConFromPriContact {

    public static void AccPhoneNonPriConUpdate(List<Contact> conList,Map<Id,Contact> oldMap)
    {
        Map<Id,Contact> conMap = new Map<Id,Contact>();

        List<Account> accList = new List<Account>();

        List<Contact> consList = new List<Contact>();

        for(Contact con : conList)
        {
            if(con.Phone != oldMap.get(con.Id).Phone && con.PrimaryContact__c == TRUE)
            {
                conMap.put(con.AccountId,con);
            }
        }
        if(!conMap.isEmpty())
        {
            List<Account> AccountList = [SELECT Id,Phone FROM Account WHERE Id IN : conMap.keyset()];
            
            for(Account acc : AccountList)
            {
                acc.Phone = conMap.get(acc.Id).Phone;

                accList.add(acc);
            }
            if(!accList.isEmpty())
            {
                update accList;
            }

            List<Contact> contactList = [SELECT Id,AccountId,Phone,PrimaryContact__c  FROM Contact WHERE AccountId IN : conMap.keyset()];

            for(Contact con : contactList)
            {
                if(con.PrimaryContact__c == FALSE)
                {
                    con.Phone = conMap.get(con.AccountId).Phone;
                }
            }
            if(!consList.isEmpty())
            {
                update consList;
            }
        }
    }
}