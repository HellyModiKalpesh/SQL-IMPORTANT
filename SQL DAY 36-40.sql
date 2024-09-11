-- SQL Challenge Day 36

DROP TABLE IF EXISTS Employees;
CREATE TABLE Employees (
  Emp_No DECIMAL(4,0) NOT NULL,
  Emp_Name VARCHAR(10),
  Job_Name VARCHAR(9),
  Manager_Id DECIMAL(4,0),
  HireDate DATE,
  Salary DECIMAL(7,2),
  Commission DECIMAL(7,2),  
  DeptNo DECIMAL(2,0) NOT NULL
);

INSERT INTO Employees (Emp_No, Emp_Name, Job_Name, Manager_Id, HireDate, Salary, Commission, DeptNo) VALUES
(7839, 'KING', 'PRESIDENT', NULL, '1981-11-17', 5000, NULL, 10),
(7698, 'BLAKE', 'MANAGER', 7839, '1981-05-01', 2850, NULL, 30),
(7782, 'CLARK', 'MANAGER', 7839, '1981-06-09', 2450, NULL, 10),
(7566, 'JONES', 'MANAGER', NULL, '1981-04-02', 2975, NULL, 20),
(7788, 'SCOTT', 'ANALYST', 7566, '1987-07-29', 3000, NULL, 20),
(7902, 'FORD', 'ANALYST', 7566, '1981-12-03', 3000, NULL, 20),
(7369, 'SMITH', 'CLERK', 7902, '1980-12-17', 800, NULL, 20),
(7499, 'ALLEN', 'SALESMAN', NULL, '1981-02-20', 1600, 300, 30),
(7521, 'WARD', 'SALESMAN', 7698, '1981-02-22', 1250, 500, 30),
(7654, 'MARTIN', 'SALESMAN', 7698, '1981-09-28', 1250, 1400, 30),
(7844, 'TURNER', 'SALESMAN', 7698, '1981-09-08', 1500, 0, 30),
(7876, 'ADAMS', 'CLERK', NULL, '1987-06-02', 1100, NULL, 20),
(7900, 'JAMES', 'CLERK', 7698, '1981-12-03', 950, NULL, 30),
(7934, 'MILLER', 'CLERK', 7782, '1982-01-23', 1300, NULL, 10);



/*
Question

Write an SQL script to display the 
immediate manager of an employee.

The script should take an input parameter 
Emp_No and return the employee's name 
along with their immediate manager's name.

If an employee has no manager 
(i.e., Manager_Id is NULL), 
display "No Boss" for that employee.

*/

SELECT * FROM employees;

select e1.Emp_Name as employee_name,
coalesce(e2.Emp_Name,'no boss') as manager_name
from employees as e1
left join employees as e2
on e1.Manager_Id=e2.Emp_No
where e1.Emp_No =7934;

-- 37/50 SQL challenge

-- Create customers table
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100)
);

