/*
SQL 문 종류

1. DQL (Data Query Language) :데이터 질의 언어 
    ㄴ SELECT (데이터 조회용
2. DML (Data Manipulation Language) : 데이터 조작 언어
    ㄴ INSERT (데이터 삽입
    ㄴ UPDATE (데이터 수정
    ㄴ DELETE (데이터 삭제
3. DDL (Data Definition Language : 데이터 정의 언어
    ㄴ CREATE (데이터 구조 생성
    ㄴ ALTER (데이터 구조 변경
    ㄴ DROP (데이터 구조 삭제
4. DCL (Data Control Language : 데이터 제어 언어
    ㄴ GRANT (권한 부여
    ㄴ REVOKE (권한 철회
5. TCL (Transaction Control Language : 트랙잭션 제어 언어
    ㄴ COMMIT (트랙잭션 확정
    ㄴ ROLLBACK (트랙잭션 취소
*/
-- 현재 선택된 database의 모든 테이블들 조횡
show tables;

-- 특정 테이블의 구조 확인 (컬럼 , 럼럼타입, null허용여부, key, 등)
desc tbl_menu;

SELECT * FROM tbl_category;
SELECT * FROM tbl_menu;
SELECT * FROM tbl_order;
SELECT * FROM tbl_order_menu;
SELECT * FROM tbl_payment;
SELECT * FROM tbl_payment_order;

/*
SELECT 문
1. DQL(Query 명령문 (DML의 하위 분류
2. 정의된 테이블의 데이터를 조회/검색하는 명령문
3. 조회 결과를 ResultSet(결과집합)이라 함
4. 표현법
    ㄴ5.SELECT 컬럼, 산술식, 함수식, .. AS 별칭 
    ㄴ1[ FROM 테이블명 ]
    ㄴ2[ WHERE 조건식 ]
    ㄴ3[GROUP BY 그룹기준]
    ㄴ4[HAVING 조건식]
    ㄴ6[ORDER BY 정렬기준 정렬방식]
    ㄴ7[LIMIT 숫자 , 숫자 ]
    실행순서
*/

-- 단일 컬럼 데이터 조회
SELECT menu_name FROM tbl_menu;

-- 여러 컬럼 조회
SELECT
    menu_code
  , menu_name
  , menu_price
FROM
    tbl_menu;

-- 모든 컬럼(*) 조회
SELECT
    *
FROM
    tbl_menu;

SELECT
    menu_code
    ,menu_name
    ,menu_price
    ,category_code
    ,orderable_status
FROM
    tbl_menu;
    
/*
 산술연산
SELECT절에 산술연산식 작성시 산술 연산 결과 조회

*/
SELECT 6+4;
SELECT
    6 / 4       -- 나누기결과
   ,6 div 4;  -- 몫(1)
SELECT 
      6 % 4
    , 6 mod 4 ;
    
-- 부가세 포함 계산
SELECT
    menu_name
   ,menu_price
   ,menu_price + (menu_price * 0.1)
   ,menu_price + cast((menu_price * 0.1) as signed integer)
FROM
    tbl_menu;
    
/*
컬럼(Alias) 별칭
조회되는 ResultSet의 컬럼명(헤더) 부분을 내가 원하는 별칭으로 조회 가능

[표현법]
컬럼명 AS 별칭|'별칭'|"별칭"|`별칭`

별칭이 숫자로 시작되거나 공백/특수문자가 있을경우 반드시 "",'',``로 감싸야됨

*/
SELECT
    menu_name 메뉴이름
   ,menu_price '메뉴 가격'
   ,menu_price * 0.1 AS  "부가세"
   ,menu_price * 1.1 AS `부가세 포함 가격`
FROM
    tbl_menu;
    
/*
리터럴
임의로 지정한 문자값
SELECT절에 리터럴 제시시 마치 존재하는 데이터처럼 조회 가능
*/
SELECT 
    menu_name AS 메뉴이름
   ,menu_price * 1.1 AS "부가세 포함 가격"
   ,'원' AS'단위'
FROM
    tbl_menu;

/*
문자열 연결
여러 컬럼값들을 마치 하나의 컬럼처럼 연결하거나
리터럴과도 연결 가능

표현법]
CONCAT(값, 값2, 값3, ...)
*/
SELECT 
    CONCAT('ㅎ','ㄱ','ㄷ');
    
SELECT
    menu_name
   ,CONCAT(menu_price, '원')
FROM
    tbl_menu;
    
/*
    DISTINCT
    컬럼의 중복값을 한번씩 표현하고자 할 때 사용
    SELECT 절에 단 한번만 ㄱㄴ
*/

