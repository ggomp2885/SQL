						-- Explanation  -- Confirmed on 11/3/20

						-- Using REGEXP syntax to filter data -- All Confirmed
-- USE sql_store;
-- SELECT *
-- FROM customers
-- WHERE first_name REGEXP '^elka|^ambur'
-- WHERE last_name REGEXP 'EY$|ON$'
-- WHERE last_name REGEXP '^my|se'
-- WHERE last_name REGEXP 'B[ru]'

						-- Filtering by IS NULL -- Confirmed
-- USE sql_store;
-- SELECT *
-- FROM orders
-- WHERE shipped_date IS NULL

						-- Filtering by descending order, with a limit  -- Confirmed
-- USE sql_store;
-- SELECT *, quantity * unit_price AS total_price
-- FROM order_items
-- WHERE order_id = 2
-- ORDER BY total_price DESC
-- LIMIT 3


						-- Joining a table -- Confirmed
-- USE sql_store;
-- SELECT order_id, oi.product_id, oi.unit_price, quantity
-- FROM order_items oi
-- JOIN products p
-- 	ON p.product_id = oi.product_id
    
    
						-- Joining a table to itself -- Confirmed
-- USE sql_hr;
-- SELECT
-- 	 e.employee_id,
--      e.first_name,
--      m.first_name as manager
-- From employees e
-- Join employees m
-- 	 ON e.reports_to = m.employee_id



						-- Multiple Joins at once -- Confirmed
-- USE sql_invoicing;
-- SELECT                                              -- columns
-- 	c.name as client_name, 
-- 	pm.name as payment_method, 
--     p.date, 
--     p.amount,
--     p.invoice_id
-- 	FROM payments p                                    -- main table
-- 		JOIN payment_methods pm                        -- secondary table
-- 			ON p.payment_method = pm.payment_method_id -- matching column
-- 		JOIN clients c                                 -- secondary table
-- 			ON p.client_id = c.client_id               -- matching column
    
    

						-- Inserting into multiple tables at the same time -- Confirmed
-- USE sql_store;
-- INSERT INTO orders (customer_id, order_date, status)
-- 	VALUES (1, '2019-01-02', 1);   -- This table also autoincrements the order_id number as "13"
-- INSERT INTO order_items
-- 	VALUES 
-- 	 (LAST_INSERT_ID(), 1, 1, 2.95), -- These "last_insert_id()" function are pulling up the "13" created in the statement above.
--      (LAST_INSERT_ID(), 2, 1, 3.95); 
		
        
        
						-- copying of data into a new table -- Confirmed
-- USE Sql_invoicing;
-- CREATE TABLE invoices_archived AS
-- SELECT 
-- 	i.invoice_id,
--     i.number,
--     c.name AS client,
--     i.invoice_total,
--     i.payment_total,
--     i.invoice_date,
--     i.payment_date
-- 	FROM invoices i
-- 		JOIN clients c
-- 			USING (client_id)
-- 	WHERE payment_date IS NOT NULL
    
    
    
						-- updating rows in an existing table -- Confirmed
-- USE Sql_invoicing;
-- UPDATE invoices
-- SET payment_total = invoice_total*.5, payment_date = due_date
-- 	WHERE invoice_id = 3
-- WHERE client_id IN (3, 4)
-- WHERE birth_date > '1990-01-01'
-- WHERE client_id = (
-- 		 SELECT client_id 
--          FROM clients
--          WHERE name = "MyWorks")



						-- Deleting rows in a table  -- Confirmed
-- DELETE FROM invoices
-- WHERE client_id = (
-- 		SELECT client_id
-- 		FROM clients
--      WHERE name = "Myworks");


							-- oommand to Delete Tables -- Confirmed
-- DROP TABLE sql_invoicing.invoices_archived



                            -- oommand to Delete Databases -- Confirmed
-- DROP DATABASE sql_invoicing



							-- Okay so how do I rollback a change?


    
    