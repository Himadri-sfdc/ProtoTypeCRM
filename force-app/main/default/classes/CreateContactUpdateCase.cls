public with sharing class CreateContactUpdateCase {
    
    public static void UpdateCreateContact(List<Case> caseList)
    {
        
        Set<String> setEmail = new Set<String>();
        Map<String,Id> conMap = new Map<String,Id>();
        List<Contact> contactList = new List<Contact>();
        
        for(Case newCase : caseList)
        {
            if(String.isNotBlank(newCase.SuppliedEmail__c))
            {
                setEmail.add(newCase.SuppliedEmail__c);
            }
        }
        if(!setEmail.isEmpty())
        {
            List<Contact> ListCon = [SELECT AccountId,Email FROM Contact WHERE Email IN : setEmail];
            
            for(Contact con : ListCon)
            {
                conMap.put(con.Email,con.Id);
            }
        }
        for(Case newCase : caseList)
        {
            if(String.isNotBlank(newCase.SuppliedEmail__c) && conMap.containskey(newCase.SuppliedEmail__c))
            {
                newCase.ContactId = conMap.get(newCase.SuppliedEmail__c);
            }
            else
            {
                Contact cons = new Contact();
                cons.Email = newCase.SuppliedEmail__c;
                cons.LastName = 'Contact new Case Email';
                contactList.add(cons);
            }
        }
        if(!contactList.isEmpty())
        {
            insert contactList;
            
            for(Contact contact : contactList)
            {
                conMap.put(contact.Email,contact.Id);
            }
            for(Case newCase : caseList)
            {
                if(String.isNotBlank(newCase.SuppliedEmail__c) && conMap.containskey(newCase.SuppliedEmail__c))
                {
                    newCase.ContactId = conMap.get(newCase.SuppliedEmail__c);
                }
            }
        }
    }
}