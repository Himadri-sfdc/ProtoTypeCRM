
public with sharing class UpdateContactPhoneFromAcc {

     public static void updatePhone(List<Account> accList,Map<Id,Account> oldMap)
     {
        Map<Id,Account> accMap = new Map<Id,Account>();

        List<Contact> conList = new List<Contact>();

        for(Account acc : accList)
        {
            if(oldMap != null)
            {
                Account oldAcc = oldMap.get(acc.Id);

                if(acc.Phone != oldAcc.Phone)
                {
                    accMap.put(acc.Id,acc);
                }
            }
            if(!accMap.isEmpty())
            {
                for(Contact con : [SELECT Id,AccountId,Phone FROM Contact WHERE AccountId IN : accMap.keyset()])
                {
                    con.Phone = accMap.get(con.AccountId).Phone;

                    conList.add(con);
                }

                if(!conList.isEmpty())
                {
                    update conList;
                }
            }
        }
     }
}