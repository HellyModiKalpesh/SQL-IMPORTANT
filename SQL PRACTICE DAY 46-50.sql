-- SQL Challenge 46/50

DROP TABLE IF EXISTS orders;
-- Create table
CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount FLOAT
);

-- Insert records
INSERT INTO orders (customer_id, order_date, total_amount)
VALUES
    (1001, '2024-01-01', 120.25),
    (1002, '2024-01-03', 80.99),
    (1003, '2024-01-05', 160.00),
    (1004, '2024-01-07', 95.50),
    (1001, '2024-02-09', 70.75),
    (1002, '2024-02-11', 220.00),
    (1003, '2024-02-13', 130.50),
    (1004, '2024-02-15', 70.25),
    (1001, '2024-02-17', 60.75),
    (1002, '2024-03-19', 180.99),
    (1003, '2024-03-21', 140.00),
    (1004, '2024-03-23', 110.50),
    (1001, '2024-03-25', 90.25),
    (1002, '2024-03-27', 200.00),
    (1003, '2024-03-29', 160.50),
    (1004, '2024-03-31', 120.75),
    (1001, '2024-03-02', 130.25),
    (1002, '2024-03-04', 90.99),
    (1003, '2024-03-06', 170.00),
    (1004, '2024-04-08', 105.50),
    (1001, '2024-04-10', 80.75),
    (1002, '2024-04-12', 240.00),
    (1003, '2024-04-14', 150.50),
    (1004, '2024-04-16', 80.25),
    (1001, '2024-04-18', 70.75);

select * from orders;

/*
-- Amazon Data Analyst Interview Question

Calculate the running total of orders for each
customer. 

Return the customer ID, order date, 
total amount of each order, and the 
cumulative total of orders for each customer
sorted by customer ID and order date.
*/
select *,
sum(total_amount) over(partition by customer_id order by order_date) as cum_sums
from orders;

-- Find each customer_id and revenue collected from them in each month

select customer_id,sum(total_amount) as revenue ,extract(month from order_date) as months 
from orders 
group by customer_id,months
order by months asc;

-- SQL Challenge 47/50

DROP TABLE IF EXISTS inventory;
CREATE TABLE inventory (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(100),
    quantity INT,
    price_per_unit FLOAT
);


INSERT INTO inventory (product_name, quantity, price_per_unit)
VALUES
    ('Laptop', 20, 999.99),
    ('Smartphone', 15, 699.99),
    ('Tablet', 8, 399.99),
    ('Headphones', 25, 149.99),
    ('Mouse', 30, 29.99),
    ('Wireless Earbuds', 12, 79.99),
    ('Portable Charger', 10, 49.99),
    ('Bluetooth Speaker', 18, 129.99),
    ('Fitness Tracker', 7, 89.99),
    ('External Hard Drive', 9, 149.99),
    ('Gaming Mouse', 14, 59.99),
    ('USB-C Cable', 22, 19.99),
    ('Smart Watch', 6, 199.99),
    ('Desk Lamp', 11, 34.99),
    ('Power Bank', 16, 39.99),
    ('Wireless Mouse', 13, 29.99),
    ('Bluetooth Headset', 20, 59.99),
    ('MicroSD Card', 5, 24.99),
    ('USB Flash Drive', 8, 14.99),
    ('HDMI Cable', 17, 9.99);

select * from inventory;
/*
Question:
Write an SQL query to display inventory details 
including the product name, quantity in stock, 
remaining stock level ('Medium' if quantity is
more than 10, 'Low' otherwise), and supplier ID. 

Assume each product has a unique 
supplier ID associated with it.
*/

select *,
case when quantity>10 then "Medium" else "Low" end as remaining_stock_level,
product_id as supplier_id
from inventory;

-- SQL Challenge 48/50

DROP TABlE IF EXISTS Customers;
DROP TABlE IF EXISTS Orders;


CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(50),
    City VARCHAR(50),
    Country VARCHAR(50)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    TotalAmount DECIMAL(10,2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Insert records into the 'Customers' table
INSERT INTO Customers (CustomerID, CustomerName, City, Country) 
VALUES 
(1, 'John Doe', 'New York', 'USA'),
(2, 'Jane Smith', 'Los Angeles', 'USA'),
(3, 'Michael Johnson', 'Chicago', 'USA'),
(4, 'Emily Brown', 'Houston', 'USA');

-- Insert records into the 'Orders' table
INSERT INTO Orders (OrderID, CustomerID, OrderDate, TotalAmount) 
VALUES 
(101, 1, '2024-05-10', 150.00),
(102, 2, '2024-05-11', 200.00),
(103, 1, '2024-05-12', 100.00),
(104, 3, '2024-05-13', 300.00);


select * from Customers;
select * from Orders;
/*
-- Question

Write an SQL query to retrive 
customer details along with their total order amounts
(if any). 
    
Include the customer's name, city, country, and total order amount. 
    
If a customer hasn't placed any orders, 
display 'NULL' for the total order amount."

*/

select c.*,
sum(o.TotalAmount) as total
from Customers as c 
left join 
Orders as o
on c.CustomerID=o.CustomerID
group by 1;


-- SQL Challenge 49/50

DROP TABLE IF EXISTS orders;
-- Create table for orders
CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    order_date DATE
);

