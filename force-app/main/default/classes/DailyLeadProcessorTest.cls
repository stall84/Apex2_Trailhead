/**
 * @author Michael Stallings
 * @date 01/03/2021
 * @group Lead Test
 * @see JIRA-123
 * @description Testing Scheduled Apex Class to update Lead records w/ specific Lead Source.
 */

@isTest
public with sharing class DailyLeadProcessorTest {


    @TestSetup
    static void setupLeads () {

        List<Lead> leadsToInsert = new List<Lead>();

        for (Integer i = 0; i < 200; i++) {
            leadsToInsert.add(new Lead(
                LastName = 'Asas'+i,
                Company = 'Flerdops'
            ));
        }

        insert leadsToInsert;
    }

    @isTest
    static void testLeadSrc () {

        DailyLeadProcessor dlp = new DailyLeadProcessor();

        Test.startTest();
        String jobId = System.schedule('Scheduled Apex Test',
                '0 0 0 15 3 ? 2022',
                dlp);

        Test.stopTest();

        //Verify/Assert
        List<Lead> insertedLeads = new List<Lead>();
        insertedLeads = [SELECT Id FROM Lead 
                                    WHERE LeadSource = 'Dreamforce' 
                                    AND Company = 'Flerdops'];

        System.assertEquals(200, insertedLeads.size(), 'Asserting 200 new leads w/Dreamforce Source');

    }

}
