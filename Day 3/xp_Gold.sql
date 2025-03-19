-- Exercise 1 : DVD Rentals

-- 1 
SELECT *
FROM rental
WHERE return_date IS NULL;

-- 2 
SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    COUNT(r.rental_id) AS unreturned_rentals
FROM rental r
JOIN customer c ON r.customer_id = c.customer_id
WHERE r.return_date IS NULL
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY unreturned_rentals DESC;


-- 3 
SELECT
    f.film_id,
    f.title
FROM film f
JOIN film_actor fa ON f.film_id = fa.film_id
JOIN actor a ON fa.actor_id = a.actor_id
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
WHERE
    a.first_name = 'Joe'
    AND a.last_name = 'Swank'
    AND c.name = 'Action';

CREATE OR REPLACE VIEW joe_swank_films AS
SELECT
    f.film_id,
    f.title,
    c.name AS category
FROM film f
JOIN film_actor fa ON f.film_id = fa.film_id
JOIN actor a ON fa.actor_id = a.actor_id
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
WHERE
    a.first_name = 'Joe'
    AND a.last_name = 'Swank';

SELECT * FROM joe_swank_films WHERE category = 'Action';

-- Exercice2:



--1 
SELECT
    s.store_id,
    ci.city,
    co.country
FROM store s
JOIN address a ON s.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN country co ON ci.country_id = co.country_id;


-- 2 
SELECT
    s.store_id,
    SUM(f.length) AS total_minutes,
    ROUND(SUM(f.length)/60.0, 2) AS total_hours,
    ROUND(SUM(f.length)/60.0/24.0, 2) AS total_days
FROM store s
JOIN inventory i ON s.store_id = i.store_id
JOIN film f ON i.film_id = f.film_id
LEFT JOIN rental r ON i.inventory_id = r.inventory_id AND r.return_date IS NULL
WHERE r.rental_id IS NULL
GROUP BY s.store_id
ORDER BY s.store_id;

-- 3
SELECT DISTINCT
    c.customer_id,
    c.first_name,
    c.last_name,
    ci.city
FROM customer c
JOIN address a ON c.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
WHERE ci.city_id IN (
    SELECT ci.city_id
    FROM store s
    JOIN address a ON s.address_id = a.address_id
    JOIN city ci ON a.city_id = ci.city_id
);


-- 4
SELECT DISTINCT
    c.customer_id,
    c.first_name,
    c.last_name,
    co.country
FROM customer c
JOIN address a ON c.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN country co ON ci.country_id = co.country_id
WHERE co.country_id IN (
    SELECT DISTINCT co.country_id
    FROM store s
    JOIN address a ON s.address_id = a.address_id
    JOIN city ci ON a.city_id = ci.city_id
    JOIN country co ON ci.country_id = co.country_id
);


-- 5
SELECT
    f.film_id,
    f.title,
    f.description,
    f.length
FROM film f
WHERE f.film_id NOT IN (
    SELECT fc.film_id
    FROM film_category fc
    JOIN category c ON fc.category_id = c.category_id
    WHERE c.name = 'Horror'
)
AND f.title !~* '(beast|monster|ghost|dead|zombie|undead)'
AND f.description !~* '(beast|monster|ghost|dead|zombie|undead)';


-- 6
SELECT
    SUM(f.length) AS total_minutes,
    ROUND(SUM(f.length)/60.0, 2) AS total_hours,
    ROUND(SUM(f.length)/60.0/24.0, 2) AS total_days
FROM film f
WHERE f.film_id NOT IN (
    SELECT fc.film_id
    FROM film_category fc
    JOIN category c ON fc.category_id = c.category_id
    WHERE c.name = 'Horror'
)
AND f.title !~* '(beast|monster|ghost|dead|zombie|undead)'
AND f.description !~* '(beast|monster|ghost|dead|zombie|undead)';