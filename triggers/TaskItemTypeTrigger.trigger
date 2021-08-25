trigger TaskItemTypeTrigger on TaskItemType__c (before insert, before update, after insert, after update) {
    if(Trigger.isBefore){
        if(Trigger.isInsert){
            TaskItemTypeUtility.beforeMethods(trigger.oldMap, trigger.new);
        }
        if(Trigger.isUpdate){
            TaskItemTypeUtility.beforeMethods(trigger.oldMap, trigger.new);
        }
        
    }
    if(Trigger.isAfter){
        if(Trigger.isInsert){
            TaskItemTypeUtility.afterMethods(trigger.oldMap, trigger.new);
        }
        if(Trigger.isUpdate){
            TaskItemTypeUtility.afterMethods(trigger.oldMap, trigger.new);
        }
    }
}