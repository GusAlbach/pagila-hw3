/*
 * List all actors with Bacall Number 2;
 * That is, list all actors that have appeared in a film with an actor that has appeared in a film with 'RUSSELL BACALL',
 * but do not include actors that have Bacall Number < 2.
 */
WITH first_degree AS (
        SELECT DISTINCT actor_id FROM actor JOIN film_actor USING (actor_id) WHERE actor_id != 112 AND film_id IN (
        SELECT film_id FROM film_actor JOIN actor USING (actor_id)
        WHERE actor_id = 112))
SELECT DISTINCT CONCAT(first_name, ' ', last_name) AS "Actor Name" FROM actor JOIN film_actor USING (actor_id) WHERE actor_id != 112 AND actor_id NOT IN (SELECT actor_id FROM first_degree) AND film_id in (
	SELECT film_id FROM film_actor JOIN actor USING (actor_id) WHERE actor_id IN (SELECT actor_id FROM first_degree)) 
ORDER BY "Actor Name";
