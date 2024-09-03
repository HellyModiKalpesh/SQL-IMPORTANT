-- Day 04/50 


create table ORDERS2(
  	category varchar(20),
	product varchar(20),
	user_id int , 
  	spend int,
  	transaction_date DATE
);

Insert into ORDERS2 values
('appliance','refrigerator',165,246.00,'2021/12/26'),
('appliance','refrigerator',123,299.99,'2022/03/02'),
('appliance','washingmachine',123,219.80,'2022/03/02'),
('electronics','vacuum',178,152.00,'2022/04/05'),
('electronics','wirelessheadset',156,	249.90,'2022/07/08'),
('electronics','TV',145,189.00,'2022/07/15'),
('Television','TV',165,129.00,'2022/07/15'),
('Television','TV',163,129.00,'2022/07/15'),
('Television','TV',141,129.00,'2022/07/15'),
('toys','Ben10',145,189.00,'2022/07/15'),
('toys','Ben10',145,189.00,'2022/07/15'),
('toys','yoyo',165,129.00,'2022/07/15'),
('toys','yoyo',163,129.00,'2022/07/15'),
('toys','yoyo',141,129.00,'2022/07/15'),
('toys','yoyo',145,189.00,'2022/07/15'),
('electronics','vacuum',145,189.00,'2022/07/15');

Select * from ORDERS2 where category in ('toys','electronics');

/*
Find the top 2 products in the top 2 categories based on spend amount?

*/
-- top 2 category based on total spend amount
with cte1 as (
select category from ORDERS2 group by category order by sum(spend) desc
limit 2
),
productranking as (
select product,category,sum(spend) as total,
dense_rank() over(partition by category order by sum(spend) desc) as rnk from ORDERS2
 where category in (select category from cte1)
 group by product, category order by category, sum(spend) desc
 
)
select product,category,total from productranking where rnk<=2;

-- Day 05/30 SQL Challenge 

DROP TABLE IF EXISTS Employees;
-- Create the Employee table
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10, 2),
    HireDate DATE
);

-- Insert sample records into the Employee table
INSERT INTO Employees (EmployeeID, Name, Department, Salary, HireDate) VALUES
(101, 'John Smith', 'Sales', 60000.00, '2022-01-15'),
(102, 'Jane Doe', 'Marketing', 55000.00, '2022-02-20'),
(103, 'Michael Johnson', 'Finance', 70000.00, '2021-12-10'),
(104, 'Emily Brown', 'Sales', 62000.00, '2022-03-05'),
(106, 'Sam Brown', 'IT', 62000.00, '2022-03-05'),	
(105, 'Chris Wilson', 'Marketing', 58000.00, '2022-01-30');

select * from Employees;

/*
Write a SQL query to retrieve the 
third highest salary from the Employee table.

*/

with cte as (
select *,
dense_rank() over(order by salary desc) as rnk 
from Employees
)
select * from cte where rnk=3;

-- Day 06/50 days sql challenge 


DROP TABLE IF EXISTS employees;

-- Create the employee_salary table
CREATE TABLE employees (
    emp_id INT,
    name VARCHAR(100),
    department VARCHAR(50),
    salary DECIMAL(10, 2)
);



-- Insert all records again to simulate duplicates
INSERT INTO employees(emp_id, name, department, salary) VALUES
(1, 'John Doe', 'Finance', 60000.00),
(2, 'Jane Smith', 'Finance', 65000.00), 
(2, 'Jane Smith', 'Finance', 65000.00),   -- Duplicate
(9, 'Lisa Anderson', 'Sales', 63000.00),
(9, 'Lisa Anderson', 'Sales', 63000.00),  -- Duplicate
(9, 'Lisa Anderson', 'Sales', 63000.00),  -- Duplicate
(10, 'Kevin Martinez', 'Sales', 61000.00);


/*
Question:

How would you identify duplicate entries in
a SQL in given table employees columns are 
emp_id, name, department, salary

*/
select * from employees;
select emp_id,name,count(1) as total_count from employees group by emp_id,name having count(1)>1;

# 2 nd approach
SELECT *
FROM (	
	SELECT *,
	ROW_NUMBER() OVER(PARTITION BY name ORDER BY name) as rn
	FROM employees
) as subquery
WHERE rn > 1;

-- 07/50 Days SQL Challenge

DROP TABLE IF EXISTS customers;

CREATE TABLE customers (
    customer_id INT,
    name VARCHAR(100),
    email VARCHAR(100)
);

DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
    order_id INT ,
    customer_id INT,
    order_date DATE,
    amount DECIMAL(10, 2)
);

-- Inserting sample customers
INSERT INTO customers (customer_id, name, email) VALUES
(1, 'John Doe', 'john@example.com'),
(2, 'Jane Smith', 'jane@example.com'),
(3, 'Alice Johnson', 'alice@example.com'),
(4, 'Sam B', 'sb@example.com'),
(5, 'John Smith', 'j@example.com')	
;

-- Inserting sample orders
INSERT INTO orders (order_id, customer_id, order_date, amount) VALUES
(1, 1, '2024-03-05', 50.00),
(2, 2, '2024-03-10', 75.00),
(5, 4, '2024-04-02', 45.00),
(5, 2, '2024-04-02', 45.00)	,
(3, 4, '2024-04-15', 100.00),
(4, 1, '2024-08-03', 60.00),
(5, 5, '2024-04-02', 45.00);

SELECT * FROM customers;
SELECT * FROM orders;

/*
Write an SQL query to find customers who 
haven't made any purchases in the last month, 
*/

select * from orders left join customers
on orders.customer_id=customers.customer_id
where order_date < CURDATE()- INTERVAL 1 MONTH;
