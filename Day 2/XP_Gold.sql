-- Exercice 1 : 

-- 1
SELECT rating, COUNT(*) AS number_of_films
FROM film
GROUP BY rating;

-- 2.
SELECT title, rating
FROM film
WHERE rating IN ('G', 'PG-13');

-- 3.
SELECT title, length, rental_rate
FROM film
WHERE rating IN ('G', 'PG-13')
  AND length < 120
  AND rental_rate < 3.00
ORDER BY title;

-- 4.
UPDATE customer
SET first_name = 'VotrePrénom', last_name = 'VotreNom', email = 'votre@email.com'
WHERE customer_id = 1;

-- 5
UPDATE address
SET address = '123 Votre Rue', district = 'Votre Quartier', city_id = 1 
WHERE address_id = (SELECT address_id FROM customer WHERE customer_id = 1);

-- Exercice 2 : Table des élèves

-- 1
UPDATE students
SET birth_date = '1998-11-02'
WHERE first_name IN ('Léa', 'Marc') AND last_name = 'Bénichou';

UPDATE students
SET last_name = 'Guez'
WHERE first_name = 'David' AND last_name = 'Grez';

-- 2
DELETE FROM students
WHERE first_name = 'Léa' AND last_name = 'Benichou';

-- 3
SELECT COUNT(*) AS total_students FROM students;

SELECT COUNT(*) AS students_born_after_2000
FROM students
WHERE birth_date > '2000-01-01';

-- 4
ALTER TABLE students ADD COLUMN math_grade INT;

UPDATE students SET math_grade = 80 WHERE id = 1;

UPDATE students SET math_grade = 90 WHERE id IN (2, 4);

UPDATE students SET math_grade = 40 WHERE id = 6;

SELECT COUNT(*) AS students_above_83
FROM students
WHERE math_grade > 83;

INSERT INTO students (first_name, last_name, birth_date, math_grade)
SELECT first_name, last_name, birth_date, 70
FROM students
WHERE first_name = 'Omer' AND last_name = 'Simpson';

SELECT first_name, last_name, COUNT(math_grade) AS total_grade
FROM students
GROUP BY first_name, last_name;

SELECT SUM(math_grade) AS total_grades_sum FROM students;

-- Exercice 3 : Articles et clients

-- Partie I

-- 1
CREATE TABLE purchases (
    id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers(id),
    item_id INT REFERENCES items(id),
    quantity_purchased INT NOT NULL
);

-- 2
INSERT INTO purchases (customer_id, item_id, quantity_purchased)
VALUES (
    (SELECT id FROM customers WHERE firstname = 'Scott' AND lastname = 'Scott'),
    (SELECT id FROM items WHERE name = 'Fan'),
    1
);

INSERT INTO purchases (customer_id, item_id, quantity_purchased)
VALUES (
    (SELECT id FROM customers WHERE firstname = 'Melanie' AND lastname = 'Johnson'),
    (SELECT id FROM items WHERE name = 'Large Desk'),
    10
);

INSERT INTO purchases (customer_id, item_id, quantity_purchased)
VALUES (
    (SELECT id FROM customers WHERE firstname = 'Greg' AND lastname = 'Jones'),
    (SELECT id FROM items WHERE name = 'Small Desk'),
    2
);

-- Partie II

-- 1
SELECT * FROM purchases;

-- 2
SELECT p.id, c.firstname, c.lastname, p.item_id, p.quantity_purchased
FROM purchases p
JOIN customers c ON p.customer_id = c.id;

-- 3
SELECT * FROM purchases
WHERE customer_id = 5;

-- 4
SELECT * FROM purchases
WHERE item_id IN (
    SELECT id FROM items WHERE name IN ('Large Desk', 'Small Desk')
);

-- 5
SELECT DISTINCT c.firstname, c.lastname, i.name AS item_name
FROM purchases p
JOIN customers c ON p.customer_id = c.id
JOIN items i ON p.item_id = i.id;

-- 6
INSERT INTO purchases (customer_id, quantity_purchased)
VALUES (
    (SELECT id FROM customers WHERE firstname = 'Trevor' AND lastname = 'Green'),
    5
);