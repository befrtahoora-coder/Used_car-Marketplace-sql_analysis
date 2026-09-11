CREATE DATABASE  kavak_case_study;
USE kavak_case_study;
-- ------------------------------------------------------------
-- branches: the four dealership locations
-- ------------------------------------------------------------
CREATE TABLE branches (
    branch_id   INT PRIMARY KEY,
    branch_name VARCHAR(50),
    city        VARCHAR(50)
);
- ------------------------------------------------------------
-- salesreps: staff, each tied to one branch
-- ------------------------------------------------------------
Create table salesreps (
rep_id int primary key ,
rep_name varchar (100),
branch_id INT,
    FOREIGN KEY (branch_id) REFERENCES branches(branch_id)
);
-- ------------------------------------------------------------
-- cars: inventory, each tied to one branch
-- ------------------------------------------------------------
CREATE TABLE cars (
    car_id      INT PRIMARY KEY,
    brand       VARCHAR(50),
    model       VARCHAR(50),
    year        INT,
    cost_price  DECIMAL(10,2),
    list_price  DECIMAL(10,2),
    branch_id   INT,
    FOREIGN KEY (branch_id) REFERENCES branches(branch_id)
);
-- ------------------------------------------------------------
-- sales: transactions — NOT every car has a matching sale row
-- ------------------------------------------------------------
 CREATE TABLE sales (
sale_id int primary key,
car_id int,
rep_id int,
sale_date date,
 sale_price DECIMAL(10,2), 
 month      VARCHAR(10),
 FOREIGN key (car_id) REFERENCES Cars (car_id),
  FOREIGN KEY (rep_id) REFERENCES salesreps (rep_id)
 ); 

INSERT INTO sales (sale_id, car_id, rep_id, sale_date, sale_price, month) VALUES
(1,1,1,'2026-01-17',89126,'Jan'),
(2,2,1,'2026-06-28',46042,'Jun'),
(3,3,1,'2026-05-20',61761,'May'),
(4,4,2,'2026-03-07',82665,'Mar'),
(5,5,2,'2026-02-14',55234,'Feb'),
(6,6,1,'2026-04-03',72891,'Apr'),
(7,7,2,'2026-01-22',48103,'Jan'),
(8,8,1,'2026-06-11',91247,'Jun'),
(9,9,2,'2026-03-19',63548,'Mar'),
(10,10,1,'2026-05-08',79432,'May'),
(11,11,3,'2026-02-25',44817,'Feb'),
(12,12,4,'2026-01-14',58293,'Jan'),
(13,13,3,'2026-04-17',87654,'Apr'),
(14,14,4,'2026-06-02',51436,'Jun'),
(15,15,3,'2026-03-28',69821,'Mar'),
(16,16,4,'2026-05-15',93412,'May'),
(17,17,3,'2026-01-09',47265,'Jan'),
(18,18,4,'2026-02-18',62947,'Feb'),
(19,19,3,'2026-06-24',78534,'Jun'),
(20,20,4,'2026-04-11',55678,'Apr'),
(21,21,5,'2026-01-28',84321,'Jan'),
(22,22,6,'2026-03-14',49876,'Mar'),
(23,23,5,'2026-05-22',71243,'May'),
(24,24,6,'2026-02-07',58967,'Feb'),
(25,25,5,'2026-04-29',92134,'Apr'),
(26,26,6,'2026-06-16',46789,'Jun'),
(27,27,5,'2026-01-05',67432,'Jan'),
(28,28,6,'2026-03-31',81567,'Mar'),
(29,29,5,'2026-05-03',53214,'May'),
(30,30,6,'2026-02-22',74896,'Feb'),
(31,31,7,'2026-04-08',88543,'Apr'),
(32,32,8,'2026-06-19',52167,'Jun'),
(33,33,7,'2026-01-31',63789,'Jan'),
(34,34,8,'2026-03-06',79234,'Mar'),
(35,35,7,'2026-05-27',45678,'May'),
(36,36,8,'2026-02-13',91823,'Feb'),
(37,37,7,'2026-04-24',57341,'Apr'),
(38,38,8,'2026-06-07',72956,'Jun'),
(39,39,7,'2026-01-16',84217,'Jan'),
(40,40,8,'2026-03-23',49563,'Mar'),
(41,41,7,'2026-05-10',66784,'May'),
(42,42,8,'2026-02-28',78123,'Feb'),
(43,43,7,'2026-04-15',53897,'Apr'),
(44,44,8,'2026-06-30',87432,'Jun'),
(45,45,7,'2026-01-24',61245,'Jan'),
(46,47,8,'2026-03-17',74563,'Mar'),
(47,49,7,'2026-05-06',48912,'May'),
(48,51,8,'2026-02-09',83247,'Feb'),
(49,54,7,'2026-04-21',59876,'Apr'),
(50,57,8,'2026-06-13',71534,'Jun');
-- query questions begin ---
-- Q1
select * from cars where  brand="Toyota";
-- Q2
Select * from cars where list_price > 80000 ;
-- Q3 
SELECT branch_id, COUNT(*) AS total_cars
FROM cars
GROUP BY branch_id;

-- Q4 
SELECT * FROM cars
ORDER BY list_price DESC
LIMIT 5;
-- Q5 
SELECT COUNT(*) AS total_sales FROM sales;
-- Q6 
SELECT SUM(sale_price) AS total_revenue FROM sales;
-- Q7 
SELECT month, AVG(sale_price) AS avg_sale_price
FROM sales
GROUP BY month;
-- Q8
SELECT c.brand, s.sale_price
FROM cars c
INNER JOIN sales s ON c.car_id = s.car_id;
 -- Q9
SELECT c.*
FROM cars c
LEFT JOIN sales s ON c.car_id = s.car_id
WHERE s.sale_id IS NULL;
-- Q10 
SELECT c.brand, SUM(s.sale_price) AS total_revenue
FROM cars c
INNER JOIN sales s ON c.car_id = s.car_id
GROUP BY c.brand;

-- Q 11 
SELECT c.car_id, c.brand, s.sale_price - c.cost_price AS profit
FROM 
cars c INNER JOIN sales s ON c.car_id = s.car_id;
-- Q12
SELECT car_id, brand, list_price,
  CASE
    WHEN list_price < 50000 THEN 'Budget'
    WHEN list_price BETWEEN 50000 AND 90000 THEN 'Mid'
    ELSE 'Premium'
  END 
  AS price_tier
FROM cars;

-- Q13
SELECT b.branch_name, s.month, SUM(s.sale_price) AS total_revenue
FROM 
sales s INNER JOIN cars c ON s.car_id = c.car_id
INNER JOIN branches b ON c.branch_id = b.branch_id
GROUP BY b.branch_name, s.month;
-- Q14
SELECT r.rep_name, SUM(s.sale_price) AS total_revenue
FROM 
sales s INNER JOIN salesreps r ON s.rep_id = r.rep_id
GROUP BY r.rep_name
ORDER BY total_revenue DESC
LIMIT 1;
-- Q15
SELECT b.branch_name, SUM(s.sale_price) AS total_revenue
FROM sales s
INNER JOIN cars c ON s.car_id = c.car_id
INNER JOIN branches b ON c.branch_id = b.branch_id
GROUP BY b.branch_name
HAVING SUM(s.sale_price) > 500000;







