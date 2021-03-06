<?xml version="1.0" encoding="UTF-8"?>
<Profile xmlns="http://soap.sforce.com/2006/04/metadata">
    <applicationVisibilities>
        <application>Task_Manager</application>
        <default>false</default>
        <visible>true</visible>
    </applicationVisibilities>
    <classAccesses>
        <apexClass>ApexElements_Util</apexClass>
        <enabled>false</enabled>
    </classAccesses>
    <classAccesses>
        <apexClass>ManualTask_Util</apexClass>
        <enabled>false</enabled>
    </classAccesses>
    <classAccesses>
        <apexClass>PackageBuilder</apexClass>
        <enabled>false</enabled>
    </classAccesses>
    <classAccesses>
        <apexClass>PackageBuilder_Test</apexClass>
        <enabled>false</enabled>
    </classAccesses>
    <classAccesses>
        <apexClass>TaskItemTypeUtility</apexClass>
        <enabled>false</enabled>
    </classAccesses>
    <classAccesses>
        <apexClass>TaskItemUtil</apexClass>
        <enabled>false</enabled>
    </classAccesses>
    <classAccesses>
        <apexClass>TaskUtility</apexClass>
        <enabled>false</enabled>
    </classAccesses>
    <classAccesses>
        <apexClass>TestClass_Util</apexClass>
        <enabled>false</enabled>
    </classAccesses>
    <classAccesses>
        <apexClass>TestForApexElement_Util</apexClass>
        <enabled>false</enabled>
    </classAccesses>
    <classAccesses>
        <apexClass>TestUtility</apexClass>
        <enabled>false</enabled>
    </classAccesses>
    <classAccesses>
        <apexClass>Util</apexClass>
        <enabled>false</enabled>
    </classAccesses>
    <custom>true</custom>
    <fieldPermissions>
        <editable>true</editable>
        <field>ApexElements__c.ApexElement__c</field>
        <readable>true</readable>
    </fieldPermissions>
    <fieldPermissions>
        <editable>true</editable>
        <field>Deployment__c.NoTestWarning__c</field>
        <readable>true</readable>
    </fieldPermissions>
    <fieldPermissions>
        <editable>true</editable>
        <field>Deployment__c.Package__c</field>
        <readable>true</readable>
    </fieldPermissions>
    <fieldPermissions>
        <editable>true</editable>
        <field>Deployment__c.RunTest__c</field>
        <readable>true</readable>
    </fieldPermissions>
    <fieldPermissions>
        <editable>true</editable>
        <field>Deployment__c.Verification__c</field>
        <readable>true</readable>
    </fieldPermissions>
    <fieldPermissions>
        <editable>true</editable>
        <field>ManualTask__c.Deployment__c</field>
        <readable>true</readable>
    </fieldPermissions>
    <fieldPermissions>
        <editable>true</editable>
        <field>ManualTask__c.Description__c</field>
        <readable>true</readable>
    </fieldPermissions>
    <fieldPermissions>
        <editable>true</editable>
        <field>ManualTask__c.IsDone__c</field>
        <readable>true</readable>
    </fieldPermissions>
    <fieldPermissions>
        <editable>true</editable>
        <field>Project__c.Information__c</field>
        <readable>true</readable>
    </fieldPermissions>
    <fieldPermissions>
        <editable>true</editable>
        <field>TaskItemType__c.TaskItemType__c</field>
        <readable>true</readable>
    </fieldPermissions>
    <fieldPermissions>
        <editable>true</editable>
        <field>Task__c.Deployment__c</field>
        <readable>true</readable>
    </fieldPermissions>
    <fieldPermissions>
        <editable>true</editable>
        <field>Task__c.Description__c</field>
        <readable>true</readable>
    </fieldPermissions>
    <fieldPermissions>
        <editable>true</editable>
        <field>Task__c.NoTestWarning__c</field>
        <readable>true</readable>
    </fieldPermissions>
    <fieldPermissions>
        <editable>true</editable>
        <field>Task__c.Package__c</field>
        <readable>true</readable>
    </fieldPermissions>
    <fieldPermissions>
        <editable>false</editable>
        <field>Task__c.PriorizeDate__c</field>
        <readable>true</readable>
    </fieldPermissions>
    <fieldPermissions>
        <editable>true</editable>
        <field>Task__c.Project__c</field>
        <readable>true</readable>
    </fieldPermissions>
    <fieldPermissions>
        <editable>true</editable>
        <field>Task__c.RunTest__c</field>
        <readable>true</readable>
    </fieldPermissions>
    <fieldPermissions>
        <editable>true</editable>
        <field>Task__c.TaskName__c</field>
        <readable>true</readable>
    </fieldPermissions>
    <fieldPermissions>
        <editable>true</editable>
        <field>Task__c.URL__c</field>
        <readable>true</readable>
    </fieldPermissions>
    <fieldPermissions>
        <editable>true</editable>
        <field>TestClass__c.TestClass__c</field>
        <readable>true</readable>
    </fieldPermissions>
    <fieldPermissions>
        <editable>true</editable>
        <field>TestForApexElement__c.Project__c</field>
        <readable>true</readable>
    </fieldPermissions>
    <layoutAssignments>
        <layout>Deployment__c-Deployment Layout</layout>
    </layoutAssignments>
    <layoutAssignments>
        <layout>Project__c-Proyect Layout</layout>
    </layoutAssignments>
    <layoutAssignments>
        <layout>TaskItemType__c-Task Item Type Layout</layout>
    </layoutAssignments>
    <layoutAssignments>
        <layout>TaskItem__c-Task Item Layout</layout>
    </layoutAssignments>
    <layoutAssignments>
        <layout>Task__c-Task Layout</layout>
    </layoutAssignments>
    <layoutAssignments>
        <layout>TestClass__c-Test Class Layout</layout>
    </layoutAssignments>
    <layoutAssignments>
        <layout>TestForApexElement__c-Test For Apex Element Layout</layout>
    </layoutAssignments>
    <objectPermissions>
        <allowCreate>false</allowCreate>
        <allowDelete>false</allowDelete>
        <allowEdit>false</allowEdit>
        <allowRead>true</allowRead>
        <modifyAllRecords>false</modifyAllRecords>
        <object>ApexElements__c</object>
        <viewAllRecords>false</viewAllRecords>
    </objectPermissions>
    <objectPermissions>
        <allowCreate>true</allowCreate>
        <allowDelete>false</allowDelete>
        <allowEdit>true</allowEdit>
        <allowRead>true</allowRead>
        <modifyAllRecords>false</modifyAllRecords>
        <object>Deployment__c</object>
        <viewAllRecords>false</viewAllRecords>
    </objectPermissions>
    <objectPermissions>
        <allowCreate>true</allowCreate>
        <allowDelete>true</allowDelete>
        <allowEdit>true</allowEdit>
        <allowRead>true</allowRead>
        <modifyAllRecords>false</modifyAllRecords>
        <object>ManualTask__c</object>
        <viewAllRecords>false</viewAllRecords>
    </objectPermissions>
    <objectPermissions>
        <allowCreate>true</allowCreate>
        <allowDelete>false</allowDelete>
        <allowEdit>true</allowEdit>
        <allowRead>true</allowRead>
        <modifyAllRecords>false</modifyAllRecords>
        <object>Project__c</object>
        <viewAllRecords>false</viewAllRecords>
    </objectPermissions>
    <objectPermissions>
        <allowCreate>true</allowCreate>
        <allowDelete>true</allowDelete>
        <allowEdit>true</allowEdit>
        <allowRead>true</allowRead>
        <modifyAllRecords>false</modifyAllRecords>
        <object>TaskItemType__c</object>
        <viewAllRecords>false</viewAllRecords>
    </objectPermissions>
    <objectPermissions>
        <allowCreate>true</allowCreate>
        <allowDelete>true</allowDelete>
        <allowEdit>true</allowEdit>
        <allowRead>true</allowRead>
        <modifyAllRecords>false</modifyAllRecords>
        <object>TaskItem__c</object>
        <viewAllRecords>false</viewAllRecords>
    </objectPermissions>
    <objectPermissions>
        <allowCreate>true</allowCreate>
        <allowDelete>true</allowDelete>
        <allowEdit>true</allowEdit>
        <allowRead>true</allowRead>
        <modifyAllRecords>false</modifyAllRecords>
        <object>Task__c</object>
        <viewAllRecords>false</viewAllRecords>
    </objectPermissions>
    <objectPermissions>
        <allowCreate>false</allowCreate>
        <allowDelete>false</allowDelete>
        <allowEdit>false</allowEdit>
        <allowRead>true</allowRead>
        <modifyAllRecords>false</modifyAllRecords>
        <object>TestClass__c</object>
        <viewAllRecords>false</viewAllRecords>
    </objectPermissions>
    <objectPermissions>
        <allowCreate>true</allowCreate>
        <allowDelete>true</allowDelete>
        <allowEdit>true</allowEdit>
        <allowRead>true</allowRead>
        <modifyAllRecords>false</modifyAllRecords>
        <object>TestForApexElement__c</object>
        <viewAllRecords>false</viewAllRecords>
    </objectPermissions>
    <tabVisibilities>
        <tab>ApexElements__c</tab>
        <visibility>Hidden</visibility>
    </tabVisibilities>
    <tabVisibilities>
        <tab>Deployment__c</tab>
        <visibility>DefaultOn</visibility>
    </tabVisibilities>
    <tabVisibilities>
        <tab>Project__c</tab>
        <visibility>DefaultOn</visibility>
    </tabVisibilities>
    <tabVisibilities>
        <tab>TaskItemType__c</tab>
        <visibility>DefaultOn</visibility>
    </tabVisibilities>
    <tabVisibilities>
        <tab>TaskItem__c</tab>
        <visibility>DefaultOn</visibility>
    </tabVisibilities>
    <tabVisibilities>
        <tab>Task__c</tab>
        <visibility>DefaultOn</visibility>
    </tabVisibilities>
    <tabVisibilities>
        <tab>TestClass__c</tab>
        <visibility>Hidden</visibility>
    </tabVisibilities>
    <tabVisibilities>
        <tab>TestForApexElement__c</tab>
        <visibility>DefaultOn</visibility>
    </tabVisibilities>
    <userLicense>Salesforce</userLicense>
    <userPermissions>
        <enabled>true</enabled>
        <name>ActivitiesAccess</name>
    </userPermissions>
    <userPermissions>
        <enabled>true</enabled>
        <name>AllowViewKnowledge</name>
    </userPermissions>
    <userPermissions>
        <enabled>true</enabled>
        <name>ChatterInternalUser</name>
    </userPermissions>
    <userPermissions>
        <enabled>true</enabled>
        <name>LightningConsoleAllowedForUser</name>
    </userPermissions>
    <userPermissions>
        <enabled>true</enabled>
        <name>LightningExperienceUser</name>
    </userPermissions>
    <userPermissions>
        <enabled>true</enabled>
        <name>ViewHelpLink</name>
    </userPermissions>
</Profile>
