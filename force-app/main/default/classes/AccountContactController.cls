
public with sharing class AccountContactController {
   
    @AuraEnabled(cacheable=true)
    
    public static List<Account> getAccountsWithRelatedRecords() {
        return [
            SELECT Id, Name,
                   (SELECT Id, Name, Email FROM Contacts),
                   (SELECT Id, Name, StageName, Amount FROM Opportunities)
            FROM Account
        ];
    }
}