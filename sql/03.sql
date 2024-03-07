/*
 * List the total amount of money that customers from each country have payed.
 * Order the results from most to least money.
 */
SELECT country, sum(amount) AS total_payments FROM country JOIN city USING (country_id)
JOIN address USING (city_id) 
JOIN customer USING (address_id)
JOIN payment ON customer.customer_id=payment.customer_id
GROUP BY country ORDER BY sum(amount) DESC, country;
