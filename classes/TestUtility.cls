public class TestUtility {
    public static Project__c createProject(String projectName) {
        return new Project__c(
            Name = projectName
        );
    }

    public static Task__c createTask(String taskName, Id projectId){
        return new Task__c(
            Name = taskName,
            Project__c = projectId
        );
    }

    public static TaskItemType__c createTaskItemType(String taskItemName){
        return new TaskItemType__c(
            Name = taskItemName
        );
    }

    public static Deployment__c createDeployment(String deploymentName){
        return new Deployment__c(
            Name = deploymentName
        );
    }

    public static ApexElements__c createApexElement(String apexElement, Id projectId){
        return new ApexElements__c(
            Name = apexElement,
            Project__c = projectId
        );
    }

    public static TestClass__c createTestClass(String testClass, Id projectId){
        return new TestClass__c(
            Name = testClass,
            Project__c = projectId
        );
    }
}