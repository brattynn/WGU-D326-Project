--WGU Task: Provide original SQL code in a text format that creates a trigger on the detailed table of the report that will continually update the summary table as data is added to the detailed table.

--This trigger will automatically insert or update a row in CustomerPaymentSummary anytime a new row is added to CustomerPaymentDetail.

------------------------------------------------
Trigger Function:
------------------------------------------------
CREATE OR REPLACE FUNCTION update_customer_payment_summary()
RETURNS TRIGGER 
AS
$$
BEGIN
    IF EXISTS (                                   -- Check if customer already exists in summary table
        SELECT 1 FROM customer_payment_summary
        WHERE customer_id = NEW.customer_id
    ) THEN
        UPDATE customer_payment_summary            -- If so, update their total_spent
        SET 
            total_spent = total_spent + NEW.amount
        WHERE customer_id = NEW.customer_id;
    ELSE
        INSERT INTO customer_payment_summary (     -- Otherwise, insert a new summary record
            customer_id,
            full_name,
            email,
            total_spent,
            active_status
        )
        VALUES (
            NEW.customer_id,
            NEW.first_name || ' ' || NEW.last_name,
            NEW.email,
            NEW.amount,
            NEW.active_status
        );
    END IF;
RETURN NEW;
END;
$$
LANGUAGE plpgsql;

----------------------------------------------------
--Creating Trigger on customer_payment_details Table:
----------------------------------------------------
CREATE TRIGGER trg_update_summary_after_insert
AFTER INSERT ON customer_payment_detail
FOR EACH ROW
EXECUTE FUNCTION update_customer_payment_summary();

----------------------------------------------------


--What This Does:
    --Runs after each insert into the detailed table
    --Automatically ensures the summary stays accurate
    --Keeps things synced without needing a separate refresh—good automation demo for the project




