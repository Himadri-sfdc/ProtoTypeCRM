
public with sharing class SearchingSortingController {
    @AuraEnabled(cacheable=false)
    public static List<Opportunity> fetchData(String searchKey) {
        String key = '%' + searchKey + '%';
        if (String.isBlank(searchKey)) {
            return [SELECT Id, Name, Amount FROM Opportunity LIMIT 10];
        } else {
            return [SELECT Id, Name, Amount FROM Opportunity WHERE Name LIKE :key LIMIT 10];
        }
    }
}