-- Create spending records table
CREATE TABLE spending_records (
    record_id INT PRIMARY KEY,
    customer_id INT,
    spending_amount DECIMAL(10, 2),
    spending_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- Insert example data into customers table
INSERT INTO customers (customer_id, customer_name) VALUES
(1, 'John'),
(2, 'Alice'),
(3, 'Bob'),
(4, 'Charlie');

-- Insert example data into spending records table
INSERT INTO spending_records (record_id, customer_id, spending_amount, spending_date) VALUES
(9, 1, 120.00, '2024-03-25'),
(10, 2, 80.00, '2024-03-25'),
(11, 3, 150.00, '2024-03-25'),
(12, 4, 70.00, '2024-03-25'),
(13, 1, 90.00, '2024-03-02'),
(14, 2, 100.00, '2024-04-02'),
(15, 3, 160.00, '2024-04-02'),
(16, 4, 30.00, '2024-03-02'),
(17, 1, 110.00, '2024-04-09'),
(18, 2, 70.00, '2024-02-09'),
(19, 3, 140.00, '2024-03-09'),
(20, 4, 60.00, '2024-04-09'),
(21, 1, 100.00, '2024-03-16'),
(22, 2, 60.00, '2024-03-16'),
(23, 3, 130.00, '2024-03-16'),
(24, 4, 50.00, '2024-04-16'),
(25, 1, 80.00, '2024-03-23'),
(26, 2, 50.00, '2024-04-23'),
(27, 3, 120.00, '2024-04-23'),
(28, 4, 40.00, '2024-04-23'),
(29, 1, 70.00, '2024-04-30'),
(30, 2, 40.00, '2024-04-30'),
(31, 3, 110.00, '2024-03-01'),
(32, 4, 30.00, '2024-03-01');

/*

-- Amazon Data Analyst Interview Question

You are given two table of amazon
spending_records and customers 

Write a SQL query to show all customers
and their total spending show only those
customers whos total spending has reduced
compare to last month ()

Return customer_name, customer_id, 
last MONTH spend, current month spent 

-- Note consider last month as March
Current Month as Aprilbookings
*/


SELECT * FROM spending_records;
SELECT * FROM customers;

with cte as (
select s.customer_id,c.customer_name as name,sum(spending_amount) as last_spend
from spending_records as s left join customers as c
on s.customer_id=c.customer_id
where extract(month from spending_date)=3
group by s.customer_id
),
cte1 as (
select s.customer_id,c.customer_name as name,sum(spending_amount) as current_spend
from spending_records as s left join customers as c
on s.customer_id=c.customer_id
where extract(month from spending_date)=4
group by s.customer_id
)
select cte.customer_id,cte.last_spend,cte.name,cte1.current_spend
from cte left join cte1
on cte.customer_id=cte1.customer_id
where current_spend<last_spend;

-- SQL challenge 38/50

DROP TABLE IF EXISTS Employees;

CREATE TABLE Employees (
  Emp_No DECIMAL(4,0) NOT NULL,
  Emp_Name VARCHAR(10),
  Job_Name VARCHAR(9),
  Manager_Id DECIMAL(4,0),
  HireDate DATE,
  Salary DECIMAL(7,2),
  Commission DECIMAL(7,2),  
  Department VARCHAR(20) -- Changed from DeptNo to Department
);

INSERT INTO Employees (Emp_No, Emp_Name, Job_Name, Manager_Id, HireDate, Salary, Commission, Department) VALUES
(7839, 'KING', 'PRESIDENT', NULL, '1981-11-17', 5000, NULL, 'IT'),
(7698, 'BLAKE', 'MANAGER', 7839, '1981-05-01', 2850, NULL, 'HR'),
(7782, 'CLARK', 'MANAGER', 7839, '1981-06-09', 2450, NULL, 'Marketing'),
(7566, 'JONES', 'MANAGER', 7839, '1981-04-02', 2975, NULL, 'Operations'),
(7788, 'SCOTT', 'ANALYST', 7566, '1987-07-29', 3000, NULL, 'Operations'),
(7902, 'FORD', 'ANALYST', 7566, '1981-12-03', 3000, NULL, 'Operations'),
(7369, 'SMITH', 'CLERK', 7902, '1980-12-17', 800, NULL, 'Operations'),
(7499, 'ALLEN', 'SALESMAN', 7698, '1981-02-20', 1600, 300, 'HR'),
(7521, 'WARD', 'SALESMAN', 7698, '1981-02-22', 1250, 500, 'HR'),
(7654, 'MARTIN', 'SALESMAN', 7698, '1981-09-28', 1250, 1400, 'HR'),
(7844, 'TURNER', 'SALESMAN', 7698, '1981-09-08', 1500, 0, 'HR'),
(7876, 'ADAMS', 'CLERK', 7788, '1987-06-02', 1100, NULL, 'Operations'),
(7900, 'JAMES', 'CLERK', 7698, '1981-12-03', 950, NULL, 'HR'),
(7934, 'MILLER', 'CLERK', 7782, '1982-01-23', 1300, NULL, 'Marketing'),
(7905, 'BROWN', 'SALESMAN', 7698, '1981-11-12', 1250, 1400, 'HR'),
(7906, 'DAVIS', 'ANALYST', 7566, '1987-07-13', 3000, NULL, 'Operations'),
(7907, 'GARCIA', 'MANAGER', 7839, '1981-08-12', 2975, NULL, 'IT'),
(7908, 'HARRIS', 'SALESMAN', 7698, '1981-06-21', 1600, 300, 'HR'),
(7909, 'JACKSON', 'CLERK', 7902, '1981-11-17', 800, NULL, 'Operations'),
(7910, 'JOHNSON', 'MANAGER', 7839, '1981-04-02', 2850, NULL, 'Marketing'),
(7911, 'LEE', 'ANALYST', 7566, '1981-09-28', 1250, 1400, 'Operations'),
(7912, 'MARTINEZ', 'CLERK', 7902, '1981-12-03', 1250, NULL, 'Operations'),
(7913, 'MILLER', 'MANAGER', 7839, '1981-01-23', 2450, NULL, 'HR'),
(7914, 'RODRIGUEZ', 'SALESMAN', 7698, '1981-12-03', 1500, 0, 'Marketing'),
(7915, 'SMITH', 'CLERK', 7902, '1980-12-17', 1100, NULL, 'IT'),
(7916, 'TAYLOR', 'CLERK', 7902, '1981-02-20', 950, NULL, 'Marketing'),
(7917, 'THOMAS', 'SALESMAN', 7698, '1981-02-22', 1250, 500, 'Operations'),
(7918, 'WHITE', 'ANALYST', 7566, '1981-09-28', 1300, NULL, 'IT'),
(7919, 'WILLIAMS', 'MANAGER', 7839, '1981-11-17', 5000, NULL, 'Marketing'),
(7920, 'WILSON', 'SALESMAN', 7698, '1981-05-01', 2850, NULL, 'HR'),
(7921, 'YOUNG', 'CLERK', 7902, '1981-06-09', 2450, NULL, 'Operations'),
(7922, 'ADAMS', 'ANALYST', 7566, '1987-07-13', 3000, NULL, 'HR'),
(7923, 'BROWN', 'MANAGER', 7839, '1981-08-12', 2975, NULL, 'Marketing'),
(7924, 'DAVIS', 'SALESMAN', 7698, '1981-06-21', 1600, 300, 'Operations');

select * from Employees;

/*
Most Asked Data Analyst Interview Questions 

Write an SQL query to retrieve employee details 
from each department who have a salary greater 
than the average salary in their department.

*/
select Emp_Name,Salary from Employees as e1 where
 Salary> (select Avg(Salary) from Employees e2 where e1.Department=e2.Department);
 
-- Your Task
-- Find the employee who has less than average salary accross company?

select Emp_Name,Salary,Department from Employees as e1 where
 Salary< (select Avg(Salary) from Employees e2);
 
-- SQL Challenge Day 39/50
DROP TABLE IF EXISTS amazon_products;
CREATE TABLE amazon_products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(255),
    category VARCHAR(100),
    price DECIMAL(10, 2),
    country VARCHAR(50)
);

