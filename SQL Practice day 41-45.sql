-- Day 41/50 SQL Challenge

-- Create the user_purchases table
CREATE TABLE user_purchases (
    user_id INT,
    date DATE,
    amount_spent FLOAT,
    day_name VARCHAR(20)
);

-- Insert records into the user_purchases table
INSERT INTO user_purchases (user_id, date, amount_spent, day_name) VALUES
(1047, '2023-01-01', 288, 'Sunday'),
(1099, '2023-01-04', 803, 'Wednesday'),
(1055, '2023-01-07', 546, 'Saturday'),
(1040, '2023-01-10', 680, 'Tuesday'),
(1052, '2023-01-13', 889, 'Friday'),
(1052, '2023-01-13', 596, 'Friday'),
(1016, '2023-01-16', 960, 'Monday'),
(1023, '2023-01-17', 861, 'Tuesday'),
(1010, '2023-01-19', 758, 'Thursday'),
(1013, '2023-01-19', 346, 'Thursday'),
(1069, '2023-01-21', 541, 'Saturday'),
(1030, '2023-01-22', 175, 'Sunday'),
(1034, '2023-01-23', 707, 'Monday'),
(1019, '2023-01-25', 253, 'Wednesday'),
(1052, '2023-01-25', 868, 'Wednesday'),
(1095, '2023-01-27', 424, 'Friday'),
(1017, '2023-01-28', 755, 'Saturday'),
(1010, '2023-01-29', 615, 'Sunday'),
(1063, '2023-01-31', 534, 'Tuesday'),
(1019, '2023-02-03', 185, 'Friday'),
(1019, '2023-02-03', 995, 'Friday'),
(1092, '2023-02-06', 796, 'Monday'),
(1058, '2023-02-09', 384, 'Thursday'),
(1055, '2023-02-12', 319, 'Sunday'),
(1090, '2023-02-15', 168, 'Wednesday'),
(1090, '2023-02-18', 146, 'Saturday'),
(1062, '2023-02-21', 193, 'Tuesday'),
(1023, '2023-02-24', 259, 'Friday'),
(1023, '2023-02-24', 849, 'Friday'),
(1009, '2023-02-27', 552, 'Monday'),
(1012, '2023-03-02', 303, 'Thursday'),
(1001, '2023-03-05', 317, 'Sunday'),
(1058, '2023-03-08', 573, 'Wednesday'),
(1001, '2023-03-11', 531, 'Saturday'),
(1034, '2023-03-14', 440, 'Tuesday'),
(1096, '2023-03-17', 650, 'Friday'),
(1048, '2023-03-20', 711, 'Monday'),
(1089, '2023-03-23', 388, 'Thursday'),
(1001, '2023-03-26', 353, 'Sunday'),
(1016, '2023-03-29', 833, 'Wednesday');


/*
SQL Challenge: Friday Purchases

Scenario:
IBM wants to analyze user purchases for Fridays
in the first quarter of the year. 

Calculate the average amount users spent
per order for each Friday.

Question:
Write an SQL query to find the average amount
spent by users per order for each Friday 
in the first quarter of the year.
*/

SELECT * FROM user_purchases;


select avg(amount_spent) as average_spent,extract(week from date) as week_no,user_id,day_name from user_purchases
where extract(quarter from date)=1 and day_name='Friday' 
group by user_id,week_no;

-- SQL Challenge 42/50

-- UBER Interview Question

-- Drop the table if it exists
DROP TABLE IF EXISTS uber_ride;

-- Create the Uber ride table
CREATE TABLE uber_ride (
    ride_id SERIAL PRIMARY KEY,
    ride_timestamp TIMESTAMP,
    ride_status VARCHAR(20)  -- "ride_completed", "cancelled_by_driver" or "cancelled_by_user"
);

