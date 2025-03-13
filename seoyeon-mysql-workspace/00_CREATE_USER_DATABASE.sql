-- single comment (한줄 주석)
# single comment (한줄 주석, oracle에서는 지원x)
/*
    multiple comment (여러줄 주석)
    
    < workbench 설정 - Edit > Preferences 
    1. General - Editors - Indentation - Tab key inserts~~ 체크하기 (탭을 공백으로 처리)
    2. SQL Editor - Other - Safe Updates 체크해제
        SQL Editor - Query Editor - Enable Code Completion~~ 체크해제
    3. Fonts & Colors - D2Coding 으로 변경 
*/

/*
    ## 현재 존재하는 계정들 조회 ##
    mysql(database)내의 user(table)를 조회
*/
select * from user; -- mysql(database)를 사용하겠다고 선택해야됨
select * from mysql.user; -- database명.table명으로 조회 가능

show databases; -- 어떤 database들이 있는지 조회

use mysql; -- 사용할 database 선택
select * from user;

/*
    ## 사용자 계정 생성 ##
    CREATE USER '사용자명'@'호스트' IDENTIFIED BY '비밀번호';
    
    ## 사용자 계정 삭제 ##
    DROP USER '사용자명'@'호스트'
*/
CREATE USER 'podoseee'@'%' IDENTIFIED BY 'podoseee';

/*
    ## 데이터베이스 생성 ##
    CREATE DATABASE 데이터베이스명;
*/
CREATE DATABASE menudb;

/*
    ## 계정에 권한 부여 ##
    GRANT ALL PRIVILEGES ON 권한 TO '사용자명'@'호스트';
*/
GRANT ALL PRIVILEGES ON menudb.* TO 'podoseee'@'%';

SHOW GRANTS FOR 'podoseee'@'%'; -- 계정에 부여된 권한 확인

-- 실습용 database 만들기

-- 사내 시스템 (empdb)
CREATE DATABASE empdb;

-- 대학 시스템 (chundb)
CREATE DATABASE chundb;

GRANT ALL PRIVILEGES ON empdb.* TO 'podoseee'@'%';
GRANT ALL PRIVILEGES ON chundb.* TO 'podoseee'@'%';

-- DDL 수업용 database 만들기
CREATE DATABASE ddldb;
GRANT ALL PRIVILEGES ON ddldb.* TO 'podoseee'@'%';


