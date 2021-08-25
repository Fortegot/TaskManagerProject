/**
 * Author: Francisco Javier Ortegón Tesías  - francisco.ortegon1990@gmail.com
 * Date: 23/08/2021
 * Description: 
 *      Builds package.xml file for task and deployment objects according to taskItem and taskItemTypes associated to tasks
 *      Builds list of tests that should be executed in order to deploy a task or a deployment object
 * 
 *      *Actions are only performed over tasks or deployments which status is not Completed/Utility for tasks or Deployed for deployments
 * 
 * Test class - PackageBuilderTest 
 */

public class PackageBuilder {

    public static void getInfoForBuildPackage(map<Id, TaskItem__c> itemMap) {

        map<Id, TaskItem__c> itemMapInfo = new map<Id, TaskItem__c>([SELECT Id, TaskItem__c, Task__c, Task__r.Project__c, Task__r.Name, Task__r.Deployment__c, TaskItemType__r.Name FROM TaskItem__c WHERE Id IN: itemMap.keySet() ORDER BY TaskItemType__r.Name ASC]);

        map<Id, list<TaskItem__c>> parentIdAndTaskItem = new map<Id, list<TaskItem__c>>();
        set<Id> deploymentSet = new set<Id>();
        set<Id> projectSet = new set<Id>();
        set<String> apexTaskItems = new set<String>();
        for(TaskItem__c i : itemMapInfo.values()){
            if(!parentIdAndTaskItem.containsKey(i.Task__c)){
                parentIdAndTaskItem.put(i.Task__c, new list<TaskItem__c>());
            }
            parentIdAndTaskItem.get(i.Task__c).add(i);

            if(i.Task__r.Deployment__c != null){
                deploymentSet.add(i.Task__r.Deployment__c);
            }
            if(i.TaskItemType__r.Name=='ApexTrigger' || i.TaskItemType__r.Name=='ApexClass'){
                apexTaskItems.add(i.TaskItem__c);
            }
            projectSet.add(i.Task__r.Project__c);
        }
        
        if(!deploymentSet.isEmpty()){
            map<Id, TaskItem__c> itemsByDeployment = new map<Id, TaskItem__c>([SELECT Id, TaskItem__c,  Task__r.Project__c, Task__c, Task__r.Name, Task__r.Deployment__c, TaskItemType__r.Name FROM TaskItem__c WHERE Task__r.Deployment__c IN: deploymentSet ORDER BY TaskItemType__r.Name ASC]);
            for(TaskItem__c i : itemsByDeployment.values()){
    
                if(!parentIdAndTaskItem.containsKey(i.Task__r.Deployment__c)){
                    parentIdAndTaskItem.put(i.Task__r.Deployment__c, new list<TaskItem__c>());
                }
                parentIdAndTaskItem.get(i.Task__r.Deployment__c).add(i);

                if(i.TaskItemType__r.Name=='ApexTrigger' || i.TaskItemType__r.Name=='ApexClass'){
                    apexTaskItems.add(i.TaskItem__c);
                }
            }
        }

        map<Id, map<String, set<String>>> projectAndApexElementAndTests = new map<Id, map<String, set<String>>>();
        System.debug('PackageBuilder - getInfoForBuildPackage - apexTaskItems - '+apexTaskItems);
        if(!apexTaskItems.isEmpty()){
            list<TestForApexElement__c> definedTests = [SELECT Project__c, ApexElement__r.Name, TestClass__r.Name FROM TestForApexElement__c WHERE ApexElement__r.Name IN: apexTaskItems AND Project__c IN: projectSet];
            System.debug('PackageBuilder - getInfoForBuildPackage - definedTests - '+definedTests);
            
            for(TestForApexElement__c i : definedTests){
                if(!projectAndApexElementAndTests.containsKey(i.Project__c)){
                    projectAndApexElementAndTests.put(i.Project__c, new map<String, set<String>>());
                }
                if(!projectAndApexElementAndTests.get(i.Project__c).containsKey(i.ApexElement__r.Name)){
                    projectAndApexElementAndTests.get(i.Project__c).put(i.ApexElement__r.Name, new set<String>());
                }
                projectAndApexElementAndTests.get(i.Project__c).get(i.ApexElement__r.Name).add(i.TestClass__r.Name);

            }
            System.debug('PackageBuilder - getInfoForBuildPackage - projectAndApexElementAndTests - '+projectAndApexElementAndTests);

        }
        set<Id> taskToCheck = new set<Id>();
        set<Id> deploymentToCheck = new set<Id>();
        
        list<Task__c> taskToUpdate = new list<Task__c>();
        list<Deployment__c> deploymentToUpdate = new list<Deployment__c>();
        for(Id i : parentIdAndTaskItem.keySet()){
            TaskItem__c firstTI = parentIdAndTaskItem.get(i)[0];
            String objectType = String.valueOf(i.getSobjectType());
            if(objectType=='Task__c'){
                String thisPackage = buildPackage(parentIdAndTaskItem.get(i), false);
                Task__c t = new Task__c(Id = i, Package__c = thisPackage);
                
                t = (Task__c)buildTestBundle(parentIdAndTaskItem.get(i),projectAndApexElementAndTests.containsKey(firstTI.Task__r.Project__c) ? projectAndApexElementAndTests.get(firstTI.Task__r.Project__c) : new map<String, set<String>>(), t);
                taskToCheck.add(t.Id);
                taskToUpdate.add(t);

            }
            if(objectType=='Deployment__c'){
                String thisPackage = buildPackage(parentIdAndTaskItem.get(i), true);
                Deployment__c d = new Deployment__c(Id = i, Package__c = thisPackage);

                if(projectAndApexElementAndTests.containsKey(firstTI.Task__r.Project__c)){
                    d = (Deployment__c)buildTestBundle(parentIdAndTaskItem.get(i), projectAndApexElementAndTests.containsKey(firstTI.Task__r.Project__c) ? projectAndApexElementAndTests.get(firstTI.Task__r.Project__c) : new map<String, set<String>>(), d);
                }
                deploymentToCheck.add(d.Id);
                deploymentToUpdate.add(d);
            }
        }

        

        if(!taskToUpdate.isEmpty()){
            map<Id, Task__c> openedTask = new map<Id, Task__c>([SELECT Id, Status__c FROM Task__c WHERE Id IN: taskToCheck AND Status__c NOT IN: new set<String>{'Completed', 'Utility'}]);
            list<Task__c> taskToUpdateFinally = new list<Task__c>();
            for(Task__c i : taskToUpdate){
                if(openedTask.containsKey(i.Id)){
                    taskToUpdateFinally.add(i);
                }
            }
            update taskToUpdateFinally;
        }
        if(!deploymentToUpdate.isEmpty()){
            map<Id, Deployment__c> openedDeployment = new map<Id, Deployment__c>([SELECT Id, Status__c FROM Deployment__c WHERE Id IN: deploymentToCheck AND Status__c NOT IN: new set<String>{'Deployed'}]);
            list<Deployment__c> deploymentToUpdateFinally = new list<Deployment__c>();
            for(Deployment__c i : deploymentToUpdate){
                if(openedDeployment.containsKey(i.Id)){
                    deploymentToUpdateFinally.add(i);
                }
            }
            update deploymentToUpdateFinally;
        }

        
    }

