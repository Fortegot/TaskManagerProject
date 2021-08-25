trigger ApexElementsTrigger on ApexElements__c (before insert, before update, after Insert, after update) {

    if(Trigger.isBefore){
        if(Trigger.isInsert){
            ApexElements_Util.BeforeMethods(Trigger.oldMap, Trigger.new);
        
        }
        if(Trigger.isUpdate){
            ApexElements_Util.BeforeMethods(Trigger.oldMap, Trigger.new);

        }
    }

    if(Trigger.isAfter){
        if(Trigger.isInsert){
            ApexElements_Util.afterMethods(Trigger.oldMap, Trigger.new);
        
        }
        if(Trigger.isUpdate){
            ApexElements_Util.afterMethods(Trigger.oldMap, Trigger.new);

        }
    }
}