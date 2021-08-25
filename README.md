# TaskManagerProject

Task manager is a tool developed for Salesforce which eases project development management.
Users can create records for each task they are performing and inside those tasks, records for the metadatas they are modifying/creating.
For instance: If an user modifies apex class: AccountUtility for task "Task - Account management":
    That user (Salesforce developer) would create a Task__c record named Task - Account management and inside of it, create an TaskItem__c named AccountUtility with the TaskItemType "ApexClass"
    By doing so, system will create automatically the Package.xml needed to retrieve and deploy

TaskManager also provides support for test classes: user can create a record of ApexElement__c and TestClass__c. In the example above, it would be for instance:
    a record for ApexElement__c --> AccountUtility
    a record for TestClass__c   --> AccountUtiityTest

By relating both records with junction object "TestClassForApexElement__c" System will search all records of TaskItem__c which name is the same of the ApexElement__c and note down in a field in Task__c the
list of methods that would be needed to run in the target production organization to deploy the elements listed in TaskItem__c