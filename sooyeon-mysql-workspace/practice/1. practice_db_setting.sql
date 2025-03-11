-- 실습용 database 만들기


-- 사내 시스템 (empdb)
CREATE DATABASE empdb;


-- 대학 시스템 (chundb)
CREATE DATABASE chundb;

-- 권한 부여
GRANT ALL PRIVILEGES ON empdb. * TO 'sotogito'@'%';
GRANT ALL PRIVILEGES ON chundb. * TO 'sotogito'@'%';