-- Insert sample records
INSERT INTO uber_ride (ride_timestamp, ride_status)
VALUES
    ('2024-05-09 08:30:00', 'cancelled_by_driver'),
    ('2024-05-09 09:00:00', 'cancelled_by_user'),
    ('2024-05-09 10:00:00', 'ride_completed'),
    ('2024-05-09 11:00:00', 'cancelled_by_user'),
    ('2024-05-09 12:00:00', 'cancelled_by_driver'),
    ('2024-05-09 13:00:00', 'cancelled_by_user'),
    ('2024-05-09 14:00:00', 'cancelled_by_user'),
    ('2024-05-09 15:00:00', 'cancelled_by_user'),
    ('2024-05-09 16:00:00', 'ride_completed'),
    ('2024-05-09 17:00:00', 'cancelled_by_user'),
    ('2024-05-09 18:00:00', 'ride_completed'),
    ('2024-05-09 19:00:00', 'cancelled_by_user'),
    ('2024-05-09 20:00:00', 'cancelled_by_user'),
    ('2024-05-09 21:00:00', 'cancelled_by_user'),
    ('2024-05-09 22:00:00', 'cancelled_by_driver'),
    ('2024-05-09 13:00:00', 'cancelled_by_user'),
    ('2024-05-09 14:00:00', 'cancelled_by_user'),
    ('2024-05-09 15:00:00', 'cancelled_by_user'),
    ('2024-05-09 16:00:00', 'ride_completed'),
    ('2024-05-09 17:00:00', 'cancelled_by_user'),
    ('2024-05-09 18:00:00', 'cancelled_by_driver'),
    ('2024-05-09 19:00:00', 'cancelled_by_user'),
    ('2024-05-09 20:00:00', 'cancelled_by_user'),
    ('2024-05-09 21:00:00', 'cancelled_by_user'),
    ('2024-05-09 22:00:00', 'cancelled_by_driver');

-- Check the records
SELECT * FROM uber_ride;

-- UBER Data Analyst Interview Question
/*
You are given a uber_ride table with columns
ride_id, ride_time_stamp, ride_status.
(which has information about the ride)

Find out % of ride cancelled by uber_driver

*/
-- total count of canceled by driver
-- total count of canceled ride

SELECT 
    round((SUM(CASE WHEN ride_status = 'cancelled_by_driver' THEN 1 ELSE 0 END) * 100.0 / COUNT(*)),2) AS cancellation_percentage
FROM 
    uber_ride
WHERE 
    ride_status IN ('cancelled_by_driver', 'cancelled_by_user');

-- -- Your Task is to find out how how many ride were cancelled by user in the evening 
-- hour > 17 is considered as evening 

select count(ride_status) from uber_ride
where ride_status='cancelled_by_user' and extract(hour from ride_timestamp)>17;

-- SQL Challenge 43/50

CREATE TABLE forbes_global (
    company VARCHAR(100),
    sector VARCHAR(100),
    industry VARCHAR(100),
    country VARCHAR(100),
    sales FLOAT,
    profits FLOAT,
    ranks INT
);


