WGU Task: Provide original SQL code in a text format that creates the detailed and summary tables to hold your report table sections.

I’ll create two new tables:
  CustomerPaymentDetail     contains each individual payment with full customer info
  CustomerPaymentSummary    aggregates total spending by customer

Customer Payment Detail Table:
---------------------------------------------------------------
  CREATE TABLE CustomerPaymentDetail (
    PaymentID       INTEGER PRIMARY KEY,
    CustomerID      INTEGER,
    FirstName       VARCHAR(50),
    LastName        VARCHAR(50),
    Email           VARCHAR(100),
    PaymentDate     TIMESTAMP,
    Amount          DECIMAL(5,2),
    ActiveStatus    TEXT
  );
---------------------------------------------------------------

Customer Payment Summary Table:
---------------------------------------------------------------
CREATE TABLE CustomerPaymentSummary (
    CustomerID      INTEGER PRIMARY KEY,
    FullName        VARCHAR(100),
    Email           VARCHAR(100),
    TotalSpent      DECIMAL(10,2),
    ActiveStatus    TEXT
);
---------------------------------------------------------------

Key Notes:
    Both tables are independent from the original DVD tables.
    The two tables hold report data.
    ActiveStatus will come from my user-defined function.
    These tables will be populated using INSERT INTO ... SELECT statements in later sections.
