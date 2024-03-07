/*
 * Management also wants to create a "best sellers" list for each category.
 *
 * Write a SQL query that:
 * For each category, reports the five films that have been rented the most for each category.
 *
 * Note that in the last query, we were ranking films by the total amount of payments made,
 * but in this query, you are ranking by the total number of times the movie has been rented (and ignoring the price).
 */
WITH part_one AS (
SELECT c.name, lat.title, "total rentals"
FROM category c  
LEFT JOIN LATERAL (
	SELECT  film.title, COUNT(title) AS "total rentals"
	FROM film_category
	JOIN film ON film_category.film_id = film.film_id
	JOIN inventory ON film.film_id = inventory.film_id
	JOIN rental USING (inventory_id)
	WHERE c.category_id = film_category.category_id 
	GROUP BY title 
) AS lat ON true
)

SELECT name, title, "total rentals" 
FROM (
       SELECT name, title, "total rentals",
RANK() OVER (PARTITION BY name ORDER BY "total rentals" DESC, title DESC) AS ran
FROM part_one) AS ranked
WHERE ran <= 5
ORDER BY name, "total rentals" DESC, title;
