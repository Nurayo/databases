create database lab10;
CREATE TABLE Books (
    book_id INT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    author VARCHAR(255) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    quantity INT NOT NULL);

INSERT INTO Books (book_id, title, author, price, quantity)
VALUES
(1, 'Database 101', 'A. Smith', 40.00, 10),
(2, 'Learn SQL', 'B. Johnson', 35.00, 15),
(3, 'Advanced DB', 'C. Lee', 50.00, 5);

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL);

INSERT INTO Customers (customer_id, name, email)
VALUES
(101, 'John Doe', 'johndoe@example.com'),
(102, 'Jane Doe', 'janedoe@example.com');

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    book_id INT NOT NULL,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    quantity INT NOT NULL,
    FOREIGN KEY (book_id) REFERENCES Books(book_id),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id));

begin;
insert into Orders (order_id, book_id, customer_id, order_date, quantity)
values (1, 1, 101, current_date, 2);
update Books
set quantity = quantity - 2
where book_id = 1;
commit;

begin;
select quantity
from Books
where book_id = 3;
insert into Orders (order_id, book_id, customer_id, order_date, quantity)
values (2, 3, 102, current_date, 10);
update Books
set quantity = quantity - 10
where book_id = 3;
rollback;
commit;

begin transaction isolation level read committed;
update Books
set price = 45.00
where book_id = 2;
select price
from Books
where book_id = 2;
commit;

begin transaction isolation level read committed;
select price
from Books
where book_id = 2;
commit;


begin;
update Customers
set email = 'newemail@example.com'
where customer_id = 101;
commit;

select *
from Customers
where customer_id = 101;
