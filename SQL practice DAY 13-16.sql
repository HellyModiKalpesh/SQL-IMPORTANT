-- SQL Challenge Day 13/50

DROP TABLE IF EXISTS employees;
CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    name VARCHAR(100),
    manager_id INT,
    FOREIGN KEY (manager_id) REFERENCES employees(emp_id)
);

INSERT INTO employees (emp_id, name, manager_id) VALUES
(1, 'John Doe', NULL),        -- John Doe is not a manager
(2, 'Jane Smith', 1),          -- Jane Smith's manager is John Doe
(3, 'Alice Johnson', 1),       -- Alice Johnson's manager is John Doe
(4, 'Bob Brown', 3),           -- Bob Brown's manager is Alice Johnson
(5, 'Emily White', NULL),      -- Emily White is not a manager
(6, 'Michael Lee', 3),         -- Michael Lee's manager is Alice Johnson
(7, 'David Clark', NULL),      -- David Clark is not a manager
(8, 'Sarah Davis', 2),         -- Sarah Davis's manager is Jane Smith
(9, 'Kevin Wilson', 2),        -- Kevin Wilson's manager is Jane Smith
(10, 'Laura Martinez', 4);     -- Laura Martinez's manager is Bob Brown

SELECT * FROM employees;
/*
write a SQL query to retrieve all employees' 
details along with their manager's names based on the manager ID
*/
select e1.emp_id,
e1.name,
e1.manager_id,
e2.name as manager_name
from employees as e1 inner join employees as e2 on 
e1.manager_id=e2.emp_id;

-- Task
-- Write a SQL query to find the names of all employees who are also managers. 
-- In other words, retrieve the names of employees who appear as managers in the manager_id column.

select distinct e2.name
from employees as e1 inner join employees as e2 on 
e1.manager_id=e2.emp_id;

-- SQL Challenge Day 14/50

DROP TABLE IF EXISTS customers;
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    customer_email VARCHAR(100)
);

DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    order_amount DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

INSERT INTO customers (customer_id, customer_name, customer_email) VALUES
(1, 'John Doe', 'john@example.com'),
(2, 'Jane Smith', 'jane@example.com'),
(3, 'Alice Johnson', 'alice@example.com'),
(4, 'Bob Brown', 'bob@example.com');

INSERT INTO orders (order_id, customer_id, order_date, order_amount) VALUES
(1, 1, '2024-01-03', 50.00),
(2, 2, '2024-01-05', 75.00),
(3, 1, '2024-01-10', 25.00),
(4, 3, '2024-01-15', 60.00),
(5, 2, '2024-01-20', 50.00),
(6, 1, '2024-02-01', 100.00),
(7, 2, '2024-02-05', 25.00),
(8, 3, '2024-02-10', 90.00),
(9, 1, '2024-02-15', 50.00),
(10, 2, '2024-02-20', 75.00);

select * from customers;
select * from orders;

/*
-- Find the top 2 customers who have spent the most money across all their orders. 
Return their names, emails, and total amounts spent
*/

select o.customer_id,c.customer_email,sum(order_amount) as total_spent from orders as o left join customers as c 
on o.customer_id=c.customer_id
group by o.customer_id
order by total_spent desc
limit 2;

-- Your Task
-- Find out customers details who has placed highest orders and total count of orders and total order amount

select o.customer_id,c.customer_email,c.customer_name,count(order_id) as order_count,sum(order_amount) as total_spent from orders as o left join customers as c 
on o.customer_id=c.customer_id
group by o.customer_id
order by total_spent desc
limit 2;

-- Day 15/50 SQL Challenge 


-- Creating the orders table
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    order_date DATE,
    product_id INT,
    quantity INT,
    price DECIMAL(10, 2)
);

-- Inserting records for the current month
INSERT INTO orders (order_date, product_id, quantity, price) VALUES
    ('2024-09-01', 1, 10, 50.00),
    ('2024-09-02', 2, 8, 40.00),
    ('2024-09-03', 3, 15, 30.00),
    ('2024-09-04', 4, 12, 25.00),
    ('2024-09-05', 5, 5, 60.00),
    ('2024-09-06', 6, 20, 20.00),
    ('2024-09-07', 7, 18, 35.00),
    ('2024-09-08', 8, 14, 45.00),
    ('2024-09-09', 1, 10, 50.00),
    ('2024-09-10', 2, 8, 40.00);

