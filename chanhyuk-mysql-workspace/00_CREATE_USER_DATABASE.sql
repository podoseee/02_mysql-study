-- Single comment(한줄 주석)
# Single comment(한줄 주석, oracle 지원 x)

/*
	multiple comment (여러줄 주석)
    
    <workbench 설정 - Edix > Preferences>
    1. General -Editors - Indentation -Tab key inserts ~~ 체크하기 (탭을 공백으로 처리)
    2. SQL Editor - Other - Safe Updates 체크 해제하기
	   SQL Editor - Query Editor - Enable Code Completion  체크 해제하기
	3. Fonts & Colors - D2Coding으로 변경
*/

select * from user; # mysql(database) 를 사용하겠다고 선택해야됨
select * from mysql.user;
show databases; # 어떤 DB가 있는지
use mysql; # 사용할 DB 선택

/*
	## 사용자 계정 생성 ##
	CREATE USER '사용자명'@'호스트' IDENTIFIED BY '비밀번호';
    
    ## 사용자 계정 삭제 ##
    DROP USER '사용자명'@'호스트'
*/
CREATE USER 'pch'@'%' IDENTIFIED BY 'pch';

/*
	## 데이터베이스 생성 ##
    CREATE DATABASE DB명;
*/
CREATE DATABASE menudb;

/*
	## 계정에 권한 부여 ##
    GRANT ALL PRIVILEGES ON 권한 TO '사용자명'@'호스트명';    
*/
GRANT ALL PRIVILEGES ON menudb.* TO 'pch'@'%';
SHOW GRANTS FOR 'pch'@'%'; # 계정에 부여된 권한 확인;


#################################################
#################################################
-- 실습용 database 만들기
-- 사내 시스템 (empdb)
CREATE DATABASE empdb;

-- 대학 시스템 (chundb)
CREATE DATABASE chundb;

GRANT ALL PRIVILEGES ON empdb.* TO 'pch'@'%';
GRANT ALL PRIVILEGES ON chundb.* TO 'pch'@'%';















