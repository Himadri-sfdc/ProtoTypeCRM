public with sharing class AccountContlr {
    
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccounts(String searchKey,Integer limitSize,Integer offsetSize){
        return [SELECT Id,Name,Industry 
                FROM Account 
                WHERE Name LIKE :('%'+searchKey+'%')
                LIMIT :limitSize OFFSET :offsetSize];
    }
}