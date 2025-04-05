WGU Task:  Provide an original SQL query in a text format that will extract the raw data needed for the detailed section of your report from the source database.

This query pulls data from payment and customer, then uses my function TransformActiveStatus() to convert the active field into a readable label.

--------------------------------------------------
INSERT INTO customer_payment_detail (
  PaymentID,
  CustomerID,
  FirstName,
  LastName,
  Email,
  PaymentDate,
  Amount,
  ActiveStatus
)
SELECT
  p.payment_id,
  c.customer_id,
  c.first_name,
  c.last_name,
  c.email,
  p.payment_date,
  p.amount
  TranformActiveStatus(c.active) AS ActiveStatus
FROM payment p
JOIN customer c ON p.customer_id = c.customer_id;
--------------------------------------------------

What this does:
Joins payment to customer to get full customer info per payment.
Applies my user-defined function to clean up the active status.
Gives me all the fields I need for CustomerPaymentDetail.
