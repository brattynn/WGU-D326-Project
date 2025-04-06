--WGU Task:   Provide an original stored procedure in a text format that can be used to refresh the data in both the detailed table and summary table. 
            --The procedure should clear the contents of the detailed table and summary table and perform the raw data extraction from part D.
            --1.  Identify a relevant job scheduling tool that can be used to automate the stored procedure.

--This stored procedure will:
    --Delete all rows from both the detailed and summary tables.
    --Repopulate the detailed table using the same query from Part D.
    --Let the trigger handle the summary table update.

------------------------------------------------
CREATE OR REPLACE PROCEDURE refresh_customer_payment_report()
LANGUAGE plpgsql
AS
$$
BEGIN
    -- Clear out the summary table first to avoid trigger errors
    DELETE FROM customer_payment_summary;
    -- Clear the detailed table
    DELETE FROM customer_payment_detail;
    -- Repopulate the detailed table (trigger will handle the summary)
    
   INSERT INTO customer_payment_detail (
        payment_id,
        customer_id,
        first_name,
        last_name,
        email,
        payment_date,
        amount,
        active_status
    )
    SELECT
        p.payment_id,
        c.customer_id,
        c.first_name,
        c.last_name,
        c.email,
        p.payment_date,
        p.amount,
        transform_active_status(c.active)
    FROM payment p
    JOIN customer c ON p.customer_id = c.customer_id;
END;
$$;
------------------------------------------------


--Why This Works:
    --We manually refresh the detailed table with the raw query
    --The trigger automatically updates the summary table row-by-row
    --Clean, modular, and hands-off once it’s in place



--F1: Job Scheduling Tool
  --For automating the procedure, we need a scheduling tool.
    --Recommendation: 'pgAgent' - A PostgreSQL job scheduler that can run stored procedures on a schedule (like every week or every night)
