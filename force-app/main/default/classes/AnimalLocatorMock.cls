/**
 * @author Michael Stallings
 * @date 01/03/2021
 * @group HTTP Requests Tests Mock
 * @see JIRA-123
 * @description Global Mock Class to call in tests on Apex Class calling REST endpoint to return name of animal. 
 */

@isTest

global class AnimalLocatorMock implements HttpCalloutMock {
    
    global HttpResponse respond (HttpRequest request) {
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setBody('{"animal":{"id":2,"name":"bear","eats":"berries, campers, adam seligman","says":"yum yum"}}');
        response.setStatusCode(200);
        return response;
    }
}