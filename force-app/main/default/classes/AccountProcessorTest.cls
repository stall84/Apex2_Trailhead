@isTest
private class AccountProcessorTest {

    @isTest static void testCountContacts() {
        
        Account newAccount = new Account(Name='Test Account');
        insert newAccount;
        
        Contact newContact1 = new Contact(FirstName='Stephen',
                                         LastName='Derp',
                                         AccountId=newAccount.Id);
        insert newContact1;
        
        Contact newContact2 = new Contact(FirstName='Michael',
                                         LastName='Dumb',
                                         AccountId=newAccount.Id);
        insert newContact2;
        
        List<Id> acctList = new List<Id>();
        acctList.add(newAccount.Id);
        
            Test.startTest();
        
            	AccountProcessor.countContacts(acctList);
        		
            Test.stopTest();
        
        System.assertEquals(2, 
                            [SELECT Number_of_Contacts__c FROM Account WHERE Id = :newAccount.Id]
                           .Number_of_Contacts__c
                           );
    }
}