
public with sharing class EnforcePrimaryContact {

   public static void PrimaryContactHandler(List<Contact> conList,Map<id,Contact> oldMap)
   {
       Set<Id> accId = new Set<Id>();
       Set<Id> conWithPri = new Set<Id>();

       for(Contact con : conList)
       {
           if(String.isNotBlank(con.AccountId) && con.PrimaryContact__c == TRUE)
           {
               if(oldMap != null)
               {
                   Contact oldCon = oldMap.get(con.Id);

                   if(oldCon == null || con.PrimaryContact__c != con.PrimaryContact__c || con.AccountId != oldCon.AccountId)
                   {
                        accId.add(con.AccountId);
                        accId.add(oldCon.AccountId);
                   }
                   else
                   {
                       accId.add(con.AccountId);
                   }
               }
               else
               {
                    accId.add(con.AccountId);
               }
           }
       }
       if(!accId.isEmpty())
       {
          for(Contact con : [SELECT AccountId,PrimaryContact__c FROM Contact WHERE AccountId IN : accId])
          {
              conWithPri.add(con.AccountId);
          }
       }
       for(Contact con : conList)
       { 
           if(String.isNotBlank(con.AccountId) && con.PrimaryContact__c == TRUE)
           {
              if(conWithPri.contains(con.AccountId))
              {
                  con.addError('Primary Contact is Linked To Account');
              }
           }
       }
   }
}  