-- Inserting the data
insert into forbes_global
VALUES  
('Walmart', 'Consumer Discretionary', 'General Merchandisers', 'United States', 482130.0, 14694.0, 1),
('Sinopec-China Petroleum', 'Energy', 'Oil & Gas Operations', 'China', 448452.0, 7840.0, 2),
('Royal Dutch Shell', 'Energy', 'Oil & Gas Operations', 'Netherlands', 396556.0, 15340.0, 3),
('China National Petroleum', 'Energy', 'Oil & Gas Operations', 'China', 392976.0, 2837.0, 4),
('State Grid', 'Utilities', 'Electric Utilities', 'China', 387056.0, 9573.0, 5),
('Saudi Aramco', 'Energy', 'Oil & Gas Operations', 'Saudi Arabia', 355905.0, 11002.0, 6),
('Volkswagen', 'Consumer Discretionary', 'Auto & Truck Manufacturers', 'Germany', 283565.0, 17742.4, 7),
('BP', 'Energy', 'Oil & Gas Operations', 'United Kingdom', 282616.0, 3591.0, 8),
('Amazon.com', 'Consumer Discretionary', 'Internet Services and Retailing', 'United States', 280522.0, 5362.0, 9),
('Toyota Motor', 'Consumer Discretionary', 'Auto & Truck Manufacturers', 'Japan', 275288.0, 18499.3, 10),
('Apple', 'Information Technology', 'Computers, Office Equipment', 'United States', 265595.0, 55256.0, 11),
('Exxon Mobil', 'Energy', 'Oil & Gas Operations', 'United States', 263910.0, 15850.0, 12),
('Berkshire Hathaway', 'Financials', 'Diversified Financials', 'United States', 247837.0, 8971.0, 13),
('Samsung Electronics', 'Information Technology', 'Electronics', 'South Korea', 245898.0, 19783.3, 14),
('McKesson', 'Health Care', 'Health Care: Pharmacy and Other Services', 'United States', 231091.0, 5070.0, 15),
('Glencore', 'Materials', 'Diversified Metals & Mining', 'Switzerland', 219754.0, 5436.0, 16),
('UnitedHealth Group', 'Health Care', 'Health Care: Insurance and Managed Care', 'United States', 201159.0, 13650.0, 17),
('Daimler', 'Consumer Discretionary', 'Auto & Truck Manufacturers', 'Germany', 197515.0, 8245.1, 18),
('CVS Health', 'Health Care', 'Health Care: Pharmacy and Other Services', 'United States', 194579.0, 6634.0, 19),
('AT&T', 'Telecommunication Services', 'Telecommunications', 'United States', 181193.0, 13906.0, 20),
('Foxconn', 'Technology', 'Electronics', 'Taiwan', 175617.0, 4103.4, 21),
('General Motors', 'Consumer Discretionary', 'Auto & Truck Manufacturers', 'United States', 174049.0, 6710.0, 22),
('Verizon Communications', 'Telecommunication Services', 'Telecommunications', 'United States', 170756.0, 19225.0, 23),
('Total', 'Energy', 'Oil & Gas Operations', 'France', 149769.0, 7480.0, 24),
('IBM', 'Information Technology', 'Information Technology Services', 'United States', 141682.0, 6606.0, 25),
('Ford Motor', 'Consumer Discretionary', 'Auto & Truck Manufacturers', 'United States', 140545.0, 6471.0, 26),
('Hon Hai Precision Industry', 'Technology', 'Electronics', 'Taiwan', 135129.0, 4493.3, 27),
('Trafigura Group', 'Energy', 'Trading', 'Singapore', 131638.0, 975.0, 28),
('General Electric', 'Industrials', 'Diversified Industrials', 'United States', 126661.0, 5136.0, 29),
('AmerisourceBergen', 'Health Care', 'Wholesalers: Health Care', 'United States', 122848.0, 1605.5, 30),
('Fannie Mae', 'Financials', 'Diversified Financials', 'United States', 120472.0, 18418.0, 31),
('Trafigura Group', 'Energy', 'Trading', 'Switzerland', 120438.0, 975.0, 32),
('Koch Industries', 'Diversified', 'Diversified', 'United States', 115095.0, 5142.0, 33),
('Cardinal Health', 'Health Care', 'Wholesalers: Health Care', 'United States', 113982.0, 1377.0, 34),
('Alphabet', 'Technology', 'Internet Services and Retailing', 'United States', 110855.0, 18616.0, 35),
('Chevron', 'Energy', 'Oil & Gas Operations', 'United States', 110360.0, 5520.0, 36),
('Costco Wholesale', 'Consumer Discretionary', 'General Merchandisers', 'United States', 110215.0, 2115.0, 37),
('Cardinal Health', 'Health Care', 'Health Care: Pharmacy and Other Services', 'United States', 109838.0, 1718.0, 38),
('Ping An Insurance Group', 'Financials', 'Insurance', 'China', 109254.0, 2047.4, 39),
('Walgreens Boots Alliance', 'Consumer Staples', 'Food and Drug Stores', 'United States', 109026.0, 4563.0, 40),
('Costco Wholesale', 'Consumer Discretionary', 'Retailing', 'United States', 105156.0, 2115.0, 41),
('JPMorgan Chase', 'Financials', 'Diversified Financials', 'United States', 105153.0, 30615.0, 42),
('Verizon Communications', 'Telecommunication Services', 'Telecommunications', 'United States', 104887.0, 13568.0, 43),
('China Construction Bank', 'Financials', 'Banks', 'China', 104693.0, 38369.0, 44),
('China Construction Bank', 'Financials', 'Major Banks', 'China', 104692.9, 38369.2, 45),
('Trafigura Group', 'Energy', 'Trading', 'Netherlands', 103752.0, 975.0, 46),
('Exor Group', 'Financials', 'Diversified Financials', 'Netherlands', 103606.6, -611.2, 47),
('Anheuser-Busch InBev', 'Consumer Staples', 'Beverages', 'Belgium', 101541.0, 9536.0, 48),
('Bank of America', 'Financials', 'Banks', 'United States', 100264.0, 18724.0, 49),
('Bank of China', 'Financials', 'Banks', 'China', 99237.3, 28202.1, 50),
('Trafigura Group', 'Energy', 'Trading', 'Switzerland', 97296.0, 975.0, 51),
('Dell Technologies', 'Technology', 'Computers, Office Equipment', 'United States', 94477.0, 2743.0, 52),
('CVS Health', 'Health Care', 'Health Care: Insurance and Managed Care', 'United States', 94005.0, 6239.0, 53),
('Trafigura Group', 'Energy', 'Trading', 'United Kingdom', 90345.0, 975.0, 54),
('Trafigura Group', 'Energy', 'Trading', 'Switzerland', 88265.0, 975.0, 55),
('Trafigura Group', 'Energy', 'Trading', 'Netherlands', 88111.0, 975.0, 56),
('Trafigura Group', 'Energy', 'Trading', 'Switzerland', 87044.0, 975.0, 57),
('Trafigura Group', 'Energy', 'Trading', 'Switzerland', 84795.0, 975.0, 58),
('Trafigura Group', 'Energy', 'Trading', 'Switzerland', 84361.0, 975.0, 59),
('Trafigura Group', 'Energy', 'Trading', 'Switzerland', 83156.0, 975.0, 60),
('Trafigura Group', 'Energy', 'Trading', 'Switzerland', 82276.0, 975.0, 61);

