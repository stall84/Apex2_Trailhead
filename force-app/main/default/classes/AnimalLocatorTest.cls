/**
 * @author Michael Stallings
 * @date 01/03/2021
 * @group HTTP Requests Tests
 * @see JIRA-123
 * @description Test on Apex Class calling REST endpoint to return name of animal. 
 */

@isTest
private class AnimalLocatorTest {
  
    @isTest static void testGetCallout() {

        Test.setMock(HttpCalloutMock.class, new AnimalLocatorMock());

        String response = AnimalLocator.getAnimalNameById(2);

        System.assertEquals('bear', response);

    }
}