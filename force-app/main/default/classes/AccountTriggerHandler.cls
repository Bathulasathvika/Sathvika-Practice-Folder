public with sharing class AccountTriggerHandler {
public static void run() {
    if (Trigger.isBefore) {
        if (Trigger.isInsert) {
            beforeInsert(Trigger.new);
        }
        if (Trigger.isUpdate) {
            beforeUpdate(Trigger.new, Trigger.oldMap);
        }
        if (Trigger.isDelete) {
            beforeDelete(Trigger.old);
        }
}
if (Trigger.isAfter) {
    if (Trigger.isInsert) {
        afterInsert(Trigger.new);
    }
    if (Trigger.isUpdate) {
        afterUpdate(Trigger.new, Trigger.oldMap);
    }
}
}
private static void beforeInsert(List<Account> accounts) {
    for (Account acc : accounts) {
        if (String.isBlank(acc.Name)) {
            acc.addError('Account Name is required.');
}
}
}
private static void beforeUpdate(
    List<Account> newAccounts,
    Map<Id, Account> oldAccountMap) {
        for (Account acc : newAccounts) {
            Account oldAcc = oldAccountMap.get(acc.Id);
            if (acc.Name != oldAcc.Name) {
                System.debug('Account name changed: ' + acc.Id);
            }
        }
    }
    private static void beforeDelete(List<Account> accounts) {
        Set<Id> accountIds = new Set<Id>();
        for (Account acc : accounts) {
            accountIds.add(acc.Id);
        }
        List<Contact> contacts = [
            SELECT Id, AccountId
            FROM Contact
            WHERE AccountId IN :accountIds
            ];
            Set<Id> accountsWithContacts = new Set<Id>();
            for (Contact con : contacts) {
                accountsWithContacts.add(con.AccountId);
            }
            for (Account acc : accounts) {
                if (accountsWithContacts.contains(acc.Id)) {
                    acc.addError(
                        'Account cannot be deleted because it has Contacts.'
                        );
                    }
                }
            }
private static void afterInsert(List<Account> accounts) {
// Post-insert business logic
}
private static void afterUpdate(
    List<Account> newAccounts,
    Map<Id, Account> oldAccountMap) {
// Post-update business logic
}
}