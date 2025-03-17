-- single comment (한줄 주석)
# songle commnet(한줄 주석, oracle에서는 지원 x)
/*
    multiple comment (여러줄 주석)
    
    <workbench 설정 - Edit> Preferences >
    1. General - Editors - Indentation - Tab key insert~ ~ 체크하기 (탭을  공백으로 처리)
    2. SQL Editor - Other -Safe Update 체크해제
       SQL Editor - Query Editor - Enable Code Completion ~ 체크해제
    3. Font & Colors - D2Coding 으로 변경
    
*/

/*
    ## 현재 존재하는 계정들 조회 ##
    mysql(databae)내의 user(table)를 조회
*/
select * from user; -- mysql(database)를 사용하겠다고 선택해야됨
select * from mysql.user; -- database명.table명으로 조회 가능

show databases; -- 어떤 database들이 있는지 조회

use mysql;
select * from user; -- 사용할 database 선택

/*
    ## 사용자 계정 생성##
    CREATE USER '시용자명'@'호스트' IDENTIFIED BY '비밀번호';
    
    ## 사용자 계정 삭제 ##
    DROP USER '사용자명'@'호스트'
*/
CREATE USER 'jjanggu'@'%' IDENTIFIED BY 'jjanggu';

/*
    ## 데이터베이스 생성 ##
    CREATE DATABASE 데이터베이스명
*/
CREATE DATABASE menudb;

/*
    ## 계정에 권한 부여 ##
GRANT ALL PRIVIELEGS ON 권한 TO '사용자명 @ 호스트);
*/
GRANT ALL PRIVILEGES ON menudb.* TO 'jjanggu'@'%';

SHOW GRANTS FOR 'jjanggu'@'%';


-- 실습용 database 만들기

-- 사내 시스템 (empdb)
CREATE DATABASE empdb;

-- 대학교 시스템 (chundb)
CREATE DATABASE chundb;

GRANT ALL PRIVILEGES ON empdb.*TO 'jjanggu'@'%';
GRANT ALL PRIVILEGES ON chundb.*TO 'jjanggu'@'%';

-- DDL 수업용 database 만들기
CREATE DATABASE ddldb;
GRANT ALL PRIVILEGES ON ddldb.*TO 'jjanggu'@'%';

-- homework용 database 만들기
CREATE DATABASE homeworkdb;
GRANT ALL PRIVILEGES ON homeworkdb.*TO 'jjanggu'@'%';


