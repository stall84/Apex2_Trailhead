/**
 * @author Michael Stallings
 * @date 01/01/2021
 * @group Contact
 * @see JIRA-123
 * @description Test run on queueable Apex class 
 */

@isTest
public class AddPrimaryContactTest {
    
    
    @TestSetup
    static void setup () {
        List<Account> insertAccts = new List<Account>();

        for (Integer i = 0; i < 50; i++) {
            Account acc = new Account(
                Name = 'Tester'+i,
                billingState = 'NY'
            );
            insertAccts.add(acc);
        }
        for (Integer j = 0; j < 50; j++) {
            Account acct = new Account(
                Name = 'TesterD'+j,
                billingState = 'CA'
            );
            insertAccts.add(acct);
        }
        insert insertAccts;

        
    }

    
    static testmethod void runTest () {
        Contact con = new Contact();
        con.firstName = 'Tester';
        con.lastName = 'Demoboy';

        insert con;

        String state = 'CA';

        AddPrimaryContact apc = new AddPrimaryContact(con, state);
        Test.startTest();
        System.enqueueJob(apc);
        Test.stopTest();

    }
}