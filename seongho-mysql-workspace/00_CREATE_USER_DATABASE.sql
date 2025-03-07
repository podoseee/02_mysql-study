-- 한줄 주석
#한줄 주석 , ORACLE에서는 안 됨
/*
여러줄 주서억
workbench 설정 Edit > Preferences>
1. General - Editors - indintation - tab key insert~ 췤
2. SQL Editor - Other - safe Updates 췤  풀기
3. SQL Editor - Query Editor - Enable Code Compl~~ 췤 해제
4. 폰트설정 - De2Coding
*/
/*
현재 존재하는 계정들 조회
mysql(database) 내의 user(table)를 조횡
*/
select * from user; -- mysql(database)를 사용하겠다고 선택해야 됨
select * from mysql.user; -- database명.table명으로 조회 가능
show databases; -- 어떤 database들이 있는지 조회
 use mysql -- 사용할 database선택
 select*from user;
 
 /*
 사용자 계정 생성
  CREATE USER'사용자명'@'호스트' IDENTIFIED BY '비밀번호';
  
  사용자 계정 삭제
  DROP USER '사용자명'@'호스트'
 
 */
 CREATE USER 'KSH'@'%' IDENTIFIED BY 'KSH';
 /*
 데이터베이스 생성
 
 CREATE DATABASE  데이터베이스명;
 
 */
 CREATE DATABASE menudb;
 /*
 계정에 권한 부여
 GRANT ALLL PRIVILEGES ON 권한 TO '사용자명'@'호스트';
 
 */
 GRANT ALL PRIVILEGES ON menudb.* TO 'KSH'@'%';
 
 SHOW GRANTS FOR 'KSH'@'%' -- 계정에 부여된 권한 확인