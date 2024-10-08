drop database if exists lab4;
create database lab4;
drop table if exists WAREHOUSES;
drop table if exists BOXES;
create table WAREHOUSES(
    code integer primary key,
    location varchar(255),
    capacity integer
);
create table BOXES(
    code char(4) primary key,
    contents varchar(255),
    value real,
    warehouse integer,
    foreign key (warehouse) references WAREHOUSES(code)
);

INSERT INTO Warehouses (code, location, capacity) VALUES
(1, 'Chicago', 3),
(2, 'Chicago', 4),
(3, 'New York', 7),
(4, 'Los Angeles', 2),
(5, 'San Francisco', 8);

INSERT INTO Boxes (code, contents, value, warehouse) VALUES
('0MN7', 'Rocks', 180, 3),
('4H8P', 'Rocks', 250, 1),
('4RT3', 'Scissors', 190, 4),
('7G3H', 'Rocks', 200, 1),
('8JN6', 'Papers', 75, 1),
('8Y6U', 'Papers', 50, 3),
('9J6F', 'Papers', 175, 2),
('LL08', 'Rocks', 140, 4),
('P0H6', 'Scissors', 125, 1),
('P2T6', 'Scissors', 150, 2),
('TU55', 'Papers', 90, 5);

select * from WAREHOUSES;
select * from boxes where value > 150;

select distinct contents from boxes;

select warehouse, COUNT(*) as box_count from boxes group by warehouse;
select warehouse, COUNT(*) as number_of_boxes from boxes group by warehouse having count(*) > 2;

insert into WAREHOUSES (code, location, capacity) values
(6, 'New York', 3);

insert into BOXES (code, contents, value, warehouse) values
('H5RT', 'Papers', 200, 2);

update BOXES set value = value * 0.85 where code = (select code from (
        select code from BOXES order by value desc limit 3) as subquery order by value asc limit 1);

delete from boxes where value < 150;

delete from BOXES where warehouse in (select code from WAREHOUSES where location = 'New York')
RETURNING *;
