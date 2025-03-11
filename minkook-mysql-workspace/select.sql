/*
	## SQL 종류
	1. DQL(DATA QUERY LANGUAGE) : 데이터 질의 언어 (데이터 조회용)
		- select
	2. DML(DATA Manipulation Language) : 데이터 조작 언어
		- insert (데이터 삽입)
		- update (데이터 수정)
		- delete (데이터 삭제)
	3. DDL (data definition Language) : 데이터 정의 언어
		- create(데이터 구조 생성)
		- alter (데이터 구조 변경)
		- drop 	(데이터 구조 삭제)
	4. DCL (Data Control Langauge) : 데이터 제어 언어
		- grant (권한 부여)
		- revoke (권한 철회)
	5. TCL (Transaction Control Language) : 트랜잭션 제어언어
		- commit	(트랜잭션 확정)
		- rollback	(트랜잭션 취소)


*/

show tables;

-- 특정 테이블의 구조 확인(컬럼,컬럼타입,null  허용여부,key)
select * from tbl_menu;
DESC tbl menu;

select * from tbl_category tc ;


/* 표현법
   왼쪽번호 실행순서
   [5]select 컬럼,산술식,함수식, ...AS 별칭
   [1][FROM TABLE]
   [2] WHERE 조건식]
   [3][GROUP BY 그룹 기준]
   [4][HAVING 조건식]
   [6][ORDER BY 정렬기준 정렬방식]
   [7][Limit 숫자,숫자]


*/


-- 단일컬럼 데이터 조회
select menu_code
	  ,menu_name
	  ,menu_price
	  ,category_code
	  ,orderable_status
from 
	tbl_menu
where menu_code = 1;


-- 부가세 포함 계산
select 
	  menu_name
	, menu_price	
	, menu_price + (menu_price * 0.1)
	, menu_price + cast( (menu_price * 0.1) as signed integer)
from 
	tbl_menu;


/*
	## 컬럼 별칭 ##
	조회되는 컬럼명헤더 부분을 내가 원하는 별칭으로 조회 가능
	
	[표현법]
	컬럼명 [as] 별칭 | '별칭' | '별칭' |`별칭`
	별칭이 숫자로 시작되거나 공란/특수문자가 있을 경우 반드시 "",''.``로 감싸야됨
	
*/
select 
	 menu_name 메뉴이름
	,menu_price '메뉴이름'
	,menu_price * 0.1 as "메뉴 부가세" 
	,menu_price * 0.1 as "메뉴 부가세포함가격" 
from 
	tbl_menu;
	
select 
	 menu_name 메뉴이름
	,menu_price * 1.1 as "메뉴 부가세포함가격" 
from 
	tbl_menu;

/*
 	## 문자열 연결 ##
 	여러 컬럼들을 맞치 하나의 컬럼인거 처럼 연결하거나
 	리터럴과도 연결가능
*/
select concat('홍','길','동');


select 
	 menu_name
	,concat(menu_price,'원')
from 
	tbl_menu;

/*
 	## 문자열 연결 ##
 	여러 컬럼들을 중복값을 한번씩 표현하고 할때
*/

select 
	   category_code
	   ,count(*)
from 
	tbl_menu
group by category_code;



select 
	 distinct category_code
	 		 ,orderable_status
from tbl_menu;


/*
  	## Where 절 ##
  	1. 테이블의 데이터 중 원하는 데이터만 선택적으로 조회할 때 사용
  	2. where 조건식 
  				L 컬럼명, 연산자, 표현식 등을 결합해서 작성
 */

/*
  ## 비교 연산자 ##
  1. 값 간의 관계를 비교하기 위해 사용
  2. 비교 결과는 논리값(TRUE/FALSE/NULL)이 타입됨
  3. 비교하는 두 값은 동일한 데이터 타입이어야 한다.
  4. 종류
  	= :같은지 비교
  	!= , <> : 같지 않은지 비교
  	>,>=, <,<= 크고 작음을 비교
 */
select 
     menu_name
   , menu_price
   , orderable_status
from 
	tbl_menu A
where 
	 -- A.orderable_status = 'N'
	 -- A.orderable_status = 'n'
	 -- BINARY A.orderable_status = 'n' => 대소문자 구분해서 비교할 경우 => BINARY
	-- A.orderable_status <> 'Y'
	 A.menu_price >= 13000
and  A.orderable_status  = 'N';

/*
 	## 논리연산자
 	1. 여러 조건 결과를 하나의 논리 결과로 만들어줌
 	2. 종류
 		&& AND : 두 조건이 모두 TRUE 여만 최종 TRUE 반환
 		|| OR  : 둘 중 하나만 TRUE 여도 최종 TRUE 반환
 		
   숫자 0을 FALSE로 간주
   0외의 숫자를 TRUE로 간주
   문자열은 0(false)로 간주
 */



select 
       menu_code
     , menu_name
     , menu_price
     , category_code
     , orderable_status
from 
	tbl_menu A
where 
	A.category_code  = '10'
and A.menu_price  > 5000;

-- 주문가능하며 카테고리번호가 10인 메뉴 조회
select 
       menu_code
     , menu_name
     , menu_price
     , category_code
     , orderable_status
from 
	tbl_menu A
where 
	A.category_code  = '10'
and A.orderable_status = 'Y';


select 
       menu_code
     , menu_name
     , menu_price
     , category_code
     , orderable_status
from 
	tbl_menu A
where 
	(A.menu_price = 9000 or A.category_code= 4)
 
and A.menu_code > 10;
-- and 연산이 OR 연산보다 우선순위가 높음

select 
       menu_name
     , menu_price
     , category_code
from 
	tbl_menu A
where 
	 A.menu_price  between 10000 and 25000;


/*
 	## LIKE  ##
 	비교값이 지정한 패턴을 만족하는지 비교해주는 연산자
 	패턴 작성시 '%','_' 와일드 카드 작성 가능
 */
select 
       menu_name
     , menu_price
     , category_code
from 
	tbl_menu A
where 
	 -- A.menu_name like '%마늘%';
	 A.menu_name like '%밥';

select 
       menu_name
     , menu_price
     , category_code
from 
	tbl_menu A
where 
	 -- A.menu_name like '%마늘%';
	 A.menu_name like '___쥬스';






