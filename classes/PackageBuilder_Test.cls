@isTest
public with sharing class PackageBuilder_Test {
    
    @TestSetup
    private static void makeData(){
        Project__c p = TestUtility.createProject('TestProject0');
        insert p;

        TaskItemType__c tit = TestUtility.createTaskItemType('ApexClass');
        insert tit;
        
        Task__c t = TestUtility.createTask('TestTask0', p.Id);
        insert t;

    }

    @isTest
    private static void testForManualTask(){
        Task__c theTask = [SELECT Id, project__c FROM Task__c LIMIT 1];
        insert new ManualTask__c(
            Description__c = 'stuff to do',
            Task__c = theTask.Id
        );

        Deployment__c dep = TestUtility.createDeployment('Aweseome Task Manager Deployment');
        insert dep;

        theTask.Deployment__c = dep.Id;
        update theTask;

        ManualTask__c theMT = [SELECT Id, Deployment__c FROM ManualTask__c LIMIT 1];
        System.assertEquals(dep.Id, theMT.Deployment__c);
    }

    @isTest
    private static void testForDeployment(){
        Deployment__c dep = TestUtility.createDeployment('Aweseome Task Manager Deployment');
        insert dep;

        Project__c p = [SELECT Id FROM Project__c LIMIT 1];

        Task__c t0 = TestUtility.createTask('TestTask0a', p.Id);
        t0.Deployment__c = dep.Id;
        insert t0;

        Task__c t1 = TestUtility.createTask('TestTask1', p.Id);
        t1.Deployment__c = dep.Id;
        insert t1;

        TaskItemType__c tit = [SELECT Id, Name FROM TaskItemType__c LIMIT 1];


        list<TaskItem__c> tiList = new list<TaskItem__c>{
            new TaskItem__c(
                TaskItem__c = 'Class0',
                Task__c = t0.Id,
                TaskItemType__c = tit.Id
            ),
            new TaskItem__c(
                TaskItem__c = 'Class1',
                Task__c = t0.Id,
                TaskItemType__c = tit.Id
            ),
            new TaskItem__c(
                TaskItem__c = 'Class2',
                Task__c = t1.Id,
                TaskItemType__c = tit.Id
            ),
            new TaskItem__c(
                TaskItem__c = 'Class3',
                Task__c = t1.Id,
                TaskItemType__c = tit.Id
            )


        };
        insert tiList;
        map<String, String> tiByTaskItem = Util.clasifySecondFieldByFirstField(tiList, 'TaskItem__c', 'Id');


        t0 = [SELECT Id, Package__c,project__c,NoTestWarning__c,RunTest__c FROM Task__c WHERE Name = 'TestTask0a'];
        t1 = [SELECT Id, Package__c,project__c,NoTestWarning__c,RunTest__c FROM Task__c WHERE Name = 'TestTask1'];

        dep = [SELECT Id, Package__c FROM Deployment__c LIMIT 1];

        System.assert(t0.Package__c.contains('Class0'), 'Package is not as expected: '+t0.Package__c);
        System.assert(t0.Package__c.contains('Class1'), 'Package is not as expected: '+t0.Package__c);
        System.assert(!t0.Package__c.contains('Class2'), 'Package is not as expected: '+t0.Package__c);
        System.assert(!t0.Package__c.contains('Class3'), 'Package is not as expected: '+t0.Package__c);

        System.assert(t1.Package__c.contains('Class2'), 'Package is not as expected: '+t1.Package__c);
        System.assert(t1.Package__c.contains('Class3'), 'Package is not as expected: '+t1.Package__c);
        System.assert(!t1.Package__c.contains('Class0'), 'Package is not as expected: '+t1.Package__c);
        System.assert(!t1.Package__c.contains('Class1'), 'Package is not as expected: '+t1.Package__c);

        System.assert(dep.Package__c.contains('Class2'), 'Package is not as expected: '+dep.Package__c);
        System.assert(dep.Package__c.contains('Class3'), 'Package is not as expected: '+dep.Package__c);
        System.assert(dep.Package__c.contains('Class0'), 'Package is not as expected: '+dep.Package__c);
        System.assert(dep.Package__c.contains('Class1'), 'Package is not as expected: '+dep.Package__c);

        t1.Deployment__c = null;
        update t1;

        dep = [SELECT Id, Package__c FROM Deployment__c LIMIT 1];
        System.assert(!dep.Package__c.contains('Class2'), 'Package is not as expected: '+dep.Package__c);
        System.assert(!dep.Package__c.contains('Class3'), 'Package is not as expected: '+dep.Package__c);
        System.assert(dep.Package__c.contains('Class0'), 'Package is not as expected: '+dep.Package__c);
        System.assert(dep.Package__c.contains('Class1'), 'Package is not as expected: '+dep.Package__c);

        delete tiList[3];

        t1 = [SELECT Id, Package__c,project__c,NoTestWarning__c,RunTest__c FROM Task__c WHERE Name = 'TestTask1'];
        System.assert(t1.Package__c.contains('Class2'), 'Package is not as expected: '+t1.Package__c);
        System.assert(!t1.Package__c.contains('Class3'), 'Package is not as expected: '+t1.Package__c);

        delete tiList[0];
        dep = [SELECT Id, Package__c FROM Deployment__c LIMIT 1];
        System.assert(!dep.Package__c.contains('Class2'), 'Package is not as expected: '+dep.Package__c);
        System.assert(!dep.Package__c.contains('Class3'), 'Package is not as expected: '+dep.Package__c);
        System.assert(!dep.Package__c.contains('Class0'), 'Package is not as expected: '+dep.Package__c);
        System.assert(dep.Package__c.contains('Class1'), 'Package is not as expected: '+dep.Package__c);
        System.assert(dep.Package__c.contains('ApexClass'), 'Package is not as expected: '+dep.Package__c);

        tit.Name = 'ApexCLASSS';
        System.debug('Update taskitemType Name');

        update tit;
        dep = [SELECT Id, Package__c FROM Deployment__c LIMIT 1];
        System.assert(!dep.Package__c.contains('ApexClass'), 'Package is not as expected: '+dep.Package__c);
        System.assert(dep.Package__c.contains('ApexCLASSS'), 'Package is not as expected: '+dep.Package__c);




    }

    @isTest
    private static void testForPackage(){


        Task__c theTask = [SELECT Id, project__c FROM Task__c LIMIT 1];
        TaskItemType__c tit = [SELECT Id FROM TaskItemType__c LIMIT 1];

        insert new TaskItem__c(
            TaskItem__c = 'PackageBuilder_Test',
            Task__c = theTask.Id,
            TaskItemType__c = tit.Id
        );
        insert new TaskItem__c(
            TaskItem__c = 'PackageBuilder',
            Task__c = theTask.Id,
            TaskItemType__c = tit.Id
        );


        theTask = [SELECT Id, Package__c,project__c,NoTestWarning__c,RunTest__c FROM Task__c LIMIT 1];

        System.assert(theTask.Package__c.contains('PackageBuilder_Test'), 'Package is not as expected: '+theTask.Package__c);
        System.assert(theTask.Package__c.contains('ApexClass'), 'Package is not as expected: '+theTask.Package__c);
        System.assert(theTask.NoTestWarning__c.contains('PackageBuilder'), 'NoTestWarning__c is not as expected: '+theTask.NoTestWarning__c);
        System.assert(theTask.RunTest__c==null, 'RunTest__c is not as expected: '+theTask.RunTest__c);

        Deployment__c dep = TestUtility.createDeployment('Aweseome Task Manager Deployment');
        insert dep;

        theTask.Deployment__c = dep.Id;
        update theTask;

        ApexElements__c ae = TestUtility.createApexElement('PackageBuilder', theTask.Project__c);
        insert ae;

        TestClass__c tc = TestUtility.createTestClass('PackageBuilder_Test', theTask.Project__c);
        insert tc;

        TestClass__c tc2 = TestUtility.createTestClass('RandomTest', theTask.Project__c);
        insert tc2;

        TestClass__c tc3 = TestUtility.createTestClass('RandomTest2', theTask.Project__c);
        insert tc3;

        TestForApexElement__c tfae0 = new TestForApexElement__c(
            ApexElement__c = ae.Id,
            TestClass__c = tc.Id
        );
        insert tfae0;

        TestForApexElement__c tfae1 = new TestForApexElement__c(
            ApexElement__c = ae.Id,
            TestClass__c = tc2.Id
        );
        insert tfae1;

        TaskItem__c newTI = new TaskItem__c(
            TaskItem__c = 'ApexElements_UTIL',
            Task__c = theTask.Id,
            TaskItemType__c = tit.Id
        );
        insert newTI;

        theTask = [SELECT Id, Package__c,project__c,RunTest__c,NoTestWarning__c FROM Task__c LIMIT 1];
        System.assert(theTask.Package__c.contains('ApexElements_UTIL'), 'Package is not as expected: '+theTask.Package__c);
        System.assert(theTask.RunTest__c.contains('<runTest>PackageBuilder_Test</runTest>'), 'RunTest__c is not as expected: '+theTask.RunTest__c);
        System.assert(theTask.RunTest__c.contains('<runTest>RandomTest</runTest>'), 'RunTest__c is not as expected: '+theTask.RunTest__c);
        System.assert(theTask.NoTestWarning__c.contains('ApexElements_UTIL'), 'NoTestWarning__c is not as expected: '+theTask.NoTestWarning__c);

        newTI.TaskItem__c = 'ApexElements_Util';
        update newTI;
        theTask = [SELECT Id, Package__c,project__c,RunTest__c,NoTestWarning__c FROM Task__c LIMIT 1];
        System.assert(theTask.Package__c.contains('ApexElements_Util'), 'Package is not as expected: '+theTask.Package__c);
        System.assert(!theTask.Package__c.contains('ApexElements_UTIL'), 'Package is not as expected: '+theTask.Package__c);
        System.assert(theTask.NoTestWarning__c.contains('ApexElements_Util'), 'NoTestWarning__c is not as expected: '+theTask.NoTestWarning__c);
        System.assert(!theTask.NoTestWarning__c.contains('ApexElements_UTIL'), 'NoTestWarning__c is not as expected: '+theTask.NoTestWarning__c);

        ApexElements__c ae1 = TestUtility.createApexElement('ApexElements_TILU', theTask.Project__c);
        insert ae1;

        TestForApexElement__c tfae2 = new TestForApexElement__c(
            ApexElement__c = ae1.Id,
            TestClass__c = tc3.Id
        );
        insert tfae2;

        theTask = [SELECT Id, Package__c,project__c,RunTest__c,NoTestWarning__c FROM Task__c LIMIT 1];
        System.assert(!theTask.RunTest__c.contains('<runTest>RandomTest2</runTest>'), 'RunTest__c is not as expected: '+theTask.RunTest__c);

        ae1.Name = 'ApexElements_Util';
        System.debug('Update apex element');

        update ae1;

        theTask = [SELECT Id, Package__c,project__c,RunTest__c,NoTestWarning__c FROM Task__c LIMIT 1];
        System.assert(theTask.RunTest__c.contains('<runTest>RandomTest2</runTest>'), 'RunTest__c is not as expected: '+theTask.RunTest__c);

        tc3.Name = 'RandomTest3';
        System.debug('Update apex test class');

        update tc3;

        theTask = [SELECT Id, Package__c,project__c,RunTest__c,NoTestWarning__c FROM Task__c LIMIT 1];
        System.assert(!theTask.RunTest__c.contains('<runTest>RandomTest2</runTest>'), 'RunTest__c is not as expected: '+theTask.RunTest__c);
        System.assert(theTask.RunTest__c.contains('<runTest>RandomTest3</runTest>'), 'RunTest__c is not as expected: '+theTask.RunTest__c);
    }
}