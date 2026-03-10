public with sharing class AccountControllerr {
    
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccs() {
        return [SELECT Id, Name, Industry FROM Account LIMIT 10];
    }
    @AuraEnabled
    public static List<Contact> getCons(Id accId) {
        return [SELECT Id, Name, Email FROM Contact WHERE AccountId = :accId];
    }
}