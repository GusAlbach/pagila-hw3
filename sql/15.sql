/*
 * Find every documentary film that is rated PG.
 * Report the title and the actors.
 *
 * HINT:
 * Getting the formatting right on this query can be tricky.
 * You are welcome to try to manually get the correct formatting.
 * But there is also a view in the database that contains the correct formatting,
 * and you can SELECT from that VIEW instead of constructing the entire query manually.
 */
SELECT distinct lat.title, STRING_AGG(INITCAP(a.first_name) || INITCAP(a.last_name), ', ') AS actors
FROM actor a
INNER JOIN LATERAL (
	SELECT film.title
	FROM film_actor JOIN film ON film_actor.film_id = film.film_id
	JOIN film_category ON film.film_id = film_category.film_id
	JOIN category USING (category_id)
	WHERE category.name LIKE 'Documentary' AND film.rating = 'G' AND a.actor_id = film_actor.actor_id
) AS lat ON true
GROUP BY title
ORDER BY title 
;
