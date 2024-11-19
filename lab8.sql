drop database if exists lab8;
drop table if exists salesman, customers, orders;
create database lab8;

CREATE TABLE salesman (
    salesman_id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    city VARCHAR(50)
);

CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    city VARCHAR(50),
    grade INTEGER
);

CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INTEGER REFERENCES customers(customer_id),
    salesman_id INTEGER REFERENCES salesman(salesman_id),
    order_date DATE,
    amount DECIMAL(10, 2)
);

create role junior_dev login;

create view new_york_salesmen as
select *
from salesman
where city = 'New York';

CREATE VIEW order_details AS
SELECT o.order_id, o.order_date, o.amount, s.name AS salesman_name, c.name AS customer_name
FROM orders o
JOIN salesman s ON o.salesman_id = s.salesman_id
JOIN customers c ON o.customer_id = c.customer_id;

grant all privileges on order_details to junior_dev;

CREATE VIEW top_customers AS
SELECT *
FROM customers
WHERE grade = (SELECT MAX(grade) FROM customers);

grant select on top_customers to junior_dev;

CREATE VIEW salesman_count_by_city AS
SELECT city, COUNT(*) AS salesman_count
FROM salesman
GROUP BY city;

CREATE VIEW salesmen_with_multiple_customers AS
SELECT s.name AS salesman_name, COUNT(c.customer_id) AS customer_count
FROM salesman s
JOIN customers c ON s.salesman_id = c.grade
GROUP BY s.name
HAVING COUNT(c.customer_id) > 1;

create role intern;
grant junior_dev to intern;
