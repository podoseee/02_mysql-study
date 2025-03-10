-- single comment (한줄 주석)
# single comment (한줄 주석, oracle에서는 지원 X)
/*
    multiple commnet (여러줄 주석)
    
    < workbench 설정 - Edit > preferences
    1. Gneral - Editors - Indentation - Tab key inserts~ 체크하기 (탭을 공백으로 처리)
    2. SQL Editor - Other - Safe Updates 체크해제
        SQL Eeitor - Quert Editor - Enable Cod Completion~ 체크해제
    3. Fonts & Colors - D2Coding 변경
*/

/*
    ## 현재 존재하는 계정들 조회
    mysqp데이터베이스 내의 user라는 테이블을 조회
*/

-- select * from user; -- mysql을 사용하겠다고 선택을 먼저 해야됨, 바로쓰면 오류남 
-- select * from mysql.user;

show databases; -- 어떤 데이터베이스가 있는지 조회

use mysql; -- 사용할 데이터베이스 선택
select * from user;

/*
    ## 사용자 계정 생성
    CREATE USER '사용자명'@'호스트' IDENTIFIED BY '비밀번호';
    
    ## 사용자 계정 삭제
    DROP USER '사용자명'@'호스트'
*/

CREATE USER 'sotogito'@'%' IDENTIFIED BY 'sotogito';

/*
    ## 데이터베이스 생성
    CREATE DATABASE 데이터베이스명;
*/

CREATE DATABASE menudb;

/*
    ## 계정에 권한 부여
    GRANT ALL PRIVILEGES ON 권한 TO '사용자명'@'호스트';
*/

GRANT ALL PRIVILEGES ON menudb.* TO 'sotogito'@'%';

SHOW GRANTS FOR 'sotogito'@'%'; -- 계정에 부여된 권한 확인