-- Insert sample records for orders
INSERT INTO orders (order_date)
VALUES
    ('2024-05-01'),
    ('2024-05-01'),
    ('2024-05-01'),
    ('2024-05-02'),
    ('2024-05-02'),
    ('2024-05-02'),
    ('2024-05-03'),
    ('2024-05-03'),
    ('2024-05-03'),
    ('2024-05-03'),
    ('2024-05-03'),
    ('2024-05-04'),
    ('2024-05-04'),
    ('2024-05-04'),
    ('2024-05-04'),
    ('2024-05-04'),
    ('2024-05-05'),
    ('2024-05-05'),
    ('2024-05-05'),
    ('2024-05-05'),
    ('2024-05-06'),
    ('2024-05-06'),
    ('2024-05-06'),
    ('2024-05-06'),
    ('2024-05-06');

-- Display the records to verify


/*
-- Question:

Identify the busiest day for orders along 
with the total number of orders placed on that day. 
*/

SELECT * FROM orders;

select count(*) as no_of_orders,order_date,extract(day from order_date) as days
from orders
group by order_date
order by no_of_orders desc
limit 1;

-- SQL Challenge 50/50

DROP TABLE IF EXISTS sellers;
DROP TABLE IF EXISTS orders;
-- Create table for sellers
CREATE TABLE sellers (
    seller_id SERIAL PRIMARY KEY,
    seller_name VARCHAR(100) NOT NULL
);

-- Insert sample records into the sellers table
INSERT INTO sellers (seller_name)
VALUES 
    ('Seller A'),
    ('Seller B'),
    ('Seller C');

-- Create table for orders
CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    seller_id INT REFERENCES sellers(seller_id),
    product_id INT,
    category VARCHAR(50),
    quantity INT,
    price_per_unit FLOAT
);

-- Insert sample records into the orders table
INSERT INTO orders (seller_id, product_id, category, quantity, price_per_unit)
VALUES 
    (1, 1, 'Electronics', 2, 999.99),
    (1, 2, 'Electronics', 3, 699.99),
    (2, 3, 'Home & Kitchen', 1, 49.99),
    (2, 4, 'Home & Kitchen', 2, 79.99),
    (2, 5, 'Electronics', 1, 29.99),
    (3, 1, 'Electronics', 2, 999.99),
    (3, 4, 'Home & Kitchen', 1, 79.99),
    (1, 3, 'Home & Kitchen', 2, 49.99),
    (2, 1, 'Electronics', 1, 999.99),
    (3, 2, 'Electronics', 1, 699.99),
    (1, 4, 'Home & Kitchen', 3, 79.99),
    (2, 2, 'Electronics', 2, 699.99),
    (3, 3, 'Home & Kitchen', 1, 49.99),
    (1, 5, 'Electronics', 2, 29.99),
    (2, 4, 'Home & Kitchen', 1, 79.99),
    (3, 1, 'Electronics', 1, 999.99),
    (1, 2, 'Electronics', 1, 699.99),
    (2, 3, 'Home & Kitchen', 2, 49.99),
    (3, 5, 'Electronics', 1, 29.99),
    (1, 3, 'Home & Kitchen', 1, 49.99),
    (2, 1, 'Electronics', 3, 999.99),
    (3, 2, 'Electronics', 2, 699.99),
    (1, 4, 'Home & Kitchen', 1, 79.99),
    (2, 2, 'Electronics', 1, 699.99),
    (3, 3, 'Home & Kitchen', 3, 49.99),
    (1, 5, 'Electronics', 1, 29.99);

select * from sellers;
select * from orders;

/*

Write an SQL query to find each seller's 
revenue from each category and each product.

return seller_name, total_revenue in each 
product inside each category

*/

select o.seller_id,sum(price_per_unit*quantity) as revenue,category,product_id from orders as o left join sellers as s
on o.seller_id=s.seller_id
group by o.seller_id,category,product_id
order by 1,3,4;