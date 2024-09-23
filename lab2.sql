drop database if exists lab2;

create database lab2;

drop table if exists countries cascade;

create table countries(
    country_id serial primary key,
    country_name varchar(100),
    region_id integer,
    population integer
);

insert into countries (country_id, country_name, region_id, population)
values(1, 'China', 5, 891000);

insert into  countries (country_id, country_name)
values (2, 'Turkey');

insert into countries(country_id, country_name, region_id, population)
values(3,'USA', null, 1000000);

select * from countries;

insert into countries (country_name, region_id, population)
values
    ('China', 5, 891000),
    ('Turkey'),
    ('USA',null, 1000000);


alter table countries
alter column country_name
set default 'Kazakhstan';

insert into countries(region_id, population)
values(3, 1500000);

insert into countries default values;

create table countries_new(like countries including all);

insert into countries_new
select * from countries;

update countries
set region_id = 1
where region_id is null;

select
    country_name,
    population * 1.1 as "New Population"
from countries;

delete from countries
       where population < 100000
       returning *;

delete from countries_new
where country_id in(select country_id from countries)
returning *;

delete from countries returning *;
