trigger TaskTrigger on Task__c (before insert, before update, after update, after insert) {

    if(Trigger.isBefore){
        if(Trigger.isInsert){
            TaskUtility.beforeMethods(trigger.new, trigger.oldMap);
        }
        if(Trigger.isUpdate){
            TaskUtility.beforeMethods(trigger.new, trigger.oldMap);
        }
    }
    if(Trigger.isAfter){
        if(Trigger.isInsert){
            TaskUtility.buldPackageOnTaskChange(trigger.new, trigger.oldMap);
        }
        if(Trigger.isUpdate){
            TaskUtility.buldPackageOnTaskChange(trigger.new, trigger.oldMap);
        }
    }
}