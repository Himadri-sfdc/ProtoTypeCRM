public with sharing class AccountController {
    
     @AuraEnabled(cacheable=true)
    public static List<Account> getAccounts() {
        // Query some fields from Account
        return [SELECT Id, Name, Industry, Phone, Type FROM Account LIMIT 10];
    }
}