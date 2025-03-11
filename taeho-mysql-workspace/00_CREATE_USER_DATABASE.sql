select 1;
-- single comment(한줄주석)
# (한줄 주석, 오라클 미지원)
/*
	multi comment(복수줄 주석)
    <workbench 설정>
    - General - Editors - Tab key insert... 체크 (탭을 공백으로 처리)
    - Sql Editor - Other - Safe Updates 체크해제
    - Font = D2Coding
*/
select * from user;
select * from mysql.user; -- {db}의 유저 조회
show databases; -- db 목록 조회
use mysql; -- 사용할 db 선택

/*
	# Create User #
    CREATE USER {USER_NAME}'@'{HOST} IDENTIFIED BY {PASSWORD};
    
    # Delete User #
    DELETE USER {USER_NAME}'@'{HOST}
*/
CREATE USER 'TH'@'%' IDENTIFIED BY 'root';

/*
	# Create Database #
    CREATE DATABASE {DB_NAME};
*/

CREATE DATABASE menudb;

/*
	# Grant Privilege #
    GRANT {Privileges...} ON {DB_NAME} TO {USER_NAME}'@'{HOST};
*/
GRANT ALL PRIVILEGES ON menudb.* TO 'TH'@'%';

SHOW GRANTS FOR 'TH'@'%'; -- Check PRIVILEGES of Specific User