-- Add 25+ records with real product names for the USA
INSERT INTO amazon_products (product_name, category, price, country) VALUES
('iPhone 13 Pro Max', 'Smartphones', 1099.00, 'USA'),
('Samsung Galaxy S21 Ultra', 'Smartphones', 1199.99, 'USA'),
('Google Pixel 6 Pro', 'Smartphones', 899.00, 'USA'),
('Samsung QN90A Neo QLED TV', 'TVs', 2397.99, 'USA'),
('LG OLED C1 Series', 'TVs', 1996.99, 'USA'),
('Sony Bravia XR A90J', 'TVs', 2798.00, 'USA'),
('Apple MacBook Pro 16-inch', 'Laptops', 2399.00, 'USA'),
('Dell XPS 15', 'Laptops', 1899.99, 'USA'),
('Microsoft Surface Laptop 4', 'Laptops', 1299.99, 'USA'),
('Sony WH-1000XM4 Wireless Headphones', 'Headphones', 348.00, 'USA'),
('Bose Noise Cancelling Headphones 700', 'Headphones', 379.00, 'USA'),
('Apple AirPods Pro', 'Headphones', 249.00, 'USA'),
('Samsung Odyssey G9 Gaming Monitor', 'Monitors', 1399.99, 'USA'),
('Dell S2721QS 27-inch 4K Monitor', 'Monitors', 339.99, 'USA'),
('LG 27GN950-B UltraGear Gaming Monitor', 'Monitors', 1296.99, 'USA'),
('Canon EOS R5 Mirrorless Camera', 'Cameras', 3899.00, 'USA'),
('Sony Alpha a7 III Mirrorless Camera', 'Cameras', 1998.00, 'USA'),
('Nikon Z7 II Mirrorless Camera', 'Cameras', 2996.95, 'USA'),
('Nintendo Switch', 'Gaming Consoles', 299.99, 'USA'),
('PlayStation 5', 'Gaming Consoles', 499.99, 'USA'),
('Xbox Series X', 'Gaming Consoles', 499.99, 'USA'),
('Apple Watch Series 7', 'Smartwatches', 399.00, 'USA'),
('Samsung Galaxy Watch 4', 'Smartwatches', 249.99, 'USA'),
('Fitbit Sense', 'Smartwatches', 299.95, 'USA'),
('iPhone 13 Pro Max', 'Smartphones', 1099.00, 'USA'),
('Samsung Galaxy S21 Ultra', 'Smartphones', 1199.99, 'USA'),
('Google Pixel 6 Pro', 'Smartphones', 899.00, 'USA'),
('Samsung QN90A Neo QLED TV', 'TVs', 2397.99, 'USA'),
('LG OLED C1 Series', 'TVs', 1996.99, 'USA'),
('Sony Bravia XR A90J', 'TVs', 2798.00, 'USA'),
('Apple MacBook Pro 16-inch', 'Laptops', 2399.00, 'USA'),
('Dell XPS 15', 'Laptops', 1899.99, 'USA'),
('Microsoft Surface Laptop 4', 'Laptops', 1299.99, 'USA'),
('Sony WH-1000XM4 Wireless Headphones', 'Headphones', 348.00, 'USA'),
('Bose Noise Cancelling Headphones 700', 'Headphones', 379.00, 'USA'),
('Apple AirPods Pro', 'Headphones', 249.00, 'USA'),
('Samsung Odyssey G9 Gaming Monitor', 'Monitors', 1399.99, 'USA'),
('Dell S2721QS 27-inch 4K Monitor', 'Monitors', 339.99, 'USA'),
('LG 27GN950-B UltraGear Gaming Monitor', 'Monitors', 1296.99, 'USA'),
('Canon EOS R5 Mirrorless Camera', 'Cameras', 3899.00, 'USA'),
('Sony Alpha a7 III Mirrorless Camera', 'Cameras', 1998.00, 'USA'),
('Nikon Z7 II Mirrorless Camera', 'Cameras', 2996.95, 'USA'),
('Nintendo Switch', 'Gaming Consoles', 299.99, 'USA'),
('PlayStation 5', 'Gaming Consoles', 499.99, 'USA'),
('Xbox Series X', 'Gaming Consoles', 499.99, 'USA'),
('Apple Watch Series 7', 'Smartwatches', 399.00, 'USA'),
('Samsung Galaxy Watch 4', 'Smartwatches', 249.99, 'USA'),
('Fitbit Sense', 'Smartwatches', 299.95, 'USA'),
('iPhone 13 Pro Max', 'Smartphones', 1099.00, 'USA'),
('Samsung Galaxy S21 Ultra', 'Smartphones', 1199.99, 'USA'),
('Google Pixel 6 Pro', 'Smartphones', 899.00, 'USA'),
('Samsung QN90A Neo QLED TV', 'TVs', 2397.99, 'USA'),
('LG OLED C1 Series', 'TVs', 1996.99, 'USA'),
('Sony Bravia XR A90J', 'TVs', 2798.00, 'USA'),
('Apple MacBook Pro 16-inch', 'Laptops', 2399.00, 'USA'),
('Dell XPS 15', 'Laptops', 1899.99, 'USA'),
('Microsoft Surface Laptop 4', 'Laptops', 1299.99, 'USA'),
('Sony WH-1000XM4 Wireless Headphones', 'Headphones', 348.00, 'USA');


