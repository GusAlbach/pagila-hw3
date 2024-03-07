/*
 * Management wants to rank customers by how much money they have spent in order to send coupons to the top 10%.
 *
 * Write a query that computes the total amount that each customer has spent.
 * Include a "percentile" column that contains the customer's percentile spending,
 * and include only customers in at least the 90th percentile.
 * Order the results alphabetically.
 *
 * HINT:
 * I used the `ntile` window function to compute the percentile.
 */
WITH total_spent AS (
       SELECT customer.customer_id, CONCAT(first_name, ' ', last_name) AS name, SUM(amount) AS total_payment
       FROM customer JOIN payment ON customer.customer_id=payment.customer_id 	
       GROUP BY customer.customer_id ORDER BY name
),
 step_two AS (
SELECT customer_id,
	name, 
	total_payment,
	NTILE(100) OVER (ORDER BY total_payment) AS percentile
FROM total_spent
ORDER BY name
)
SELECT customer_id, name, total_payment, percentile FROM step_two WHERE percentile >= 90 ORDER BY name;
