public class TaskItemTypeUtility {

    private static map<Id, TaskItem__c> taskItemMap;
    public static void beforeMethods(map<Id, TaskItemType__c> triggerOldMap, list<TaskItemType__c> triggerNew) {

        taskItemMap = new map<Id, TaskItem__c>();

        set<Id> changedTaskItemTypes = new set<Id>();

        for(TaskItemType__c i : triggerNew){
            boolean updateNames = triggerOldMap == null || (triggerOldMap != null && i.Name != triggerOldMap.get(i.Id).Name);
            if(updateNames){
                i.TaskItemType__c = i.Name;
                if(i.Id != null){
                    changedTaskItemTypes.add(i.Id);
                }
            }            
        }
        System.debug('TaskItemTypeUtility - beforeMethods - changedTaskItemTypes - '+changedTaskItemTypes);

        if(!changedTaskItemTypes.isEmpty()){
            taskItemMap = new map<Id, TaskItem__c>([SELECT Id FROM TaskItem__c WHERE TaskItemType__c IN: changedTaskItemTypes AND Task__r.Status__c NOT IN: new set<String>{'Completed', 'Utility'}]);
            System.debug('TaskItemTypeUtility - beforeMethods - taskItemMap - '+taskItemMap);
        }
       
    }

    public static void afterMethods(map<Id, TaskItemType__c> triggerOldMap, list<TaskItemType__c> triggerNew){

        if(taskItemMap != null && !taskItemMap.isEmpty()){
            System.debug('TaskItemTypeUtility - beforeMethods - taskItemMap - '+taskItemMap);

            PackageBuilder.getInfoForBuildPackage(taskItemMap);
        }
    }
}