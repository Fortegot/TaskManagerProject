trigger TaskItemTrigger on TaskItem__c (after insert, after update, after delete) {
    if(trigger.isAfter){
        if(trigger.isInsert){
            TaskItemUtil.rebuildPackage(Trigger.newMap);
        }
    }
    if(trigger.isAfter){
        if(trigger.isupdate){
            TaskItemUtil.rebuildPackage(Trigger.newMap);
            
        }
    }
    if(trigger.isAfter){
        if(trigger.isDelete){
            TaskItemUtil.rebuildPackage(Trigger.oldMap);
            
        }
    }
}