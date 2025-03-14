-- single comment (한줄 주석)
# single comment (한줄 주석, oracle에서는 지원x)
/*
	multiple comment (여러줄 주석)
    
    < workbench 설정 - Edit > Preferences >
    1. General - Editors - Indentation - Tab key inserts ~~ 체크하기 (탭을 공백으로 처리)
    2. SQL Editor - Other - Safe Updates 체크해제
	   SQL Editor - Query Editor - Enable Code Completion ~~ 체크해제
	3. Fonts & Colors - D2Coding 으로 변경
	
*/

/*
	## 현재 존재하는 계정들 조회 ##
    mysql(database)내의 user(table)를 조회
*/
select * from user; -- mysql(datebase)를 사용하겠다고 선택해야됨
select * from mysql.user; -- database명.table명으로 조회 가능

show databases; -- 어떤 datebase들이 있는지 조회

use mysql; -- 사용할 datebase 선택
select * from user;

/*
	## 사용자 계정 생성 ##
    CREATE USER '사용자명'@'호스트' IDENTIFIED BY '비밀번호';
    
    ## 사용자 계정 삭제 ##
    DROP USER '사용자명'@'호스트'
*/
CREATE USER 'jy'@'%' IDENTIFIED BY 'jy';

/*
	## 데이터베이스 생성 ##
    CREATE DATABASE 데이터베이스명;
 */
 CREATE DATABASE menudb;
 
 /*
	## 계정에 권한 부여 ##
    GRANT ALL PRIVILEGES ON 권한 TO '사용자명'@'호스트';
*/
GRANT ALL PRIVILEGES ON menudb.* TO 'jy'@'%';

SHOW GRANTS FOR 'jy'@'%'; -- 계정에 부여된 권한 확인
 
 -- DDL 수업용 database 만들기
CREATE DATABASE ddldb;
GRANT ALL PRIVILEGES ON ddldb.* TO 'jy'@'%';


