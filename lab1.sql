create database lab1;

CREATE TABLE users(
    id SERIAL ,
    firstname VARCHAR(50),
    lastname VARCHAR(50)
);
ALTER TABLE users
ADD isadmin INT ;

ALTER TABLE users
ALTER COLUMN isadmin DROP DEFAULT;

ALTER TABLE users
ALTER COLUMN isadmin TYPE BOOLEAN USING( isadmin::BOOLEAN);

ALTER TABLE users
ALTER COLUMN isadmin SET DEFAULT false;

ALTER TABLE users
ADD PRIMARY KEY (id);

CREATE TABLE tasks(
    id SERIAL,
    name VARCHAR(50),
    user_id INT
);

DROP TABLE tasks;
DROP DATABASE lab1;
