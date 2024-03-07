/* 
 * A new James Bond movie will be released soon, and management wants to send promotional material to "action fanatics".
 * They've decided that an action fanatic is any customer where at least 4 of their 5 most recently rented movies are action movies.
 *
 * Write a SQL query that finds all action fanatics.
 */
SELECT c.customer_id, c.first_name, c.last_name
FROM customer c
LEFT JOIN LATERAL (
	SELECT rental.customer_id, category.name
        FROM rental JOIN inventory USING (inventory_id)
	JOIN film ON inventory.film_id=film.film_id
	JOIN film_category ON film.film_id=film_category.film_id
	JOIN category USING (category_id)
	WHERE category.name LIKE 'Action' AND rental.customer_id = c.customer_id
) as sub ON true
GROUP BY c.customer_id
HAVING count(name) >= 4
ORDER BY c.customer_id;
