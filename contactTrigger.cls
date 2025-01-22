trigger ContactTrigger on Contact (after insert, after update, after delete) {
  Set<Id> accountIds = new Set<Id>();
    if(Trigger.isInsert || Trigger.IsUpdate){
      for(Contact con : Trigger.new){
        if(con.AccountId != null){
          accountIds.add(con.AccountId);     
        }      
      }  
    }
    if(Trigger.isDelete){
      for(Contact con : Trigger.new){
        if(con.AccountId != null){
          accountIds.add(con.AccountId);     
        }     
      }   
    }
    List<Account> accountsToUpdate = new List<Account>();
    for(AggregateResult result : [SELECT AccountId, COUNT(Id)totalContacts FROM Contact WHERE AccountId IN :accountIds GROUP BY AccountId]){
         Account accountToUpdate = new Account(Id = (Id)result.get('AccountId'));
         accountToUpdate.Total_Contacts_Count__c = (Decimal)result.get('totalContacts');
         accountsToUpdate.add(accountToUpdate);
    }
    
    if(!accountsToUpdate.isEmpty()){
      update accountsToUpdate;  
    }