DROP TABLE IF EXISTS return_records;
CREATE TABLE return_records (
    return_id SERIAL PRIMARY KEY,
    order_id INT,
    product_id INT,
    return_reason VARCHAR(255),
    return_date DATE
);

-- Add 10 more return records
INSERT INTO return_records (order_id, product_id, return_reason, return_date) VALUES
(1006, 7, 'Defective product', '2024-04-27'),
(1007, 9, 'Wrong color', '2024-04-29'),
(1008, 8, 'Size too small', '2024-05-01'),
(1009, 6, 'Not satisfied with quality', '2024-05-03'),
(1010, 10, 'Received wrong item', '2024-05-05'),
(1011, 12, 'Defective product', '2024-05-07'),
(1012, 11, 'Changed mind', '2024-05-09'),
(1013, 14, 'Item not needed', '2024-05-11'),
(1014, 15, 'Damaged upon arrival', '2024-05-13'),
(1015, 13, 'Wrong quantity', '2024-05-15'),
(1016, 16, 'Defective product', '2024-05-17'),
(1017, 17, 'Wrong size', '2024-05-19'),
(1018, 18, 'Received damaged', '2024-05-21'),
(1019, 19, 'Not as described', '2024-05-23'),
(1020, 20, 'Changed mind', '2024-05-25'),
(1021, 21, 'Item not needed', '2024-05-27'),
(1022, 22, 'Defective product', '2024-05-29'),
(1023, 23, 'Wrong color', '2024-05-31'),
(1024, 24, 'Received wrong item', '2024-06-02'),
(1025, 25, 'Size too small', '2024-06-04'),
(1026, 26, 'Damaged upon arrival', '2024-06-06'),
(1027, 27, 'Defective product', '2024-06-08'),
(1028, 28, 'Not satisfied with quality', '2024-06-10'),
(1029, 29, 'Wrong quantity', '2024-06-12'),
(1030, 30, 'Changed mind', '2024-06-14'),
(1031, 31, 'Item not needed', '2024-06-16'),
(1032, 32, 'Defective product', '2024-06-18'),
(1033, 33, 'Wrong size', '2024-06-20'),
(1034, 34, 'Received damaged', '2024-06-22'),
(1035, 35, 'Not as described', '2024-06-24'),
(1036, 36, 'Changed mind', '2024-06-26'),
(1037, 37, 'Item not needed', '2024-06-28'),
(1038, 38, 'Defective product', '2024-06-30'),
(1039, 39, 'Wrong color', '2024-07-02'),
(1040, 40, 'Received wrong item', '2024-07-04');

