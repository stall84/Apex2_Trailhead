/** 
 * @author Michael Stallings
 * @date 01/01/2021
 * @see JIRA-123
 * @group Accounts
 * @description Class to create random accounts to populate trailhead for batch processes later on
 */

public with sharing class AccountContactCreator {

    /**
     * @description Empty base constructor
     */
    public AccountContactCreator() {
        //...
    }
    /** 
     * @description Method to create 180 Accounts, insert them, store the new Id's, then Add a single Contact for each of those new Accounts
     */ 
    public static void createAccCons() {
        List<String> lets = new List<String>{'A', 'D', 'F', 'H', 
                                            'I', 'L', 'N', 'O', 
                                            'Q', 'U', 'V', 'Z'};
        List<Account> newAccounts = new List<Account>();
        List<Contact> newContacts = new List<Contact>();
        List<Id> newAccIdList = new List<Id>();

    /** @description Attempting to create around 180 New account records by nesting for loop with above letters **/
        for (Integer i = 0; i < 15; i++) { 
            for (String let : lets) {
                Account acc = new Account(Name=let+i);
                newAccounts.add(acc);
            }
        }
    /** @description Insert new accounts and Save newly created Account ID's in List **/
        List<Database.SaveResult> insertResults = Database.insert(newAccounts, false);

        for (Database.SaveResult sr : insertResults) {
            if (sr.isSuccess()) {
                newAccIdList.add(sr.getId());
            } 
            else {
                // Operation failed, so get all errors                
                for (Database.Error err : sr.getErrors()) {
                    System.debug('The following error has occurred in ACCOUNT Insert.');
                    System.debug(err.getStatusCode() + ': ' + err.getMessage());
                }
            }
        }

        for (Integer j = 0; j < newAccIdList.size(); j++) {
            newContacts.add(new Contact(firstname='Con', lastname='Derper'+j, accountId=newAccIdList[j]));
        }

        List<Database.SaveResult> insertConResults = Database.insert(newContacts, false);

        for (Database.SaveResult src : insertConResults) {
            
                for (Database.Error err : src.getErrors()) {
                    System.debug('The following error has occurred in CONTACT Insert.');
                    System.debug(err.getStatusCode() + ': ' + err.getMessage());
                }
            
        }

    }
}