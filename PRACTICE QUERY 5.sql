-- 28/30 Days SQL Challenge!

DROP TABLE IF EXISTS orders;

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    seller_id INT,
    sale_amount DECIMAL(10, 2)
);


DROP TABLE IF EXISTS returns;

CREATE TABLE returns (
    return_id INT PRIMARY KEY,
    seller_id INT,
    return_quantity INT
);


INSERT INTO orders (order_id, seller_id, sale_amount) VALUES
(1, 101, 1500.00),
(2, 102, 2200.00),
(3, 103, 1800.00),
(4, 104, 2500.00),
(5, 107, 1900.00),
(6, 106, 2100.00),
(7, 107, 2400.00),
(8, 107, 1700.00),
(9, 108, 2000.00),
(10, 107, 2300.00),
(11, 103, 2600.00),
(12, 102, 2900.00),
(13, 101, 3100.00),
(14, 101, 2800.00),
(15, 101, 3300.00),
(16, 106, 2700.00),
(17, 101, 3000.00),
(18, 108, 3200.00),
(19, 107, 3400.00),
(20, 106, 3500.00),
(21, 101, 3600.00),
(22, 102, 3700.00),
(23, 103, 3800.00),
(24, 102, 3900.00),
(25, 105, 4000.00);

INSERT INTO returns (return_id, seller_id, return_quantity) VALUES
(1, 101, 10),
(2, 102, 5),
(3, 103, 8),
(4, 104, 3),
(5, 105, 12),
(6, 106, 6),
(7, 107, 4),
(8, 108, 9);


/*
-- Amazon DS Interview Question?

-- Given two tables, orders and return, containing sales and returns data for Amazon's 

write a SQL query to find the top 3 sellers with the highest sales amount 
but the lowest lowest return qty. 

*/
select * from orders;
select * from returns;

 with cte1 as (
 select seller_id,
 sum(sale_amount) as total_sales
 from orders 
 group by seller_id
 ),
 cte2 as (
 select seller_id,
 sum(return_quantity) as total_return
 from returns
 group by seller_id
 )
 select cte1.seller_id,total_sales,total_return from cte1 left join cte2 
 on cte1.seller_id=cte2.seller_id
 order by total_sales desc ,total_return asc
 limit 3
 
 
 -- 29/30 Days SQL Challenge

DROP TABLE IF EXISTS Sales;
-- Create Sales table
CREATE TABLE Sales (
    sale_id INT,
    product_id INT,
    year INT,
    quantity INT,
    price INT
);
-- Insert sample records into Sales table
INSERT INTO Sales (sale_id, product_id, year, quantity, price) 
VALUES
(1, 100, 2008, 10, 5000),
(2, 100, 2009, 12, 5000),
(7, 200, 2011, 15, 9000),
(3, 100, 2010, 8, 5500),
(4, 100, 2011, 15, 4800),
(5, 200, 2013, 20, 8500),
(6, 200, 2006, 18, 9200),
(8, 300, 2012, 25, 7500),
(9, 300, 2009, 30, 7200),
(10, 300, 2013, 22, 6800);


/*
-- Walmart Data Analyst Interview Question

Write a solution to select the product id, year, quantity, 
and price for the first year of every product sold.
*/

with cte1 as (
select sale_id,product_id,year,quantity,price,
row_number() over(partition by product_id order by year asc) as ranks
from Sales
)
select sale_id,product_id,year,quantity,price
from cte1 where ranks=1;

-- 30/30 

CREATE TABLE Songs (
    song_id INT PRIMARY KEY,
    song_name VARCHAR(255),
    artist_name VARCHAR(255)
);

CREATE TABLE Listens (
    listen_id INT PRIMARY KEY,
    user_id INT,
    song_id INT,
    listen_date DATE,
    FOREIGN KEY (song_id) REFERENCES Songs(song_id)
);


-- Inserting records into the Songs table
INSERT INTO Songs (song_id, song_name, artist_name) VALUES
(1, 'Song A', 'Artist X'),
(2, 'Song B', 'Artist Y'),
(3, 'Song C', 'Artist Z'),
(4, 'Song D', 'Artist X'),
(5, 'Song E', 'Artist Y'),
(6, 'Song F', 'Artist Z'),
(7, 'Song G', 'Artist X'),
(8, 'Song H', 'Artist Y'),
(9, 'Song I', 'Artist Z'),
(10, 'Song J', 'Artist X');

-- Inserting records into the Listens table
INSERT INTO Listens (listen_id, user_id, song_id, listen_date) VALUES
(1, 101, 1, '2024-03-22'),
(2, 102, 1, '2024-03-22'),
(3, 103, 2, '2024-03-22'),
(4, 104, 2, '2024-03-22'),
(5, 105, 2, '2024-03-22'),
(6, 106, 3, '2024-03-22'),
(7, 107, 4, '2024-03-22'),
(8, 108, 5, '2024-03-22'),
(9, 109, 6, '2024-03-22'),
(10, 110, 7, '2024-03-22'),
(11, 111, 7, '2024-03-22'),
(12, 112, 8, '2024-03-22'),
(13, 113, 8, '2024-03-22'),
(14, 114, 8, '2024-03-22'),
(15, 115, 9, '2024-03-22'),
(16, 116, 9, '2024-03-22'),
(17, 117, 10, '2024-03-22'),
(18, 118, 10, '2024-03-22'),
(19, 119, 10, '2024-03-22'),
(20, 120, 10, '2024-03-22');


select * from Songs;
select * from Listens


/*

Spotify Data Analyst Interview Questions
Question:
Write a SQL query to find the top 10 most popular songs by total number of listens. 
You have two tables: Songs (containing song_id, song_name, 
and artist_name) and Listens (containing listen_id, user_id, song_id, and listen_date).

*/






