global class opportunityReviewTaskScheduler implements Schedulable{
    global void execute(SchedulableContext sc){
      List<Opportunity> openOpportunities = [SELECT Id, OwnerId, Name FROM Opportunity WHERE IsClosed = FALSE];
      List<Task> tasksToInsert = new List<Task>();
       for(Opportunity op : openOpportunities){
         Task task = new Task(Subject = 'Review Opportunities:'+ op.Name, WhatId = op.Id, OwnerId = op.OwnerId,
                              Status = 'Not Started', Priority = 'Normal', ActivityDate = System.today().AddDays(7));
         tasksToInsert.add(task);  
       } 
        if(!tasksToInsert.isEmpty()){
          insert tasksToInsert;  
        }
    }
}