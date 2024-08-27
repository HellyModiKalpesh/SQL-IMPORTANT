-- 17/30 SQL Challenge

-- Zomato Business Analyst interview question 

CREATE TABLE order_details (
    order_id INT,
    del_partner VARCHAR(255),
    predicted_time TIMESTAMP,
    delivery_time TIMESTAMP
);


INSERT INTO order_details (order_id, del_partner, predicted_time, delivery_time) 
VALUES 
    (11, 'Partner C', '2024-02-29 11:30:00', '2024-02-29 12:00:00'),
    (12, 'Partner A', '2024-02-29 10:45:00', '2024-02-29 11:30:00'),
    (13, 'Partner B', '2024-02-29 09:00:00', '2024-02-29 09:45:00'),
    (14, 'Partner A', '2024-02-29 12:15:00', '2024-02-29 13:00:00'),
    (15, 'Partner C', '2024-02-29 13:30:00', '2024-02-29 14:15:00'),
    (16, 'Partner B', '2024-02-29 14:45:00', '2024-02-29 15:30:00'),
    (17, 'Partner A', '2024-02-29 16:00:00', '2024-02-29 16:45:00'),
    (18, 'Partner B', '2024-02-29 17:15:00', '2024-02-29 18:00:00'),
    (19, 'Partner C', '2024-02-29 18:30:00', '2024-02-29 19:15:00');


/*
-- How many delayed orders does each delivery partner have, 
considering the predicted delivery time and the actual delivery time?
*/

select del_partner,
sum(case when delivery_time>predicted_time then 1 else 0 end) as delay
 from order_details 
 group by del_partner
 
 
-- 18/30 SQL Challenge

-- SWIGGY BA Interview questions 


-- Create the Table
CREATE TABLE restaurant_orders (
    city VARCHAR(50),
    restaurant_id INT,
    order_id INT,
    order_date DATE
);


-- Insert Records
INSERT INTO restaurant_orders (city, restaurant_id, order_id, order_date)
VALUES
    ('Delhi', 101, 1, '2021-09-05'),
    ('Bangalore', 102, 12, '2021-09-08'),
    ('Bangalore', 102, 13, '2021-09-08'),
    ('Bangalore', 102, 14, '2021-09-08'),
    ('Mumbai', 103, 3, '2021-09-10'),
    ('Mumbai', 103, 30, '2021-09-10'),
    ('Chennai', 104, 4, '2021-09-15'),
    ('Delhi', 105, 5, '2021-09-20'),
    ('Bangalore', 106, 6, '2021-09-25'),
    ('Mumbai', 107, 7, '2021-09-28'),
    ('Chennai', 108, 8, '2021-09-30'),
    ('Delhi', 109, 9, '2021-10-05'),
    ('Bangalore', 110, 10, '2021-10-08'),
    ('Mumbai', 111, 11, '2021-10-10'),
    ('Chennai', 112, 12, '2021-10-15'),
    ('Kolkata', 113, 13, '2021-10-20'),
    ('Hyderabad', 114, 14, '2021-10-25'),
    ('Pune', 115, 15, '2021-10-28'),
    ('Jaipur', 116, 16, '2021-10-30');

/*
Question:

Which metro city had the highest number of restaurant orders in September 2021?

Write the SQL query to retrieve the city name and the total count of orders, 
ordered by the total count of orders in descending order.

-- Note metro cites are 'Delhi', 'Mumbai', 'Bangalore', 'Hyderabad'
*/
select city,
count(order_id) as order_count
 from restaurant_orders
 where city in ('Delhi','Mumbai','Bangalore','Hyderabad') 
AND order_date BETWEEN '2021-09-01' AND '2021-09-30'
group by city
order by order_count desc
limit 1



-- Google Interview Question for DA

CREATE TABLE student_names(
    student_id INT,
    name VARCHAR(50)
);

-- Insert the records
INSERT INTO student_names (student_id, name) VALUES
(1, 'RAM'),
(2, 'ROBERT'),
(3, 'ROHIM'),
(4, 'RAM'),
(5, 'ROBERT');

select * from student_names;

-- Question 
-- Get the count of distint student that are not unique 

select name,count(*) as no_count
from student_names
group by name
having count(*)=1

