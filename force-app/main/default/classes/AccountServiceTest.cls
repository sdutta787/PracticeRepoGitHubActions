@isTest
private class AccountServiceTest {

    @isTest
    static void testCreateAccount() {
        Test.startTest();
        Account acc = AccountService.createAccount('Test Corp', 'Technology');
        Test.stopTest();

        System.assertNotEquals(null, acc.Id, 'Account should be inserted');
        System.assertEquals('Test Corp', acc.Name);
        System.assertEquals('Technology', acc.Industry);
    }
}
