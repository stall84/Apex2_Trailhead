/**
 * @author Michael Stallings
 * @date 01/01/2021
 * @group Contact
 * @see JIRA-123
 * @description Queueable Apex class that inserts the same Contact for each Account for a specific state. 
 */

public with sharing class AddPrimaryContact implements Queueable {

    public Contact contactMain;
    public String stateCode;
    public List<Account> statesList = new List<Account>();
    public List<Contact> contactsToUpdate = new List<Contact>();

    public AddPrimaryContact(Contact contact, String state) {
        this.contactMain = contact;
        this.stateCode = state;
    }

    public void execute (QueueableContext context) {
       statesList = [SELECT Id FROM Account WHERE billingState = :stateCode LIMIT 200];
       
       for (Account acc : statesList) {
           Contact newCon = contactMain.clone(false, false, false, false);
            newCon.AccountId = acc.Id;
           
            contactsToUpdate.add(newCon);
       }
       if (contactsToUpdate.size() > 0) {
           insert contactsToUpdate;
       }
    }

}