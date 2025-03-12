/*
    ## 사용자 계정 생성 ##
    CREATE USER '사용자명'@'호스트' IDENTIFIED BY '비밀번호';
    
    ## 사용자 계정 삭제 ##
    DROP USER '사용자명'@'호스트'
*/
CREATE USER 'seungjoo'@'%' IDENTIFIED BY 'seungjoo';

/*
    ## 데이터베이스 생성 ##
    CREATE DATABASE 데이터베이스명;
*/
CREATE DATABASE menudb;

/*
    ## 계정에 권한 부여 ##
    GRANT ALL PRIVILEGES ON 권한 TO '사용자명'@'호스트';
*/
GRANT ALL PRIVILEGES ON menudb.* TO 'seungjoo'@'%';

SHOW GRANTS FOR 'seungjoo'@'%'; -- 계정에 부여된 권한 확인 