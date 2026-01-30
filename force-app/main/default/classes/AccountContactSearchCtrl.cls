
public with sharing class AccountContactSearchCtrl {

    @AuraEnabled(cacheable=true)
    public static List<Account> getAccountList(String searchKey) {
        String key = '%' + searchKey + '%';
        return [SELECT Id, Name, Industry FROM Account WHERE Name LIKE :key LIMIT 10];
    }

    @AuraEnabled(cacheable=true)
    public static List<Contact> getRelatedContacts(Id accountId) {
        return [SELECT Id, FirstName, LastName, Email FROM Contact WHERE AccountId = :accountId];
    }
}