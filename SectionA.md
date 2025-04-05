Business Report Summary:
  This report identifies the top 5 customers by total rental spending. The purpose for this is to highlight high-value customers for marketing purposes, loyalty programs, and customer service prioritization.
  The report consists of a section that includes all transactions and a summary that aggregates total spending by customer.


A1. Specific Fields in Each Table:
  Detailed Table Fields:
    CustomerID      unique ID for the customer
    FirstName       customer’s first name
    LastName        customer’s last name
    Email           customer’s contact email
    PaymentID       unique ID for each payment transaction
    Amount          amount paid for the rental
    PaymentDate     date of the payment
    ActiveStatus    transformed value of the active field to show "Active" or "Inactive"
  
  Summary Table Fields:
    CustomerID
    FullName        concatenation of first and last name
    TotalSpent      total amount spent across all payments
    Email
    ActiveStatus


A2. Data Field Types Used
    CustomerID:    INTEGER
    PaymentID:     INTEGER
    FirstName, LastName, Email, FullName:    VARCHAR
    ActiveStatus:          TEXT
    Amount, TotalSpent:    DECIMAL
    PaymentDate:           TIMESTAMP or DATE


A3. Source Tables from the Dataset
    Payment     provides payment transaction details including amount and payment date
    Customer    provides customer information including name, email, and active status


A4. User-Defined Function (UDF) Transformation
  The field active in the customer table is stored as a boolean integer (1 = active, 0 = inactive).
  To improve readability for business users, this field will be transformed using a user-defined function to show "Active" or "Inactive" instead of the boolean values.
  This transformation allows for easier understanding for non-technical stakeholders reviewing the report.


A5. Business Uses for the Report
    Detailed Table Use:
        This section allows analysts to view all payment transactions by each customer, including timestamps and payment amounts.
        It can be used for auditing, detailed financial analysis, or identifying transaction patterns.
    Summary Table Use:
        This section provides decision-makers with a ranked list of top-spending customers, which is useful for loyalty outreach, sales campaigns, or resource allocation.


A6. Refresh Frequency
  This report should be refreshed each week to ensure it reflects up-to-date payment activity. 
  Weekly updates allow timely identification of high-value customers and recent spending trends without overloading the system with unnecessary refreshes.











    
