public with sharing class AccountDataTableClass {
   
     @AuraEnabled(cacheable=true)
    public static List<Account> fetchAccounts(String searchKey) {
        searchKey = '%' + searchKey + '%';
        return [
            SELECT Id, Name, Industry, Phone
            FROM Account
            WHERE Name LIKE :searchKey
            LIMIT 10
        ];
    }

    @AuraEnabled(cacheable=true)
    public static List<Contact> fetchContacts(Id accountId) {
        return [
            SELECT Id, FirstName, LastName, Email, Phone, AccountId
            FROM Contact
            WHERE AccountId = :accountId
        ];
    }
}-