-- 한줄주석
# 한줄주석, 그러나 oracle에서는 지원x
/*
여러줄주석
*/



select * from user;  -- mysql라는 db를 사용하겟다고 안해서 오류남
select * from mysql.user; 

show databases; -- 어떤 db들이 있는지 조회
-- use mysql --사용할 database 선택
select * from user;

/* 사용자 계정 생성
	CREATE USER '사용자명 '@'호스트 IDENTIFIED BY '비밀번호'  -- 사용자 계정 생성은 루트에서만 가능, 다른 계정에서 진행할 시 권한을 부여해주어야함

*/
-- CREATE USER 'seungjoo'@'%' IDENTIFIED BY 'seungjoo' -- 계정명과 똑같이 비밀먼호 생성해주기!!

/*
데이터베이스 생성, CREATE DATABASE 데이터베이스명;

*/
CREATE DATABASE menudb;


/* 
계정에 권한부여
GRANT ALL PRIVILEGES ON 권한 TO '사용자명'@'호스트'; 
*/
GRANT ALL PRIVILEGES ON menudb.* TO 'seungjoo'@'%';
SHOW GRANTS FOR 'seungjoo'@'%'; -- 계정에 부여된 권한 확인