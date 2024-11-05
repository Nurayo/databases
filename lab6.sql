drop database if exists lab6;
CREATE DATABASE lab6;
drop table if exists locations, departments, employees;

create table locations (
    location_id serial primary key,
    street_address varchar(25),
    postal_code varchar(12),
    city varchar(30),
    state_province varchar(12)
);

create table departments (
    department_id serial primary key,
    department_name varchar(50) unique,
    budget integer,
    location_id integer references locations(location_id)
);

create table employees (
    employee_id serial primary key,
    first_name varchar(50),
    last_name varchar(50),
    email varchar(50),
    phone_number varchar(20),
    salary integer,
    department_id integer references departments(department_id)
);

insert into locations (street_address, postal_code, city, state_province)
values ('123 Elm St', '12345', 'Metropolis', 'State A'),
       ('456 Oak St', '67890', 'Gotham', 'State B');

insert into departments (department_name, budget, location_id)
values ('IT', 500000, 1),
       ('HR', 200000, 2),
       ('Marketing', 300000, 1);

insert into employees (first_name, last_name, email, phone_number, salary, department_id)
values ('Alice', 'Smith', 'alice@example.com', '555-0100', 60000, 1),
       ('Bob', 'Brown', 'bob@example.com', '555-0101', 50000, 2),
       ('Charlie', 'Davis', 'charlie@example.com', '555-0102', 55000, null);

select e.first_name, e.last_name, e.department_id, d.department_name
from employees e
join departments d on e.department_id = d.department_id;

select e.first_name, e.last_name, e.department_id, d.department_name
from employees e
join departments d on e.department_id = d.department_id
where e.department_id in (80, 40);

select e.first_name, e.last_name, d.department_name, l.city, l.state_province
from employees e
join departments d on e.department_id = d.department_id
join locations l on d.location_id = l.location_id;

select d.department_name, e.first_name, e.last_name
from departments d
left join employees e on d.department_id = e.department_id;

select e.first_name, e.last_name, e.department_id, d.department_name
from employees e
left join departments d on e.department_id = d.department_id;
