public with sharing class SortingController {
    
    @AuraEnabled(cacheable=true)
    public static List<Opportunity> fetchData(){

        List<Opportunity> oppList = [SELECT Id,Name,Amount FROM Opportunity 
                                     WHERE Amount != null LIMIT 10];

        return oppList;                             
    }
}