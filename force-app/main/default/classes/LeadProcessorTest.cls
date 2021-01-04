/**
 * @author Michael Stallings
 * @date 01/01/2021
 * @group Tests
 * @see JIRA-123
 * @description Test run on LeadProcessor Batch Class to insert 200 Leads and update their LeadSource
 */

@isTest
private class LeadProcessorTest {

    @testSetup
    static void setup () {

        List<Lead> newLeads = new List<Lead>();

        for (Integer i = 0; i < 200; i++) {
            Lead ld = new Lead(Company='FlerdleDopolis', LastName='Flerlty'+i, status='Open - Not Contacted');
            newLeads.add(ld);
        }
        insert newLeads;

    }

    @isTest static void test () {
        Test.startTest();
            LeadProcessor leadProc = new LeadProcessor();
            Database.executeBatch(leadProc);
        Test.stopTest();

        System.assertEquals(200, [ SELECT COUNT() FROM Lead WHERE LeadSource='Dreamforce' ]);
    }
}