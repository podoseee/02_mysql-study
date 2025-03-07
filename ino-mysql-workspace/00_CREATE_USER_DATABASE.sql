select * from user; -- mysql(database) 사용 선택을 해야함
select * from mysql.user; -- dbName.tableName select o

show databases;

use mysql;

select * from user;

CREATE USER 'ino'@'%' IDENTIFIED BY 'ino';

CREATE DATABASE menudb;

GRANT ALL PRIVILEGES ON menudb.* TO 'ino'@'%';

SHOW GRANTS FOR 'ino'@'%'; 