/*
-- Most Profitable Companies
You are given a table called
forbes_global with columns
company, sector, industry, country, 
sales, profit, ranks

Find out each country's  
most profitable company details
*/


SELECT * FROM forbes_global;

select * from(
select *,
rank()over(partition by country order by profits desc) as rnk
from forbes_global
) as details
where rnk=1;


-- -- Your Task 
-- Find out each sector top 2 most profitable company details

select * from (
select *,
rank() over(partition by sector order by profits desc) as rnk
from forbes_global
) as details
where rnk<=2;


-- SQL Challenge 44/50

-- Create the table
CREATE TABLE house_price (
    id INT,
    state VARCHAR(255),
    city VARCHAR(255),
    street_address VARCHAR(255),
    mkt_price INT
);
-- Insert all the records
INSERT INTO house_price (id, state, city, street_address, mkt_price) VALUES
(1, 'NY', 'New York City', '66 Trout Drive', 449761),
(2, 'NY', 'New York City', 'Atwater', 277527),
(3, 'NY', 'New York City', '58 Gates Street', 268394),
(4, 'NY', 'New York City', 'Norcross', 279929),
(5, 'NY', 'New York City', '337 Shore Ave.', 151592),
(6, 'NY', 'New York City', 'Plainfield', 624531),
(7, 'NY', 'New York City', '84 Central Street', 267345),
(8, 'NY', 'New York City', 'Passaic', 88504),
(9, 'NY', 'New York City', '951 Fulton Road', 270476),
(10, 'NY', 'New York City', 'Oxon Hill', 118112),
(11, 'CA', 'Los Angeles', '692 Redwood Court', 150707),
(12, 'CA', 'Los Angeles', 'Lewiston', 463180),
(13, 'CA', 'Los Angeles', '8368 West Acacia Ave.', 538865),
(14, 'CA', 'Los Angeles', 'Pearl', 390896),
(15, 'CA', 'Los Angeles', '8206 Old Riverview Rd.', 117754),
(16, 'CA', 'Los Angeles', 'Seattle', 424588),
(17, 'CA', 'Los Angeles', '7227 Joy Ridge Rd.', 156850),
(18, 'CA', 'Los Angeles', 'Battle Ground', 643454),
(19, 'CA', 'Los Angeles', '233 Bedford Ave.', 713841),
(20, 'CA', 'Los Angeles', 'Saint Albans', 295852),
(21, 'IL', 'Chicago', '8830 Baker St.', 12944),
(22, 'IL', 'Chicago', 'Watertown', 410766),
(23, 'IL', 'Chicago', '632 Princeton St.', 160696),
(24, 'IL', 'Chicago', 'Waxhaw', 464144),
(25, 'IL', 'Chicago', '7773 Tailwater Drive', 129393),
(26, 'IL', 'Chicago', 'Bonita Springs', 174886),
(27, 'IL', 'Chicago', '31 Summerhouse Rd.', 296008),
(28, 'IL', 'Chicago', 'Middleburg', 279000),
(29, 'IL', 'Chicago', '273 Windfall Avenue', 424846),
(30, 'IL', 'Chicago', 'Graham', 592268),
(31, 'TX', 'Houston', '91 Canterbury Dr.', 632014),
(32, 'TX', 'Houston', 'Dallas', 68868),
(33, 'TX', 'Houston', '503 Elmwood St.', 454184),
(34, 'TX', 'Houston', 'Kennewick', 186280),
(35, 'TX', 'Houston', '739 Chapel Street', 334474),
(36, 'TX', 'Houston', 'San Angelo', 204460),
(37, 'TX', 'Houston', '572 Parker Dr.', 678443),
(38, 'TX', 'Houston', 'Bellmore', 401090),
(39, 'TX', 'Houston', '8653 South Oxford Street', 482214),
(40, 'TX', 'Houston', 'Butler', 330868),
(41, 'AZ', 'Phoenix', '8667 S. Joy Ridge Court', 316291),
(42, 'AZ', 'Phoenix', 'Torrance', 210392),
(43, 'AZ', 'Phoenix', '35 Harvard St.', 167502),
(44, 'AZ', 'Phoenix', 'Nutley', 327554),
(45, 'AZ', 'Phoenix', '7313 Vermont St.', 285135),
(46, 'AZ', 'Phoenix', 'Lemont', 577667),
(47, 'AZ', 'Phoenix', '8905 Buttonwood Dr.', 212301),
(48, 'AZ', 'Phoenix', 'Lafayette', 317504);

