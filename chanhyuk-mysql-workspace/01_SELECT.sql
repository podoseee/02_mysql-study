select * from tbl_menu;

show tables;

-- 특정 테이블의 구조 확인 (컬럼, 컬럼타입, null 허용여부, key 등)
desc tbl_menu;

SELECT * FROM tbl_menu;

/*
    ## SELECT 문 ##
    1. DQL(Query) 명령문 (DML의 하위 분류)
    2. 정의된 테이블의 데이터를 조회/검색하는 명령문
    3. 조회 결과를 ResultSet(결과 집합)이라함
    4. 표현법
        5) SELECT, 컬럼, 산술식, 함수식, ..AS 별칭
        1) [FROM 테이블명] => 생략가능(mysql 에서는?)
        2) [WHERE 조건식]
        3) [GROUP BY 그룹기준]
        4) [HAVING 조건식] => GROUP BY 에 조건을 주는 식
        6) [ORDER BY 정렬기준 정렬방식]
        7) [LIMIT 숫자, 숫자]
*/

-- 단일 컬럼 데이터 조회
select menu_name
from tbl_menu;

-- 여러 컬럼 조회
select 
    menu_code
    ,menu_name
    ,menu_price
from 
    tbl_menu
;

-- DISTINCT : 중복 제거. select 절에 한 번만 기술가능
-- 메뉴별 카테고리
select 
    distinct category_code
from
    tbl_menu;
    
SELECT
    1 OR 1          -- T or T => 1(true)
,   2 || 2          -- T or T => 1
,   -1 || 1         -- T or T => 1
,   1 || 'abc'      -- T      => 1
,   NULL || NULL    -- NULL   => NULL
,   0 OR NULL       -- F or N => NULL
,   1 OR NULL;       -- T      => 1

-- 가격이 5000원 초과이며 카테고리 번호가 10인 메뉴 조회 (모든 컬럼)

SELECT
    *
FROM
    tbl_menu
WHERE
    category_code = 10
AND menu_price>5000;

-- 주문 가능하며 카테고리 번호가 10인 메뉴 조회

SELECT
    *
FROM
    tbl_menu
WHERE
    category_code = 10
AND orderable_status = 'Y';

-- 카테고리번호가 4거나 가격이 9000원인 메뉴 중에서
-- 메뉴번호가 10보다 큰 메뉴 조회
SELECT
    *
FROM
    tbl_menu
WHERE
    (category_code = 4
OR  menu_price = 9000)
AND menu_code > 10;

-- 가격이 10000~25000원인 메뉴 조회
SELECT
    menu_name
,   menu_price
,   category_code
FROM
    tbl_menu
WHERE
    -- menu_price >= 10000 AND menu_price <= 25000;
    menu_price BETWEEN 10000 AND 25000;
    
-- 부정 표현
SELECT
    menu_name
,   menu_price
,   category_code
FROM
    tbl_menu
WHERE
    -- menu_price >= 10000 AND menu_price <= 25000;
    menu_price NOT BETWEEN 10000 AND 25000;
    
    -- 카테고리번호가 4,5,6 인 메뉴
SELECT
        menu_name
    ,   category_code
FROM
    tbl_menu
WHERE
    category_code NOT IN (4, 5, 6);
    
-- 대분류 카테고리만 조회 (상위카테고리번호가 NULL 인 데이터 조회)
SELECT
    category_code
,   category_name
,   ref_category_code
FROM
    tbl_category
WHERE
    ref_category_code is NULL;
    
    
-- 소분류 카테고리만 조회 (즉, 상위카테고리번호가 NULL 이 아닌)
SELECT
    category_code
,   category_name
,   ref_category_code
FROM
    tbl_category
WHERE
    ref_category_code is not NULL;




/*
    











