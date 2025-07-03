public with sharing class UserLookupController {
    @AuraEnabled(cacheable=true)
    public static List<User> searchUsers(String keyword) {
        return [
            SELECT Id, Name FROM User
            WHERE Name LIKE :('%' + keyword + '%')
            ORDER BY Name
            LIMIT 10
        ];
    }
}
