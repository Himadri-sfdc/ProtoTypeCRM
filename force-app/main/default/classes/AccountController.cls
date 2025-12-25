public with sharing class AccountController {
       @AuraEnabled(cacheable=false)
    public static List<Account> fetchAccounts(String searchKey) {
        String key = '%' + searchKey + '%';
        if (String.isBlank(searchKey)) {
            return [SELECT Id, Name, Industry, AnnualRevenue FROM Account LIMIT 100];
        } else {
            return [
                SELECT Id, Name, Industry, AnnualRevenue 
                FROM Account 
                WHERE Name LIKE :key 
                LIMIT 15
            ];
        }
    }

    @AuraEnabled(cacheable=false)
    public static List<Contact> getContactsByAccount(Id accountId) {
        return [
            SELECT Id, FirstName, LastName, Email, Phone 
            FROM Contact 
            WHERE AccountId = :accountId 
            LIMIT 15
        ];
    }
}