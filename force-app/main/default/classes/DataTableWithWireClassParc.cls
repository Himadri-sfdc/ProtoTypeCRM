
public with sharing class DataTableWithWireClassParc {

    @AuraEnabled(cacheable=true)
    public static List<Contact> searchContacts(String searchKey) {

        String key = '%' + searchKey + '%';

        return [
            SELECT Id, Name, Email, Phone
            FROM Contact
            WHERE Name LIKE :key
            LIMIT 5
        ];
    }
}