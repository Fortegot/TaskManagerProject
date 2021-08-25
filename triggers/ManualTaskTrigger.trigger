trigger ManualTaskTrigger on ManualTask__c (before insert) {

    if(Trigger.isBefore){
        if(Trigger.isInsert){
            ManualTask_Util.beforeMethods(trigger.New);
        }
    }

}