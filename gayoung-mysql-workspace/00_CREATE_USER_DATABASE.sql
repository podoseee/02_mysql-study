-- single comment (한줄 주석)
# single comment (한줄 주석, oracle에서는 지원x)

-- 명령어 하나 시작 : Ctrl + Enter

/*
    multiple comment (여러줄 주석)
    < workbench 설정 - Edit > Peference >
    1. General - Editors - Indentation - Tab key inserts ~~ 체크하기(탭을 공백으로 처리)
    2. SQL Editor - Other - Safe Updates 체크해제
       SQL Eidtor - Query Editor - Enable Code Completion ~~ 체크해제
    3. Fonts & Colors - D2Coding으로 변경    
*/

/* 
    ## 현재 존재하는 계정들 조회 ##
    mysql(database)내의 user(table)를 조회
*/
select * from user; -- 안됨 / mysql(database)를 사용하겠다고 선택해야됨 
select * from mysql.user; -- database명.table명으로 조회 가능

show databases; -- 어떤 database들이 있는지 조회 

use mysql; -- mysql이라는 데이터 베이스 선택

/*
    ## 사용자 계정 생성 ##
    CREATE USER '사용자명'@'호스트' IDENTIFIED BY '비밀번호';
    
    ## 사용자 계정 삭제 ##
    DROP USER '사용자명'@'호스트'
*/

CREATE USER 'YoungGaLee'@'%' IDENTIFIED BY 'younggalee';
select * from mysql.user;

/*
    ## 데이터베이스 생성 ##
    CREATE DATABASE 데이터베이스명;
*/

CREATE DATABASE menudb;
show databases;

/* 
    ## 계정에 권한 부여 ##
    GRANT ALL PRIVILEGES ON 권한 TO '사용자명'@'호스트';
*/

GRANT ALL PRIVILEGES ON menudb.* TO 'YoungGaLee'@'%';

SHOW GRANTS FOR 'YoungGaLee'@'%'; -- 계정확인 가능함
    


    
    