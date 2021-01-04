/**
 * @author Michael Stallings
 * @date 01/03/2021
 * @group HTTP Requests
 * @see JIRA-123
 * @description Apex Class calling REST endpoint to return name of animal. 
 */

public with sharing class AnimalLocator {
    
    public static String getAnimalNameById (Integer id) {

        String animalName;
        Http http = new Http();
        HttpRequest request = new HttpRequest();

            request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals/'+id);
            request.setMethod('GET');

        HttpResponse response = http.send(request);

        if (response.getStatusCode() == 200) {
            Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            Map<String, Object> animal = (Map<String, Object>) results.get('animal');
            animalName = String.valueOf(animal.get('name'));
            
        } 
        return animalName;
    }
}