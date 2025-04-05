WGU Task: Provide original SQL code in a text format that creates a trigger on the detailed table of the report that will continually update the summary table as data is added to the detailed table.

This trigger will automatically insert or update a row in CustomerPaymentSummary anytime a new row is added to CustomerPaymentDetail.

------------------------------------------------
Trigger Function:
------------------------------------------------
CREATE OR REPLACE FUNCTION update_customer_payment_summary()
RETURNS TRIGGER AS $$
BEGIN
    IF EXISTS (                                   -- Check if customer already exists in summary table
        SELECT 1 FROM CustomerPaymentSummary
        WHERE CustomerID = NEW.CustomerID
    ) THEN
        UPDATE CustomerPaymentSummary            -- If so, update their total_spent
        SET 
            TotalSpent = TotalSpent + NEW.Amount
        WHERE CustomerID = NEW.CustomerID;
    ELSE
        INSERT INTO CustomerPaymentSummary (     -- Otherwise, insert a new summary record
            CustomerID,
            FullName,
            Email,
            TotalSpent,
            ActiveStatus
        )
        VALUES (
            NEW.CustomerID,
            NEW.FirstName || ' ' || NEW.LastName,
            NEW.Email,
            NEW.Amount,
            NEW.ActiveStatus
        );
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

----------------------------------------------------
Creating Trigger on CustomerPaymentDetails Table:
----------------------------------------------------
CREATE TRIGGER TrgUpdateSummaryAfterInsert
AFTER INSERT ON CustomerPaymentDetail
FOR EACH ROW
EXECUTE FUNCTION UpdateCustomerPaymentSummary();

----------------------------------------------------


What This Does:
    Runs after each insert into the detailed table
    Automatically ensures the summary stays accurate
    Keeps things synced without needing a separate refresh—good automation demo for the project




