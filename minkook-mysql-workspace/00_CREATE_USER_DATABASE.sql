-- single comment (한줄 주석)
#single comment (한줄 주석, oracle에서는 지원x)

/*
	mutiple comment (여러줄 주석)
	
	<workbench 설정 - Edit > Preference >
	1. General - Editors - Indentation - Tab key inserts ~~ 체크하기 (탭을 공백으로 처리)
	2. SQL Editor - Other - Safe Updates 체크해제
	   SQL Editor - Query Editor - Enable Code Completion 체크해제
	3. Fonts & Colors - D2Coding 으로 변경
*/

/*
	## 현재 존재하는 계정들 조회 ##
	mysql(database) 내의 user(table)를 
	
*/
##데이터스베이스명.테이블 
use mysql; -- 사용할 데이터베이스 선택
select * from user;

/*
	## 사용자 계정 생성 ##
	create user '사용자명'@'호스트' IDENTIFIED by '비밀번호';
	
	## 사용자 계정 삭제 ##
	drop user '사용자명'@'호스트'
*/

create user 'minkook'@'%'IDENTIFIED by '1234';

/*
	## 데이터베이스 생성 ##
	create database 데이터베이스명;
*/

/*
	## 계정에 권한 부여 ##
	grant all Privlieges on 권한 to '사용자명'@'호스트'

*/

grant ALL privileges on menudb.* to 'minkook'@'%';

show grants for 'minkook'@'%';