select * from amazon_products;
select * from return_records;
/*
Question:

Write a SQL query to show each product category
and its return percentage. 

return percentage = 
total_return by category
/
total_overall_return * 100

Expected Output:

Category: Name of the product category.
Return Percentage: Percentage of returns 
for each category.
*/
select category,round((count(*)/(select count(*) from return_records)*100),2)as return_percentage from return_records as r left join amazon_products as a 
on r.product_id=a.product_id
group by a.category;


-- SQL Challenge Day 40/50


DROP table if exists order_data;
-- Create the table
CREATE TABLE order_data (
    order_id SERIAL PRIMARY KEY,
    order_time TIMESTAMP,
    customer_id INT,
    total_amount DECIMAL(10, 2)
);


-- Add records

-- Add records
INSERT INTO order_data (order_time, customer_id, total_amount) VALUES
    ('2024-03-31 08:30:00', 1001, 25.50),
    ('2024-03-31 09:15:00', 1002, 32.75),
    ('2024-03-31 10:00:00', 1003, 20.00),
    ('2024-03-31 11:45:00', 1004, 18.50),
    ('2024-03-31 12:30:00', 1005, 27.80),
    ('2024-03-31 13:15:00', 1006, 35.20),
    ('2024-03-31 14:00:00', 1007, 40.00),
    ('2024-03-31 15:45:00', 1008, 22.90),
    ('2024-03-31 16:30:00', 1009, 28.75),
    ('2024-03-31 17:15:00', 1010, 30.60),
    ('2024-03-31 18:00:00', 1011, 24.95),
    ('2024-03-31 19:45:00', 1012, 38.25),
    ('2024-03-31 20:30:00', 1013, 42.80),
    ('2024-03-31 21:15:00', 1014, 26.40),
    ('2024-03-31 22:00:00', 1015, 33.10),
    ('2024-03-31 23:45:00', 1016, 20.50),
    ('2024-03-31 00:15:00', 1017, 28.75),
    ('2024-03-31 01:00:00', 1018, 18.90),
    ('2024-03-31 22:45:00', 1019, 23.25),
    ('2024-03-31 22:30:00', 1020, 30.00),
    ('2024-03-31 22:15:00', 1021, 35.80),
    ('2024-03-31 23:00:00', 1022, 38.50),
    ('2024-03-31 06:45:00', 1023, 21.20),
    ('2024-03-31 09:30:00', 1024, 27.95),
    ('2024-03-31 23:15:00', 1025, 32.70),
    ('2024-03-31 09:00:00', 1026, 25.45),
    ('2024-03-31 10:45:00', 1027, 37.80),
    ('2024-03-31 21:30:00', 1028, 40.90),
    ('2024-03-31 23:15:00', 1029, 24.60),
    ('2024-03-31 13:00:00', 1030, 31.75),
    ('2024-03-31 22:45:00', 1031, 22.50),
    ('2024-03-31 22:30:00', 1032, 30.25),
    ('2024-03-31 23:15:00', 1033, 19.80),
    ('2024-03-31 23:00:00', 1034, 24.75),
    ('2024-03-31 20:45:00', 1035, 32.50),
    ('2024-03-31 20:30:00', 1036, 38.20),
    ('2024-03-31 20:15:00', 1037, 41.75),
    ('2024-03-31 22:00:00', 1038, 23.80),
    ('2024-03-31 22:45:00', 1039, 29.95),
    ('2024-03-31 22:30:00', 1040, 31.60);

