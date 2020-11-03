-- SELECT *
-- FROM customers
-- WHERE first_name REGEXP '^elka|^ambur'
-- WHERE last_name REGEXP 'EY$|ON$'
-- WHERE last_name REGEXP '^my|se'
-- WHERE last_name REGEXP 'B[ru]'

-- SELECT *
-- FROM orders
-- WHERE shipped_date IS NULL

-- SELECT *, quantity * unit_price AS "Total Price"
-- FROM order_items
-- WHERE order_id = 2
-- ORDER BY "total price" DESC

-- SELECT *
-- FROM customers
-- ORDER BY points DESC
-- LIMIT 3

-- SELECT order_id, oi.product_id, oi.unit_price, quantity
-- FROM order_items oi
-- JOIN products p
	-- ON p.product_id = oi.product_id
    
USE sql_hr;

SELECT
	e.employee_id,
    e.first_name,
    m.first_name as manager
From employees e
Join employees m
	ON e.reports_to = m.employee_id