/*
 * List the first and last names of all actors who:
 * 1. have appeared in at least one movie in the "Children" category,
 * 2. but that have never appeared in any movie in the "Horror" category.
 */
SELECT DISTINCT first_name, last_name from actor WHERE actor_id IN 
(SELECT DISTINCT actor_id FROM film_actor 
	JOIN film ON film_actor.film_id=film.film_id
	JOIN film_category ON film.film_id=film_category.film_id
	JOIN category USING (category_id) 
	WHERE name LIKE 'Children' AND actor_id NOT IN (
		SELECT DISTINCT actor_id FROM film_actor
        JOIN film ON film_actor.film_id=film.film_id
        JOIN film_category ON film.film_id=film_category.film_id
        JOIN category USING (category_id)
        WHERE name LIKE 'Horror'
))
ORDER BY last_name;
