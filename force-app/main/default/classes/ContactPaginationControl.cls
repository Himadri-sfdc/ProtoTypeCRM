public with sharing class ContactPaginationControl {
  
    @AuraEnabled(cacheable=true)
    public static Integer getTotalContacts() {
        return [SELECT COUNT() FROM Contact];
    }

    @AuraEnabled(cacheable=true)
    public static List<Contact> getContacts(Integer pageSize, Integer pageNumber) {
        Integer offsetSize = (pageNumber - 1) * pageSize;

        return [
            SELECT Id, Name, Email, Phone
            FROM Contact
            ORDER BY CreatedDate DESC
            LIMIT :pageSize OFFSET :offsetSize
        ];
    }
}