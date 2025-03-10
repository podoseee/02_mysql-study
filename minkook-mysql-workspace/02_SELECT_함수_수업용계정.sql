/*
	## BUILT  IN  FUNCTIONS
	1. 내장함수
	2. 전달된 값들을 읽어들여 특정 작업 수행 후 결과값을 반환하는 함수
	3. 흐름
	   호출(값 전달) -> 작업 수행 -> 결과값 반환
*/

--단일행 함수 -- 문자처리 함수

/*
	## ASCIL, CHAR ##
	1. ASCIL(문자) : 해당 문자의 아스키 코드값을 반환	 
	2. CHAR(숫자)	  : 해당 아스키 코드 숫자의 문자값을 반환

*/


SELECT 
	  ELT(2,'사과','딸기','바나나') -- 2
	 ,FIELD('바나나','사과','딸기','바나나') -- 3
	 ,FIND_IN_SET('사과','사과,딸기,바나나');
	 
SELECT 
		*
FROM
	tbl_menu A
order by 
	-- FIND_IN_SET(menu_code,'15,12') DESC; -- menu_code값이 15일 경우 1, menu_code 값이 12일 경우 2, 나머지 menu_code값은 0
	FIELD(A.orderable_status , 'N','Y');


select 
	INSERT('메뉴의 이름은 메뉴명입니다.',9,3,menu_name)
from
	tbl_menu;

-- 쥬스가 포함되어 있는 메뉴이름을 JUICE로 변경해서 조회

select 
		menu_name
  	   ,insert(menu_name,instr(menu_name,'쥬스'),2,'JUICE')
from 
	tbl_menu
where menu_name LIKE '%쥬스%';


select 
	 LEFT('Hello World',4)
	,RIGHT('Hello World',5);

select 
 	 LPAD('왼쪽',6,'@')
 	,RPAD('오른쪽',6,'@');

select 
 	 RPAD('880918-2',14,'*');



/*
	## REPEAT ##
	REPEAT(문자열,횟수) : 문자열을 횟수만큼 반복해 만들어 반환
	
*/
select 
	  REPEAT('엄마',3);


select 
	  concat('이름:' ,space(3),', 나이:',SPACE(2));


select 
	 SUBSTRING('안녕하세요 반갑습니다.',7,2)
	,SUBSTRING('안녕하세요 반갑습니다.',7);


select 
	 SUBSTRING_INDEX('hong.test@gmail.com','@',1)
	,SUBSTRING_INDEX('hong.test@gmail.com','.',2)
	,SUBSTRING_INDEX('hong.test@gmail.com','.',-2);



/*
 	## CELING,FLOOR,TRUNCATE,ROUND ##
 	1. CELING(숫자) : 해당 숫자의 올림값 반환
 	2. FLOOR(숫자)  : 해당 숫자의 내림값(현재수 보다 작은 최대정수) 반환
 	3. TRUNCATE(숫자,자리수) : 해당 숫자의 버림값 반환 .
 */
select 
	  truncate(123.75869,1);

select 
	 75 % 10  -- 나머지값
	,75 mod 10
	,MOD(75,10);

select 
	CURDATE()
   ,CURDATE(),CURRENT_DATE;


select 
	DAYOFWEEK(CURDATE())
   ,DAYOFMONTH(CURDATE())
   ,DAYOFYEAR(CURDATE())
   ,MONTHNAME(CURDATE());



/*
 	## CAST, CONVERT ##
 	CAST(값 AS 데이터 형식)
 	CONVER(값,데이터형식)
 	
 	* 주요 데이터 형식
 	1) 문자열로 : CHAR
 	2) 날짜 및 시간으로 : DATE,TIME,DATETIME
 	3) 숫자로 : SIGED INTEGER,DOUBLE, DECIMAL
 	
*/

select CONCAT(menu_price,'원') from tbl_menu;
select ADDDATE('2024-06-01',1);


-- 강제 형 변환
select 
	AVG(menu_price)
   ,CAST(AVG(menu_price) as SIGNED INTEGER)
   ,CONVERT(AVG(menu_price), SIGNED INTEGER)
from
	tbl_menu;


select 
	cast('2024%5%30' as DATE)
   ,cast('2024/5/30' as DATE)
   ,cast('2024$5$30' as DATE)
   ,cast('2024년5월30일' as DATE);


select 
	menu_name
   ,IF(orderable_status = 'Y','주문가능','주문불가능') as "주문가능여부"
from 
	tbl_menu A;