/*

Identify properites where the mkt_price of the house 
exceeds the city's average mkt_price.

*/

SELECT * FROM house_price;

select * from house_price as h1 where
h1.mkt_Price>(select avg(mkt_price) from house_price as h2 where h1.city=h2.city);


SELECT * 
FROM house_price AS h1 
WHERE h1.mkt_price > (
        SELECT AVG(mkt_price) 
        FROM house_price AS h2 
        WHERE h1.city = h2.city
    ) 
AND h1.mkt_price < (
        SELECT AVG(mkt_price) 
        FROM house_price AS h3
    );
    
-- SQL Challenge 45/50

DROP TABLE IF EXISTS orders;
-- Create Orders table
CREATE TABLE Orders (
    Order_id INT PRIMARY KEY,
    Customer_id INT,
    Order_Date DATE,
    Amount DECIMAL(10, 2)
);


DROP TABLE IF EXISTS Customers;
-- Create Customers table
CREATE TABLE Customers (
    Customer_id INT PRIMARY KEY,
    Customer_Name VARCHAR(50),
    Join_Date DATE
);

-- Insert records into Orders table
INSERT INTO Orders (Order_id, Customer_id, Order_Date, Amount)
VALUES
    (1, 1, '2024-05-01', 100),
    (2, 2, '2024-05-02', 150),
    (3, 3, '2023-12-15', 200),
    (4, 1, '2024-05-03', 120),
    (5, 2, '2024-01-20', 180),
    (6, 4, '2024-03-10', 90);

-- Insert records into Customers table
INSERT INTO Customers (Customer_id, Customer_Name, Join_Date)
VALUES
    (1, 'Alice', '2024-01-15'),
    (2, 'Bob', '2024-02-20'),
    (3, 'Charlie', '2023-12-01'),
    (4, 'David', '2024-03-01');


select * from Orders;
select * from Customers;


/*
-- Amazon Data Analyst interview 
questions for exp 1-3 year!
 
Write an SQL query to calculate the total 
order amount for each customer who joined 
in the current year. 

The output should contain Customer_Name and 
the total amount.
*/

select sum(Amount) as total_amount,o.Customer_id,join_Date from Orders as o left join Customers as c
on o.Customer_id=c.Customer_id
where extract(year from Join_Date)=extract(year from current_date)
group by o.Customer_id;

-- Your Task
-- Write a SQL query to return each and and total orders for current year
-- return month_number, total orders

Select extract(month from Order_Date) as months ,count(Order_id) as total_order 
from  Orders as o left join Customers as c
on o.Customer_id=c.Customer_id
where extract(year from Join_Date)=extract(year from current_date)
group by extract(month from Order_Date)
order by months asc;