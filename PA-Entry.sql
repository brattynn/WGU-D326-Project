CREATE OR REPLACE FUNCTION transform_active_status(active_value	INTEGER)
RETURNS TEXT 
AS
$$
BEGIN
	IF active_value = 1
	THEN RETURN 'Active';
	ELSEIF active_value = 0
	THEN RETURN 'Inactive';
	ELSE RETURN 'Unknown';
	END IF;
END;
$$
LANGUAGE plpgsql;

--Check to see if the function exists
SELECT proname, proargtypes
FROM pg_proc
WHERE proname = 'transform_active_status';

--Test the above function with the following:
SELECT transformActiveStatus(1); --Should output 'Active'
SELECT transformActiveStatus(0); -- Should output 'Inactive'
SELECT transformActiveStatus(2); -- Should output 'Unkown'

--Creating 2 new tables
CREATE TABLE customer_payment_detail (
	payment_id		INTEGER PRIMARY KEY,
	customer_id		INTEGER,
	first_name		VARCHAR(50),
	last_name		VARCHAR(50),
	email			VARCHAR(100),
	payment_date	TIMESTAMP,
	amount			DECIMAL(5,2),
	active_status	TEXT
);

CREATE TABLE customer_payment_summary (
	customer_id		INTEGER PRIMARY KEY,
	full_name		VARCHAR(100),
	email			VARCHAR(100),
	total_spent		DECIMAL(10,2),
	active_status	TEXT
);

--Show that the tables were created
SELECT * FROM customer_payment_detail;
SELECT * FROM customer_payment_summary;

--Drop the created tables (for testing purposes ONLY)
DROP TABLE customer_payment_detail;
DROP TABLE customer_payment_summary;

--Creating a trigger function
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

--Using the Trigger Function
CREATE TRIGGER trg_update_summary_after_insert
AFTER INSERT ON customer_payment_detail
FOR EACH ROW
EXECUTE FUNCTION update_customer_payment_summary();

--This query pulls data from payment and customer, then uses my function 
--transform_active_status() to convert the active field into a readable label.
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
  transform_active_status(c.active::INT) AS active_status
FROM payment p
JOIN customer c ON p.customer_id = c.customer_id;


--Check the tables
SELECT * FROM customer_payment_detail; --14596 rows
SELECT * FROM customer_payment_summary;

--Select the top 5 spenders
SELECT * FROM customer_payment_summary
ORDER BY total_spent DESC
LIMIT 5;

--Stored Procedure
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
        transform_active_status(c.active::int)
    FROM payment p
    JOIN customer c ON p.customer_id = c.customer_id;
END;
$$;

--Delete
DELETE FROM customer_payment_detail;
DELETE FROM customer_payment_summary;

--Check tables
SELECT * FROM customer_payment_detail; --14596 rows
SELECT * FROM customer_payment_summary;

--Call the stored Procedure
CALL refresh_customer_payment_report();

--Check tables
SELECT * FROM customer_payment_detail; --14596 rows
SELECT * FROM customer_payment_summary;

--Find the top spending customers
SELECT * FROM customer_payment_summary
ORDER BY total_spent DESC
LIMIT 5;
