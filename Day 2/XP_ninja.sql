-- 1
SELECT firstname, lastname
FROM customers
ORDER BY firstname ASC, lastname ASC
LIMIT 2;

-- 2
DELETE FROM purchases
WHERE customer_id = (SELECT id FROM customers WHERE firstname = 'Scott' AND lastname = 'Scott');

-- 3
SELECT *
FROM customers
WHERE first_name = 'Scott' AND last_name = 'Scott';

-- 4
SELECT p.id, p.customer_id, p.item_id, p.quantity_purchased, c.firstname, c.lastname
FROM purchases p
LEFT JOIN customers c ON p.customer_id = c.id;

-- 5
SELECT p.id, p.customer_id, p.item_id, p.quantity_purchased, c.firstname, c.lastname
FROM purchases p
INNER JOIN customers c ON p.customer_id = c.id;