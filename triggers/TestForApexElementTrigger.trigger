trigger TestForApexElementTrigger on TestForApexElement__c (before insert, after insert, after delete) {

    if(Trigger.isBefore){
        if(Trigger.isInsert){
            TestForApexElement_Util.beforeMethod(Trigger.new);
        }
    }

    if(Trigger.isAfter){

        if(Trigger.isInsert){
            TestForApexElement_Util.buildRuntTestOnModify(Trigger.new);
        }
        if(Trigger.isDelete){
            TestForApexElement_Util.buildRuntTestOnModify(Trigger.old);
        }
    }

}