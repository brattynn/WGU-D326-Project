--WGU Task: Provide original SQL code in a text format that creates the detailed and summary tables to hold your report table sections.

--I’ll create two new tables:
  --customer_payment_detail     contains each individual payment with full customer info
  --customer_payment_summary    aggregates total spending by customer

--Customer Payment Detail Table:
---------------------------------------------------------------
  CREATE TABLE customer_payment_detail (
    payment_id       INTEGER PRIMARY KEY,
    customer_id      INTEGER,
    first_name       VARCHAR(50),
    last_name        VARCHAR(50),
    email            VARCHAR(100),
    payment_date     TIMESTAMP,
    amount           DECIMAL(5,2),
    active_status    TEXT
  );
---------------------------------------------------------------

--Customer Payment Summary Table:
---------------------------------------------------------------
CREATE TABLE customer_payment_summary (
    customer_id      INTEGER PRIMARY KEY,
    full_name        VARCHAR(100),
    email            VARCHAR(100),
    total_spent      DECIMAL(10,2),
    active_status    TEXT
);
---------------------------------------------------------------

--Key Notes:
    --Both tables are independent from the original DVD tables.
    --The two tables hold report data.
    --active_status will come from my user-defined function.
    --These tables will be populated using INSERT INTO ... SELECT statements in later sections.
