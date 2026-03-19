public with sharing class SuppliedEmailCaseContactLink {
    
    public static void LinkCaseContactCreate(List<Case> caseList)
    {
        Set<String> setcase = new Set<String>();
        Map<String,Id> conMap = new Map<String,Id>();
        List<Contact> contactList = new List<Contact>();
        
        for(Case cs : caseList)
        {
            if(String.isNotBlank(cs.SuppliedEmail__c))
            {
                setcase.add(cs.SuppliedEmail__c);
            }
        }
        
        if(!setCase.isEmpty())
        {
            for(Contact con : [SELECT Id,Email FROM Contact WHERE Email IN : setCase])
            {
                conMap.put(con.Email,con.Id);
            }
        }
        
        for(Case cs : caseList)
        {
            if(String.isNotBlank(cs.SuppliedEmail__c) && conMap.containsKey(cs.SuppliedEmail__c))
            {
                cs.ContactId = conMap.get(cs.SuppliedEmail__c);
            }
            else
            {
                Contact cont = new Contact();
                cont.LastName = 'Contact From Case';
                cont.Email = cs.SuppliedEmail;
                contactList.add(cont);
            }
        }
        if(!contactList.isEmpty())
        {
            insert contactList;
            
            for(Contact con : contactList)
            {
                conMap.put(con.Email,con.Id);
            }
            for(Case cs : caseList)
            {
                if(String.isNotBlank(cs.AccountId) && conMap.containsKey(cs.SuppliedEmail__c))
                {
                    cs.ContactId = conMap.get(cs.SuppliedEmail__c);
                }
            }
        }
    }
}