-- Inserting records for the last month
INSERT INTO orders (order_date, product_id, quantity, price) VALUES
    ('2024-08-01', 1, 12, 50.00),
    ('2024-08-02', 2, 10, 40.00),
    ('2024-08-03', 3, 18, 30.00),
    ('2024-08-04', 4, 14, 25.00),
    ('2024-08-05', 5, 7, 60.00),
    ('2024-08-06', 6, 22, 20.00),
    ('2024-08-07', 7, 20, 35.00),
    ('2024-08-08', 8, 16, 45.00),
    ('2024-08-09', 1, 12, 50.00),
    ('2024-08-10', 2, 10, 40.00);

-- Inserting records for the previous month
INSERT INTO orders (order_date, product_id, quantity, price) VALUES
    ('2024-07-01', 1, 15, 50.00),
    ('2024-07-02', 2, 12, 40.00),
    ('2024-07-03', 3, 20, 30.00),
    ('2024-07-04', 4, 16, 25.00),
    ('2024-07-05', 5, 9, 60.00),
    ('2024-07-06', 6, 25, 20.00),
    ('2024-07-07', 7, 22, 35.00),
    ('2024-07-08', 8, 18, 45.00),
    ('2024-07-09', 1, 15, 50.00),
    ('2024-07-10', 2, 12, 40.00);

select * from orders;

/*

Write an SQL query to retrieve the product details for items whose revenue 
decreased compared to the previous month. 

Display the product ID, quantity sold, 
and revenue for both the current and previous months.

*/

with cte as (
select product_id,sum(quantity) as current_total_quantity,sum(price*quantity) as total_revenue from orders where extract(month from order_date)= extract(month from CURRENT_DATE)
group by product_id
),
cte1 as (
select product_id,sum(quantity) as previous_total_quantity,sum(price*quantity)  as previous_total_revenue from orders where extract(month from order_date)= extract(month from CURRENT_DATE)-1
group by product_id
)
select cte.product_id,current_total_quantity,total_revenue,previous_total_quantity,previous_total_revenue from cte left join cte1 on cte.product_id=cte1.product_id
where total_revenue<previous_total_revenue;

-- Task: Write a SQL query to find the products whose total revenue has decreased by more than 10% from the previous month to the current month.

with cte as (
select product_id,sum(quantity) as current_total_quantity,sum(price*quantity) as total_revenue from orders where extract(month from order_date)= extract(month from CURRENT_DATE)
group by product_id
),
cte1 as (
select product_id,sum(quantity) as previous_total_quantity,sum(price*quantity)  as previous_total_revenue from orders where extract(month from order_date)= extract(month from CURRENT_DATE)-1
group by product_id
)
select cte.product_id,current_total_quantity,total_revenue,previous_total_quantity,previous_total_revenue from cte left join cte1 on cte.product_id=cte1.product_id
where total_revenue<previous_total_revenue*0.9;

-- Day 16/50 SQL Challenge


DROP TABLE IF EXISTS employees;
CREATE TABLE Employees (
    id INT PRIMARY KEY,
    name VARCHAR(255),
    department VARCHAR(255),
    managerId INT
);

INSERT INTO Employees (id, name, department, managerId) VALUES
(101, 'John', 'A', NULL),
(102, 'Dan', 'A', 101),
(103, 'James', 'A', 101),
(104, 'Amy', 'A', 101),
(105, 'Anne', 'A', 101),
(106, 'Ron', 'B', 101),
(107, 'Michael', 'C', NULL),
(108, 'Sarah', 'C', 107),
(109, 'Emily', 'C', 107),
(110, 'Brian', 'C', 107);


/*

Given a table named employees with the following columns:
id, name, department, managerId

Write a SQL query to find the names of 
managers who have at least five direct reports. 
Return the result table in any order.

Ensure that no employee is their own manager.

The result format should include only the names
of the managers meeting the criteria.
*/
select * from employees;

SELECT e1.managerId ,e2.name FROM employees as e1 left join employees as e2
on e1.managerId=e2.id 
group by e1.managerId,e2.name
having count(e1.managerId)>=5;

-- Your Task is to find out the total employees who doesn't have any managers!

with cte as (
SELECT e1.id as emp_id,e1.managerId as man_id FROM employees as e1 left join employees as e2
on e1.managerId=e2.id 
)
select count(emp_id) from cte where man_id is null
