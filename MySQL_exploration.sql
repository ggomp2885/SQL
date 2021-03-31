-- mysql Generalized Statements and Example Code
						-- Format ------------------------------
						-- Purpose  -- Confirmed on 11/3/20
                        -- Generalized statements
                        -- Example Code


							-- GENERALIZED STATEMENTS
                            -- USE
-- USE db_name  -  this let's sql know to check this database for all table and column names specified afterward. Can also double click in GUI.


							-- SELECT
-- SELECT col_name_1, col_name_2
-- SELECT col_name DISTINCT col_name  - brings up a table showing the only show the unique values in that column.
-- SELECT col_name_1 AS new_col_name   - This AS will rename the selected column when it shows up in the table
-- SELECT col_name new_name   - a simple space here can also be used instead of the AS operator.


 							-- FROM
-- FROM tab_name
-- FROM tab_name, tab_name    -    this is simple syntax for a cross join.


							-- WHERE
-- WHERE col_name = value
-- WHERE col_name IN (‘str_1’, ‘str_2’)
-- WHERE col_name LIKE ‘b%’
-- WHERE col_name REGEXP ‘str_1|str_2’    -- REGEXP stands for “regular expression” - ‘[gim]e’ means it will pickup any entry, where any of the letters in the brackets, come before the letter outside of the bracket. Or ‘[a-h]e’ which includes all letters inbetwen.


							-- ORDER BY
-- ORDER BY col_name_1, col_name_2   --  defaults to least to greatest, or a-z
-- ORDER BY col_name_1, DESC col_name_2 DESC  --  flips order to greatest to least, or z-a.


							-- JOIN / USING
-- JOIN tab_name_2      --    for tables
-- 	ON tab_name_1.col_name = tab_name_2.col_name
-- JOIN db_name.tab_name_1    --    for tables in other databases
-- 	ON tab_name_2.col_name = tab_name_2.col_name
-- 	AND tab_name_1.col_name = tab_name_2.col_name   --  add this for compound joins.

-- USING (shared_col_name)   --   This is a little faster way to write the join command, as long as the reference ID column names are the same. Also you can put multiple column names at once, for 2 primary keys, by just separating them with a comma.
-- NATURAL JOIN tab_name    --   This infers the reference ID column from the primary table, in the from statement, and the table in this statement

							-- LIMIT
-- LIMIT # -   will return the amount of records up to this number. Can use LIMIT 6, 3 to skip the first # of records, and return the amount of records of the second #

							-- UNION
-- UNION      --    That's it, this statement just goes between your multiple queries (Select statements), it will add the rows of the two tables together. To do this, both tables must have the same number of selected columns. (same shape).

							-- INSERT
