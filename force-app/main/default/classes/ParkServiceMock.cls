/**
 * @author Michael Stallings
 * @date 01/03/2021
 * @group HTTP Requests SOAP Mock Data
 * @see JIRA-123
 * @description Mock Data for Test of Apex Class making a callout to a SOAP endpoint utilizing WSDL Classes generated by WSDL2Apex
 */

@isTest
global class ParkServiceMock implements WebServiceMock {

   global void doInvoke(
           Object stub,
           Object request,
           Map<String, Object> response,
           String endpoint,
           String soapAction,
           String requestName,
           String responseNS,
           String responseName,
           String responseType) {
        // start - specify the response you want to send
        List<String> parks = new List<String>();
        parks.add('Yosemite');
        parks.add('Yellowstone');
        parks.add('Another Park');
        ParkService.byCountryResponse response_x = 
            new ParkService.byCountryResponse();
        response_x.return_x = parks;
        // end
        response.put('response_x', response_x); 
   }
}


