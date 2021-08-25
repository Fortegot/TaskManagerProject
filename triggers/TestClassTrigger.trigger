trigger TestClassTrigger on TestClass__c (before insert, before update, after insert, after update) {
    if(Trigger.isBefore){
        if(Trigger.isInsert){
            TestClass_Util.BeforeMethods(Trigger.oldMap, Trigger.new);
        
        }
        if(Trigger.isUpdate){
            TestClass_Util.BeforeMethods(Trigger.oldMap, Trigger.new);
        }
    }
    if(Trigger.isAfter){
        if(Trigger.isInsert){
            TestClass_Util.afterMethods(Trigger.oldMap, Trigger.new);
        
        }
        if(Trigger.isUpdate){
            TestClass_Util.afterMethods(Trigger.oldMap, Trigger.new);

        }
    }
}