    public static SObject buildTestBundle(list<TaskItem__c> itemInfo, map<String, set<String>> apexElementAndTests, SObject objectToUpdate){
        System.debug('itemInfo - '+itemInfo);
        map<String, set<String>> apexElementsWithoutTest = new map<String, set<String>>();
        set<String> testsForThisObject = new set<String>();
        for(TaskItem__c i : itemInfo){
            if(i.TaskItemType__r.Name == 'ApexClass' || i.TaskItemType__r.Name == 'ApexTrigger'){
                if(apexElementAndTests.containsKey(i.TaskItem__c)){
                    testsForThisObject.addAll(apexElementAndTests.get(i.TaskItem__c));
                }else{
                    if(!apexElementsWithoutTest.containsKey(i.TaskItem__c)){
                        apexElementsWithoutTest.put(i.TaskItem__c, new set<String>());
                    }
                    apexElementsWithoutTest.get(i.TaskItem__c).add('---->'+i.Task__r.Name);
                }
            }
        }
        list<String> allTests = new list<String>();
        for(String i : testsForThisObject){
            allTests.add('<runTest>'+i+'</runTest>');
        }
        list<String> elementsWitoutTest = new list<String>();
        
        list<String> elementsWitoutTestList= new list<String>();
        for(String i : apexElementsWithoutTest.keySet()){
            list<String> tasksOfThisElement = new list<String>(apexElementsWithoutTest.get(i));
            String tasks = String.join(tasksOfThisElement, '\n');
            String element = i+'\n'+tasks;
            elementsWitoutTestList.add(element);
        }
        String elementsWitoutTestString = String.join(elementsWitoutTestList, '\n');
        String allTestsString = String.join(allTests, '\n');
        objectToUpdate.put('RunTest__c', allTestsString);
        objectToUpdate.put('NoTestWarning__c', elementsWitoutTestString);

        return objectToUpdate;
    }


    public static string buildPackage(list<TaskItem__c> itemInfo, boolean setFromTask){
        map<String, set<String>> typeAndTaskItem = new map<string, set<String>>();
        map<String, set<String>> taskItemAndTask = new map<String, set<String>>();
        for(TaskItem__c i : itemInfo){
            if(!typeAndTaskItem.containsKey(i.TaskItemType__r.Name)){
                typeAndTaskItem.put(i.TaskItemType__r.Name, new set<String>());
            }
            typeAndTaskItem.get(i.TaskItemType__r.Name).add(i.TaskItem__c);

            if(!taskItemAndTask.containsKey(i.TaskItem__c)){
                taskItemAndTask.put(i.TaskItem__c, new set<String>());
            }
            taskItemAndTask.get(i.TaskItem__c).add(i.Task__r.Name);
        }
        
        list<String> typesList = new list<String>();
        for(String i : typeAndTaskItem.keySet()){
            String newType = '      <name>'+i+'</name>';
            list<String> itemList = new list<String>();
            for(String item : typeAndTaskItem.get(i)){
                String newItem = '      <members>'+item+'</members>';
                if(taskItemAndTask.containsKey(item) && setFromTask){
                    newItem+='      <!--'+String.join(new list<String>(taskItemAndTask.get(item)),'; ')+'-->';
                }
                itemList.add(newItem);
            }
            String type = 
            '   <types>\n'+
            String.join(itemList, '\n')+'\n'+
            newType+'\n'+
            '   </types>';
            typesList.add(type);
        }
        String packageString =
        '<?xml version="1.0" encoding="UTF-8"?>\n'+
        '<Package xmlns="http://soap.sforce.com/2006/04/metadata">\n'+
        String.join(typesList, '\n')+'\n'+
        '<version>47.0</version>\n'+
        '</Package>';

        System.debug(packageString);
        return packageString;
    }
}