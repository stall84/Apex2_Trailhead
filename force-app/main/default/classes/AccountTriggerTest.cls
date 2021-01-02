@isTest
public class AccountTriggerTest {
    @isTest static void TestCreate() {
        List<Account> accts = new List<Account>();
        for(Integer i=0; i<200; i++) {
            Account acc = new Account(Name='TestAccnt ' + i, BillingState ='CA');
            accts.add(acc);
        }
        
        Test.startTest();
        insert accts;
        Test.stopTest();
        
        
            List<Account> verifyAccts = [SELECT ShippingState FROM Account];
        	for(Account a : verifyAccts) {
            System.assertEquals('CA', a.ShippingState, 'Error');
        }
    }
}