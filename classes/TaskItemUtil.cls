public class TaskItemUtil {
    public static void rebuildPackage(map<Id, TaskItem__c> triggerNewMap) {
        set<Id> parents = new set<Id>();
        for(TaskItem__c i : triggerNewMap.values()){
            parents.add(i.Task__c);
        }
        map<Id, TaskItem__c> taskItemMap = new map<Id, TaskItem__c>([SELECT Id FROM TaskItem__c WHERE Task__c IN: parents]);

        PackageBuilder.getInfoForBuildPackage(taskItemMap);
    }
}