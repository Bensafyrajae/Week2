-- Exercise 1:

-- 1
SELECT film.film_id, film.title, film.rating
FROM film
JOIN inventory ON film.film_id = inventory.film_id
LEFT JOIN rental ON inventory.inventory_id = rental.inventory_id
WHERE film.rating IN ('G', 'PG')
AND (
    rental.return_date IS NOT NULL
    OR rental.rental_id IS NULL
);

-- 2 

CREATE TABLE children_waiting_list (
    waiting_id SERIAL PRIMARY KEY,
    customer_id INTEGER NOT NULL,
    film_id INTEGER NOT NULL,
    added_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (film_id) REFERENCES film(film_id)
);

-- 3 

SELECT
    film.title,
    COUNT(children_waiting_list.waiting_id) AS number_of_people_waiting
FROM children_waiting_list
JOIN film ON children_waiting_list.film_id = film.film_id
GROUP BY film.title
ORDER BY number_of_people_waiting DESC;

--

INSERT INTO children_waiting_list (customer_id, film_id)
VALUES 
    (1, 10),  -- Customer 1 waits for film 10
    (2, 10),  -- Customer 2 also waits for film 10
    (3, 12);  -- Customer 3 waits for film 12