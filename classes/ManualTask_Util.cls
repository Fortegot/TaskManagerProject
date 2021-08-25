public class ManualTask_Util {
    public static void beforeMethods(list<ManualTask__c> triggerNew) {

        set<Id> taskId = new set<Id>();
        for(ManualTask__c i : triggerNew){
            taskId.add(i.Task__c);
        }

        map<Id, Task__c> taskMap =new map<Id, Task__c>([SELECT Id, Deployment__c FROM Task__c WHERE Id IN: taskId]);
        for(ManualTask__c i : triggerNew){
            if(taskMap.containsKey(i.Task__c)){
                i.Deployment__c = taskMap.get(i.Task__c).Deployment__c;
            }
        }
    }
}