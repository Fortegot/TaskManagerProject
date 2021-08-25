public with sharing class TaskUtility {

    public static void beforeMethods(list<Task__c> triggerNew, map<Id, Task__c> triggerOldMap){
        for(Task__c i : triggerNew){
            boolean updateNames = triggerOldMap == null || (triggerOldMap != null && i.Name != triggerOldMap.get(i.Id).Name);
            if(updateNames){
                i.TaskName__c = i.Name;
            }            
        }
    }



    public static void buldPackageOnTaskChange(list<Task__c> triggerNew, map<Id, Task__c> triggerNewMap) {

        set<Id> taskToRebuildPackage = new set<Id>();
        map<Id, Id> taskToRelateManualTask = new map<Id, Id>();

        for(Task__c i : triggerNew){
            if(triggerNewMap == null){
                if(i.Deployment__c != null){
                    taskToRebuildPackage.add(i.Deployment__c);
                }
            }else{
                if(triggerNewMap.get(i.Id).Deployment__c != i.Deployment__c){

                    if(i.Deployment__c != null){
                        taskToRebuildPackage.add(i.Deployment__c);
                    }else{
                        taskToRebuildPackage.add(triggerNewMap.get(i.Id).Deployment__c);
                    }
                    taskToRelateManualTask.put(i.Id, i.Deployment__c);
                }
            }            
        }
        System.debug('Task and deployment' + taskToRelateManualTask);

        if(!taskToRebuildPackage.isEmpty()){
            map<Id, TaskItem__c> taskItemMap = new map<Id, TaskItem__c>([SELECT Id FROM TaskItem__c WHERE Task__r.Deployment__c IN: taskToRebuildPackage]);
            PackageBuilder.getInfoForBuildPackage(taskItemMap);

        }

        if(!taskToRelateManualTask.isEmpty()){
            relateManualTasks(taskToRelateManualTask);
        }

    }

    private static void relateManualTasks(map<Id, Id> taskIdAndDeploymentId){
        list<ManualTask__c> relatedManualTasks = [SELECT Id, Task__c, Deployment__c FROM ManualTask__c WHERE Task__c IN: taskIdAndDeploymentId.keySet()];
        System.debug('relatedManualTasks' + relatedManualTasks);

        for(ManualTask__c i : relatedManualTasks){
            if(taskIdAndDeploymentId.containsKey(i.Task__c)){
                i.Deployment__c = taskIdAndDeploymentId.get(i.Task__c);
            }
        }
        System.debug('relatedManualTasks' + relatedManualTasks);

        if(!relatedManualTasks.isEmpty()){
            update relatedManualTasks;
        }
    }
}