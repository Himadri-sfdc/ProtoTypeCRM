

public with sharing class PrimaryContactHandler{

      public static void validPrimaryContact(List<Contact> conList,Map<Id,Contact> oldMap){

          Set<Id> setId = new Set<Id>();
          Set<Id> ConWithPri = new Set<Id>();

          for(Contact newCon : conList)
          {
               if(String.isNotBlank(newCon.AccountId) && newCon.PrimaryContact__c)
               {
                    if(oldMap != null)
                    {
                         Contact oldCon = oldMap.get(newCon.Id);

                         if(oldCon != null || newCon.AccountId != oldCon.AccountId || newCon.PrimaryContact__c != oldCon.PrimaryContact__c)
                         {
                              setId.add(newCon.AccountId);
                         }
                    }
                    else 
                    {
                         setId.add(newCon.AccountId);
                    }
               }
          }
          if(!setId.isEmpty())
          {
               List<Contact> contactList = [SELECT AccountId,PrimaryContact__c FROM Contact WHERE AccountId IN : setId AND PrimaryContact__c = TRUE];
               {
                    for(Contact con : contactList)
                    {
                          ConWithPri.add(con.AccountId);
                    }
               }
               for(Contact newCon : conList)
               {
                    if(String.isNotBlank(newCon.AccountId) && newCon.PrimaryContact__c == true)
                    {
                         if(conWithpri.contains(newCon.AccountId))
                         {
                              newCon.addError('Primary Contact is already present Linked with '+newCon.AccountId);
                         }
                    }
               }
          }
      }
}

    
     