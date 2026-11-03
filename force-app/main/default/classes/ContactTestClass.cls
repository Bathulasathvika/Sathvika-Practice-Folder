@isTest
public class ContactTestClass {

    @isTest
    static void testSalesContact() {

        // Arrange
        Contact con = new Contact(
            FirstName = 'Ravi',
            LastName = 'Kumar',
            Email = 'ravi@test.com',
            Department = 'Sales'
        );

        // Act
        insert con;

        // Query the record after trigger execution
        Contact result = [
            SELECT Id, FirstName, LastName, Email, Department, LeadSource
            FROM Contact
            WHERE Id = :con.Id
        ];

        // Assert
        System.assertEquals('Web', result.LeadSource);
    }
}