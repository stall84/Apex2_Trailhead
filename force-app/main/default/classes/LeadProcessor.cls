/**
 * @author Michael Stallings
 * @date 01/01/2021
 * @group Leads
 * @see JIRA-123
 * @description Batchable Class to query-pull all existing Lead records from org, then update them with a specific Lead Source
 */

public with sharing class LeadProcessor implements Database.Batchable<SObject> {
    /**
     * @description Batch Class with following Interfaced methods 
     */

    List<Lead> leadsToUpdate = new List<Lead>();

       
    public Database.QueryLocator start (Database.BatchableContext bc) {
        
        return Database.getQueryLocator('SELECT Id FROM Lead');
    }

    public void execute (Database.BatchableContext bc, List<Lead> scope) {
        for (Lead ld : scope) {
            ld.LeadSource = 'Dreamforce';
            leadsToUpdate.add(ld);
        }
        update leadsToUpdate;
    }

    public void finish (Database.BatchableContext bc) {
        System.debug('Batch processing of Lead Source Complete');
    }

}