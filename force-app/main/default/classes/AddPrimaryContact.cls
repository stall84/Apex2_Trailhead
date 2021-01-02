/**
 * @author Michael Stallings
 * @date 01/01/2021
 * @group Contact
 * @see JIRA-123
 * @description Queueable Apex class that inserts the same Contact for each Account for a specific state. 
 */

public with sharing class AddPrimaryContact implements Queueable {

    Contact contactMain;
    String stateCode;

    public AddPrimaryContact(Contact contact, String state) {
        this.contactMain = contact;
        this.stateCode = state;
    }

    public void execute (QueueableContext context) {
        //...
    }

}
