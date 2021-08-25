public class TestForApexElement_Util {

    private static list<TestForApexElement__c> usedElements;

    
    public static void buildRuntTestOnModify(list<TestForApexElement__c> TriggerNew) {

        set<Id> apexElements = new set<Id>();
        for(TestForApexElement__c i : TriggerNew){
            apexElements.add(i.ApexElement__c);
        }

        list<ApexElements__c> aeList = [SELECT Id, Name, Project__c FROM ApexElements__c WHERE Id IN: apexElements];
        System.debug('TestForApexElement_Util - buildRuntTestOnModify - aeList - '+aeList);

        set<String> apexElementNameSet = new set<String>();
        for(ApexElements__c i : aeList){
            apexElementNameSet.add(i.Name);
        }
        map<Id, TaskItem__c> tiMap= new map<Id, TaskItem__c>([SELECT Id, Task__c, Task__r.Deployment__c FROM TaskItem__c WHERE TaskItem__c IN: apexElementNameSet AND Task__r.Status__c != 'Completed']);
        System.debug('TestForApexElement_Util - buildRuntTestOnModify - tiMap - 1 - '+tiMap);

        set<Id> theTasks = new set<Id>();
        for(TaskItem__c i : tiMap.values()){
            theTasks.add(i.Task__c);
            theTasks.add(i.Task__r.Deployment__c);
        }
        tiMap= new map<Id, TaskItem__c>([SELECT Id, Task__c FROM TaskItem__c WHERE Task__c IN: theTasks OR Task__r.Deployment__c IN: theTasks]);
        System.debug('TestForApexElement_Util - buildRuntTestOnModify - tiMap - 2 - '+tiMap);

        PackageBuilder.getInfoForBuildPackage(tiMap);

    }

    public static void beforeMethod(list<TestForApexElement__c> TriggerNew){
        set<Id> apexElements = new set<Id>();
        for(TestForApexElement__c i : TriggerNew){
            apexElements.add(i.ApexElement__c);
        }

        map<Id, ApexElements__c> aeMap = new map<Id, ApexElements__c>([SELECT Id, Name, Project__c FROM ApexElements__c WHERE Id IN: apexElements]);
        for(TestForApexElement__c i : TriggerNew){
            i.Project__c = aeMap.get(i.ApexElement__c).Project__c;
        }

    }

    public static void getInfoForRebuildTest(map<Id, SObject> triggerOldMap, list<SObject> triggerNew, String objectType){

        usedElements = new list<TestForApexElement__c>();

        map<String, map<String, String>> nameMap = new map<String, map<String,String>>{
            'TestClass__c'   => new map<String, String>{
                'Name' => 'TestClass__c',
                'Lookup' => 'TestClass__c'
            },
            'ApexElements__c' => new map<String, String>{
                'Name' => 'ApexElement__c',
                'Lookup' =>'ApexElement__c' 
            }
        };
        String nameField = nameMap.containsKey(objectType) ? nameMap.get(objectType).get('Name') : null;
        String lookupField = nameMap.containsKey(objectType) ? nameMap.get(objectType).get('Lookup') : null;

        set<String> changedElements = new set<String>();
        set<String> projectIdSet = new set<String>();
        for(SObject i : triggerNew){
            Id iId = (Id)i.get('Id');
            boolean updateNames = triggerOldMap == null || (triggerOldMap != null && (String)i.get('Name') != (String)triggerOldMap.get(iId).get('Name'));
            if(updateNames){
                if(nameField != null){
                    i.put(nameField, (String)i.get('Name')+'@'+(Id)i.get('Project__c'));
                }
                if(iId != null){
                    changedElements.add(iId);
                    projectIdSet.add((Id)i.get('Project__c'));
                }
            }            
        }

        System.debug('Util - rebuildTestOnChange - changedElements - '+changedElements);
        System.debug('Util - rebuildTestOnChange - lookupField - '+lookupField);

        if(!changedElements.isEmpty() && lookupField != null){
            String queryToGetModifiedData = 'SELECT Id, ApexElement__c FROM TestForApexElement__c WHERE Project__c IN ('+Util.convertSetToIn(projectIdSet)+') AND '+lookupField+' IN ('+Util.convertSetToIn(changedElements)+')';
            usedElements = Database.Query(queryToGetModifiedData);
            System.debug('Util - rebuildTestOnChange - usedElements - '+usedElements);
        }
    }

    public static void rebuildTestOnChange(){
        if(usedElements != null && !usedElements.isEmpty()){
            System.debug('Util - rebuildTestOnChange - usedElements - '+usedElements);
            TestForApexElement_Util.buildRuntTestOnModify(usedElements);
        }
    }
}