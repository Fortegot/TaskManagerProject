public class ApexElements_Util {
    public static void beforeMethods(map<Id, ApexElements__c> triggerOldMap, list<ApexElements__c> triggerNew) {

        TestForApexElement_Util.getInfoForRebuildTest(triggerOldMap, triggerNew, 'ApexElements__c');


        // set<Id> changedElements = new set<Id>();
        // set<Id> projectIdSet = new set<Id>();
        // for(ApexElements__c i : triggerNew){
        //     boolean updateNames = triggerOldMap == null || (triggerOldMap != null && i.Name != triggerOldMap.get(i.Id).Name);
        //     if(updateNames){
        //         i.ApexElement__c = i.Name;
        //         if(i.Id != null){
        //             changedElements.add(i.Id);
        //             projectIdSet.add(i.Project__c);
        //         }
        //     }            
        // }
        // if(!changedElements.isEmpty()){
        //     list<TestForApexElement__c> usedElements = [SELECT Id, ApexElement__c FROM TestForApexElement__c WHERE ApexElement__c IN: changedElements AND Project__c IN: projectIdSet];
        //     TestForApexElement_Util.buildRuntTestOnModify(usedElements);
        // }
        
    }

    public static void afterMethods(map<Id, ApexElements__c> triggerOldMap, list<ApexElements__c> triggerNew){
        TestForApexElement_Util.rebuildTestOnChange();
    }
}