-- INSERT INTO table_name
-- INSERT INTO tab_name (‘col_name_1’, ‘col_name_2’)   --  this is for explicitly saying which columns to add the following values to, useful when you don't want to type out all the “default” words.
-- 		VALUES (DEFAULT,#,#), (DEFAULT,#,#)   -- this follows the same order as the column names. DEFAULT can be used wherever you have predetermined rules for this column.


                                            -- SQL Built-in Functions
-- SELECT COUNT(col_name)                -- example of a function with a more detailed filter
-- FROM tab_name
-- WHERE col_name_1 = 'string' AND col_name_2 > #
-- GROUP BY col_name;

-- SELECT AVG(col_name)
-- SELECT SUM(col_name)



						                    -- EXAMPLE CODE
                                            -- Tables/rows manipulation
                                 -- Create Tables -- Confirmed 11/4/20
-- USE mysql;
-- CREATE TABLE student(
--     student_id INT PRIMARY KEY  AUTO_INCREMENT,   -- even if auto_inc is setup, you must still include this value, or specify only the other columns when adding in records.
--     name VARCHAR(50) NOT NULL,
--     major VARCHAR(50) DEFAULT 'undecided',
--     FOREIGN KEY (mgr_id) REFERENCES employee(emp_id) ON DELETE SET NULL  --- This links a foriegn key to another table, and when any row is deleted, sets this value to NULL
--     FOREIGN KEY (client_id) REFERENCES client(client_id) ON DELETE CASCADE -- Shows the cascade setting
-- --  PRIMARY KEY (emp_id, client_id) -- this is for setting a composite key, although you can probably just use the syntax above to also do it.
-- );
-- USE mysql;
-- INSERT INTO student (name, major)
--     VALUES ('jack','biology');

-- DESCRIBE student;
-- SELECT * FROM student;

                            -- Inserting into multiple tables at the same time -- Confirmed 11/3/20
-- USE sql_store;
-- INSERT INTO orders (customer_id, order_date, status)
-- 	VALUES (1, '2019-01-02', 1);   -- This table also autoincrements the order_id number as "13"
-- INSERT INTO order_items
-- 	VALUES
-- 	 (LAST_INSERT_ID(), 1, 1, 2.95), -- These "last_insert_id()" function are pulling up the "13" created in the statement above.
--   (LAST_INSERT_ID(), 2, 1, 3.95);

							-- Add/Drop Columns in a Table -- Confirmed 11/4/20
-- ALTER TABLE student
-- ADD gpa DECIMAL(3,2);
-- ADD FOREIGN KEY (branch_id) REFERENCES branch(brand_id) ON DELETE SET NULL

-- ALTER TABLE student
-- DROP COLUMN gpa;

                            -- updating rows in an existing table -- Confirmed 11/3/20
-- USE Sql_invoicing;
-- UPDATE invoices
-- SET payment_total = invoice_total*.5, payment_date = due_date
-- 	WHERE invoice_id = 3
-- WHERE client_id IN (3, 4) AND birth_date > 1990-01-01
-- WHERE birth_date > '1990-01-01'
-- WHERE client_id = (
-- 		 SELECT client_id
--          FROM clients
--          WHERE name = "MyWorks")

                            -- copying of data into a new table -- Confirmed 11/3/20
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



						    -- Delete rows in a table  -- Confirmed 11/3/20
-- DELETE FROM invoices
-- WHERE client_id = (
-- 		SELECT client_id
-- 		FROM clients
--      WHERE name = "Myworks");


							-- Delete Tables/Databases -- Confirmed 11/3/20
-- DROP TABLE sql_invoicing.invoices_archived
-- DROP DATABASE sql_invoicing

                                            -- QUERIES
                            -- Query with a function -- Confirmed 11/4/20
-- SELECT SUM(total_sales), emp_id
-- FROM works_with
-- GROUP BY emp_id;  -- Gives the COUNT of each unique entry in the column

                            -- Query with a function -- Confirmed 11/4/20
-- USE mysql;
-- SELECT employee.first_name, employee.last_name
-- FROM employee
-- Where employee.emp_id IN (
--                     SELECT works_with.emp_id
--                     FROM works_with
--                     WHERE works_with.total_sales > 30000 );


                            -- Using REGEXP syntax to filter data -- Confirmed 11/3/20
-- USE sql_store;
-- SELECT *
-- FROM customers
-- WHERE first_name REGEXP '^elka|^ambur'
-- WHERE last_name REGEXP 'EY$|ON$'
-- WHERE last_name REGEXP '^my|se'
-- WHERE last_name REGEXP 'B[ru]'


						-- Filtering by IS NULL -- Confirmed 11/3/20
-- USE sql_store;
-- SELECT *
-- FROM orders
-- WHERE shipped_date IS NULL


						-- Filtering by descending order, with a limit  -- Confirmed 11/3/20
-- USE sql_store;
-- SELECT *, quantity * unit_price AS total_price
-- FROM order_items
-- WHERE order_id = 2
-- ORDER BY total_price DESC
-- LIMIT 3

                                        -- JOINS
						-- Joining a table -- Confirmed 11/3/20
-- USE sql_store;
-- SELECT order_id, oi.product_id, oi.unit_price, quantity
-- FROM order_items oi
-- JOIN products p
-- 	ON p.product_id = oi.product_id


						-- Joining a table to itself -- Confirmed 11/3/20
-- USE sql_hr;
-- SELECT
-- 	 e.employee_id,
--      e.first_name,
--      m.first_name as manager
-- From employees e
-- Join employees m
-- 	 ON e.reports_to = m.employee_id


						-- Multiple Joins at once -- Confirmed 11/3/20
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

						-- Union of rows example -- Confirmed 11//20
-- SELECT first_name
-- FROM employee
-- UNION
-- SELECT branch_name
-- FROM branch
-- UNION
-- SELECT client_name
-- FROM client
                                    -- TRIGGERS
                        -- trigger log message for entering data -- Confirmed 11/420
-- CREATE DATABASE trig_explore;

-- CREATE TABLE trigger_log (
--                 message VARCHAR(100)
-- );
-- USE trig_explore;
-- DELIMITER $$         -- must change delimiter for triggers 
-- CREATE TRIGGER my_trigger BEFORE INSERT
--     ON employee
--     FOR EACH ROW BEGIN
--         IF NEW.sex ='M' THEN
--             INSERT INTO trigger_log VALUES ('added male employee');
--         ELSEIF NEW.sex ='F' THEN
--             INSERT INTO trigger_log VALUES ('added female employee');
--         ELSE
--             INSERT INTO trigger_log VALUES ('added other employee');
--         END IF;
-- END $$
-- DELIMITER ;

-- --        testing trigger
-- INSERT INTO employee VALUES(115, 'Johnny', 'Hudsan', '1958-02-19', 'M', 1000000, 102, 2);
-- SELECT * FROM trigger_log;



                        -- Dropping a trigger
-- USE trig_explore;
-- DROP TRIGGER IF EXISTS trig_explore.my_trigger;






							-- Okay so how do I rollback a change ?
