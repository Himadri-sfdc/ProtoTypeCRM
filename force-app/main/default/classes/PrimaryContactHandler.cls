public with sharing class PrimaryContactHandler{

     public static void validPrimaryContact(List<Contact> conList,Map<Id,Contact> oldMap)
     {
        Set<Id> accId = new Set<Id>();
      Set<Id> accWithAccountId = new Set<Id>();
      
      for(Contact newCon : conList)
      {
          if(newCon.PrimaryContact__c == true && String.isNotBlank(newCon.AccountId))
          {
              if(oldMap != null)
              {
                  Contact oldCon = oldMap.get(newCon.Id);
                  
                  if(oldCon == null || oldCon.PrimaryContact__c != newCon.PrimaryContact__c || oldCon.AccountId != newCon.AccountId)
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
          for(Contact con : [SELECT Id,AccountId,PrimaryContact__c FROM Contact WHERE AccountId IN : accId AND PrimaryContact__c = TRUE])
          {
              accWithAccountId.add(con.AccountId);
          }
      }
      for(Contact newCon : conList)
      {
          if(newCon.PrimaryContact__c == true && String.isNotBlank(newCon.AccountId))
          {
              if(accWithAccountId.contains(newCon.AccountId))
              {
                  newCon.addError('Primary contact linked to Account');
              }
          }
      }
     }
}