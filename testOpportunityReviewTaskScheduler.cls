@isTest
private class testOpportunityReviewTaskScheduler {
    @isTest static void testScheduler(){
      List<Opportunity> testOpportunities = new List<Opportunity>();
        for(Integer i = 0; i < 5; i++){
           testOpportunities.add(new Opportunity(Name = 'Test Opportunity' + i, 
                                                StageName = 'Prospecting', 
                                                CloseDate = System.today().addDays(30)
                                                )); 
        }  
        insert testOpportunities;
        Test.startTest();
        OpportunityReviewTaskScheduler scheduler = new OpportunityReviewTaskScheduler();
        scheduler.execute(null);
        Test.stopTest();
        
        List<Task> tasks = [SELECT Id, Subject, WhatId, OwnerId FROM Task];
        System.assertEquals(5, tasks.size(), 'The number of tasks created should match the number of open Opportunities name.');
        for(Integer i = 0; i < testOpportunities.size(); i++){
           Opportunity op = testOpportunities[i];
           Task task = tasks[i];
           System.assertEquals('Review Opportunity: '+ op.Name, task.Subject, 'Task subject should match opportunity name.');
           System.assertEquals(op.Id, task.WhatId, 'Task should be linked to the correct Opportunity.');
           System.assertEquals(op.OwnerId, task.OwnerId,'Task Owner Should match Opportunity Owner.'); 
        }
    }
    
}