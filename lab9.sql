create database lab9;

create table employees (
    id serial primary key,
    first_name varchar(100) not null,
    last_name varchar(100) not null,
    email varchar(100),
    salary integer not null
);

insert into employees (first_name, last_name, email, salary) values 
('john', 'doe', 'john.doe@example.com', 5000),
('jane', 'smith', 'jane.smith@example.com', 7000),
('pakita', 'brown', 'pakita.brown@example.com', 6000);

create table products (
    id serial primary key,
    name varchar(100) not null,
    category varchar(50) not null,
    price integer not null
);

insert into products (name, category, price) values 
('laptop', 'electronics', 1200),
('smartphone', 'electronics', 800),
('tablet', 'electronics', 400),
('chair', 'furniture', 150),
('table', 'furniture', 250);

-- task 1
create function increaseby10(a integer) returns integer as
$$
begin
    return a + 10;
end;
$$
language plpgsql;

select increaseby10(15);

-- task 2
create function compare_numbers(a integer, b integer)
returns text as $$
declare result text;
begin
    if a > b then
        result := 'greater';
    elsif a = b then
        result := 'equal';
    else
        result := 'lesser';
    end if;
    return result;
end;
$$ language plpgsql;

select compare_numbers(18, 20);

-- task 3
create function number_series(n integer)
returns setof integer as
$$
declare
    i integer := 1;
begin
    while i <= n loop
        return next i;
        i := i + 1;
    end loop;
end;
$$
language plpgsql;

select number_series(8);

-- task 4
create or replace function find_employee(emp_name varchar)
returns table(
    first_name varchar,
    last_name varchar,
    email varchar,
    salary integer
) as
$$
begin
    return query
    select
        employees.first_name,
        employees.last_name,
        employees.email,
        employees.salary
    from employees
    where employees.first_name = emp_name;
end;
$$
language plpgsql;

select * from find_employee('pakita');

-- task 5
create or replace function list_products(category_name varchar)
returns table(p_id integer, p_name varchar, price integer) as
$$
begin
    return query
    select id, name, price
    from products
    where category = category_name;
end;
$$
language plpgsql;

select * from list_products('electronics');

-- task 6
create or replace function calculate_bonus(salary double precision, percentage int)
returns float as
$$
begin
    return salary * (1 + (percentage::float / 100));
end;
$$
language plpgsql;

create or replace function update_salary(emp_name varchar(50), percentage int)
returns float as
$$
declare
    current_sal float;
    bonus float;
begin
    select salary into current_sal
    from employees
    where first_name = emp_name;

    bonus = calculate_bonus(current_sal, percentage);

    return bonus;
end;
$$
language plpgsql;

select calculate_bonus(300000, 50);

-- task 7
create or replace function complex_calculation(num integer, str varchar)
returns text as
$$
declare
    numeric_result integer;
    string_result varchar;
begin
    numeric_result := num * num;

    string_result := 'hello, ' || str || '!';

    return 'numeric result: ' || numeric_result || ', message: ' || string_result;
end;
$$
language plpgsql;

select complex_calculation(5, 'world');