select * from order_data;

/*
Swiggy Data Analyst Interview Question:

Write a SQL query to analyze the order patterns
throughout the day, providing insights into each 
hour's total orders and their respective 
percentages of the total orders. 

The output should include the hour, total orders,
and order percentage. 
Order by % order in decending

%orders = hourly order/total_orders * 100
*/
select extract(hour from order_time) as hours ,count(*) as hour_orders,
round((count(*)/(select count(*) from order_data)*100),2) as Order_percentage
from order_data
group by extract(hour from order_time)
order by hours asc;

/*
-- Your Task
Create a new time category as Morning, After_noon, Evening and Night 
And Find total orders fall into this category
Morning < 12 O clock
After noon between 12 and 5
Evening 5 and 8
Night > 8 
*/
with cte as (
select *,
CASE 
        WHEN EXTRACT(HOUR FROM order_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM order_time) >= 12 AND EXTRACT(HOUR FROM order_time) < 17 THEN 'Afternoon'
        WHEN EXTRACT(HOUR FROM order_time) >= 17 AND EXTRACT(HOUR FROM order_time) < 20 THEN 'Evening'
        ELSE 'Night'
    END AS time_category
from order_data
)
select time_category,count(*) as category_order,(select count(*) from order_data) as total_orders,
round((count(*)/(select count(*) from order_data)*100),2) as percent
from cte
group by time_category