SELECT 
    DISTINCT category_code
FROM
    tbl_menu;
    
SELECT DISTINCT -- 제시된 컬럼값을 쌍으로 묶어 중복 판별 
    category_code
   ,orderable_status
FROM
    tbl_menu;
    
-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
/*
WHERE 절
1. 테이블의 데이터 중 원하는 데이터만 선택적으로 조회할때
WHERE 조건식
            ㄴ 컬럼명, 연산자, 표현식 등을 결합해서 작성
*/

/*
비교연산자
1. 값 간의 관계를 비교하기 위해 사용
2. 비교 결과는 논리값(true/FALSE/nullq)이 됨
비교하는 두 값은 동일한 데이터 타입이어야됨
4. 종류
.
*/

-- 가격이 5000원 초과이며 카테고리 번호가 10인 메뉴 조회
SELECT
    *
FROM 
    tbl_menu
WHERE
    menu_price > 5000
and category_code = 10;

-- 주문가능하며 카테고리 번호가 10
SELECT
    *
FROM
    tbl_menu
where
    category_code = 10
and orderable_status='Y';

-- 카테고리번호가 4거나 가격이 9000원인 메뉴중에서
-- 메뉴번호가 10보다 큰 메뉴
SELECT
    *
FROM
    tbl_menu
where
(    category_code = 4 or menu_price =9000)
and menu_code > 10;

/*
BETWEEN AND
숫자, 문자열, 날짜/시간 값의 범위에 대한 조건 제시시 사용

표현법]
비교대상 BETWEEN 하한값 AND 상한값

비교대상 값이 하한값 이상 상한값 이하인경우 true 반환
*/

SELECT
    menu_name
   ,menu_price
   ,category_code
FROM
    tbl_menu
where
--    menu_price >= 10000 and menu_price <=25000;
    menu_price between 10000 and 25000;

-- 부정표현


SELECT
    menu_name
   ,menu_price
   ,category_code
FROM
    tbl_menu
where
--    menu_price >= 10000 and menu_price <=25000;
    menu_price not between 10000 and 25000;
    
SELECT
    menu_name
   ,menu_price
FROM
    tbl_menu
WHERE
    menu_name BETWEEN '가' and '마';
    
/*
LIKE
비교값이 지정한 패턴을 만족하는지 비교해주는 연산자
패턴 작성시 '%' , '_' 와일드카드 작성 가능

와일드카드
다른 문자로 대체 가능한 특수한 의미를 가진 문자
1) % 0개 이상의 임의의 글자
2) _ : 1개의 임의의 글자 

*/
-- 메뉴명이 마로 시작하는 메뉴우
SELECT
    menu_name
   ,menu_price
FROM
    tbl_menu
WHERE
    menu_name LIKE '마%';
    
SELECT
    menu_name
   ,menu_price
FROM
    tbl_menu
WHERE
    menu_name LIKE '%마늘%';
    
-- 메뉴명 밥

SELECT
    menu_name
   ,menu_price
FROM
    tbl_menu
WHERE
    menu_name LIKE '%밥';

-- 쥬스 앞글자가 3글자인 메뉴
SELECT
    menu_name
   ,menu_price
FROM
    tbl_menu
WHERE
    menu_name LIKE '___쥬스';
    
-- 갈치가 포함 X

SELECT
    menu_name
   ,menu_price
FROM
    tbl_menu
WHERE
    NOT menu_name LIKE '%갈치%';
    
/*
IN
비교값이 제시한 목록 중에 존재할 경우 true 반환해주는 연산자

표현법]
비교대상 IN (값, 값2, 값3,  ...)
*/

-- 카테고리 번호가 4 또는 5또는 6인 메뉴
    
SELECT
    menu_name
   ,category_code
FROM
    tbl_menu
WHERE
  --  category_code = 4 or category_code = 5 or category_code = 6; 
    category_code in (4,5,6);
    
/*
IS NULL
비교대상이 NULL인지 비교해주는 연산자
*/
-- 대분류 카테고리만 조회
SELECT
    category_name
   ,ref_category_code
FROM
    tbl_category
where
    ref_category_code IS NULL;
    
/*
order by
조회 결과를 정렬하고자 할 때
1. 오름차순 정렬(ASC)과 내림차순 정렬(DESC) 존재
표현법]
ORDER BY 정렬기준 [IS NULL] [정렬방식]
*/

SELECT
    menu_code
   ,menu_name
   ,menu_price
FROM
    tbl_menu
ORDER BY 
--  menu_price ;
    menu_price DESC,menu_name ;