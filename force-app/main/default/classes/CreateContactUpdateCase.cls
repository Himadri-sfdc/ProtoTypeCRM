

public with sharing class CreateContactUpdateCase {

    public static void createUpdateContact(List<Case> caseList)
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
            List<Contact> conList = [SELECT Id,Email,AccountId FROM Contact WHERE Email IN : setEmail];

            for(Contact cons : conList)
            {
                conMap.put(cons.Email,cons.Id);
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
                Contact contact = new Contact();
                contact.LastName = 'ContactIsCreatedByCaseEmail';
                contact.Email = newCase.SuppliedEmail__c;
                contactList.add(contact);
            }
        }
        if(!contactList.isEmpty())
        {
            insert contactList;

            for(Contact con : contactList)
            {
                conMap.put(con.Email,con.Id);
            }
            for(Case newCase : caseList)
            {
                if(String.isNotBlank(newCase.SuppliedEmail__c) && conMap.containskey(newCase.SuppliedEmail__c))
                {
                    newCase.ContactId = conMap.get(newCase.SuppliedEmail__c); 
                    System.debug('new commit');
                }
            }
        }
    }
}