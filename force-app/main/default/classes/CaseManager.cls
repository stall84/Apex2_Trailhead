/**
 * @author Michael Stallings
 * @date 01/04/2021
 * @group REST Class All-Major-Methods
 * @see JIRA-123
 * @description REST Endpoint serving APEX Class utilizing all of the major HTTP Methods.
 */

@RestResource(urlMapping='/Cases/*')

global with sharing class CaseManager {
    
    @HttpGet
    global static Case getCaseById () {

        RestRequest request = RestContext.request;
        // Searches the substring '/Cases/case#', returns the substring after the last / which is the case number
        String caseId = request.requestURI.substring(
            request.requestURI.lastIndexOf('/')+1
        );
        Case result = [SELECT CaseNumber, Subject, Status, Origin, Priority
                        FROM Case
                        WHERE Id = :caseId];

        return result;
    }

    @HttpPost
    global static ID createCase (String subject, String status, String origin, String priority) {

        Case thisCase = new Case(
            Subject = subject,
            Status = status,
            Origin = origin,
            Priority = priority
        );

        insert thisCase;
        return thisCase.Id;
    }

    @HttpDelete
    global static void deleteCase () {
        RestRequest request = RestContext.request;
        String caseId = request.requestURI.substring(
            request.requestURI.lastIndexOf('/')+1
        );
        Case thisCase = [SELECT Id FROM Case WHERE Id = :caseId];

        delete thisCase;
    }

    @HttpPut
    global static ID upsertCase (String subject, String status, String origin, String priority, String id) {
        Case thisCase = new Case(
            Id = id,
            Subject = subject,          // Match case by Id, if present
            Status = status,            // Otherwise, create new case
            Origin = origin,
            Priority = priority
        );

        upsert thisCase;

        return thisCase.Id;
    }

    @HttpPatch
    global static ID updateCaseFields () {
        RestRequest request = RestContext.request;
        String caseId = request.requestURI.substring(
            request.requestURI.lastIndexOf('/')+1
        );
        Case thisCase = [SELECT Id FROM Case WHERE Id = :caseId];
        // Deserialize the JSON string into name-value pairs
        Map<String, Object> params = (Map<String, Object>) JSON.deserializeUntyped(request.requestbody.toString());
        // Iterate through each parameter field and value
        for (String fieldName : params.keySet()) {
            // Set the field and value on the Case sObject
            thisCase.put(fieldName, params.get(fieldName));
        }

        update thisCase;

        return thisCase.Id;
    }

}
