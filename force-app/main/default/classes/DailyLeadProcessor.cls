/**
 * @author Michael Stallings
 * @date 01/03/2021
 * @group Lead
 * @see JIRA-123
 * @description Scheduled Apex Class to update Lead records w/ specific Lead Source.
 */

global class DailyLeadProcessor implements Schedulable {
    

    global void execute (SchedulableContext ctxt) {

        List<Lead> leadsToUpdate = new List<Lead>();

        List<Lead> leadsQuery = [SELECT Id 
                                    FROM Lead 
                                    WHERE LeadSource = NULL 
                                    LIMIT 200];

        for (Lead ld : leadsQuery) {
            ld.LeadSource = 'Dreamforce';
            leadsToUpdate.add(ld);
        }

        update leadsToUpdate;

    }

}
