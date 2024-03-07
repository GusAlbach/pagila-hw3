/*
 * Management wants to create a "best sellers" list for each actor.
 *
 * Write a SQL query that:
 * For each actor, reports the three films that the actor starred in that have brought in the most revenue for the company.
 * (The revenue is the sum of all payments associated with that film.)
 *
 * HINT:
 * For correct output, you will have to rank the films for each actor.
 * My solution uses the `rank` window function.
 */
WITH problem_body AS (
SELECT a.actor_id, a.first_name, a.last_name, lat.film_id, lat.title, RANK() OVER (PARTITION BY a.actor_id ORDER BY lat.revenue DESC, title), lat.revenue
FROM actor a 
LEFT JOIN LATERAL (
	SELECT film.film_id, film.title, SUM(amount) AS revenue
	FROM film_actor JOIN film ON film_actor.film_id = film.film_id
        JOIN inventory ON film.film_id = inventory.film_id 
	JOIN rental USING (inventory_id)
	JOIN payment USING (rental_id)
	WHERE film_actor.actor_id = a.actor_id
	GROUP BY film.film_id
) AS lat ON true
ORDER BY a.actor_id
)
SELECT actor_id, first_name, last_name, film_id, title, rank, revenue 
FROM problem_body
WHERE rank <= 3
ORDER BY actor_id, rank
;  
