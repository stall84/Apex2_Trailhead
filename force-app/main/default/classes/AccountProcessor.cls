/** 
 * @author Michael Stallings
 * @date 12/31/2020
 * @group Accounts
 * @description Class To Update Account and Other 
 * @see JIRA-123
**/
public with sharing class AccountProcessor {
   
    @future
    public static void countContacts(List<Id> accountIds) {
      
        List<Account> accounts = [SELECT Id, (SELECT Id FROM Contacts) FROM Account WHERE Id IN :accountIds];
        List<Account> accountsToUpdate = new List<Account>();
        for (Account acc : accounts) {
            List<Contact> contactList = acc.Contacts;
            acc.Number_of_Contacts__c = contactList.size();
            accountsToUpdate.add(acc);
        }
       update accountsToUpdate;
    }
}