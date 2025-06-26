public with sharing class GetAccDetails {
    
    @AuraEnabled(cacheable = true)
    public static List<Account> fetchData(){

        List<Account> accList = [SELECT Id,Name,Phone FROM Account
                                WHERE Phone != null LIMIT 10];

        return accList;
    }
}