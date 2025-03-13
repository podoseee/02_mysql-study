/*
    ## GROUP BY 절 ##
    1. 특정 컬럼 값을 기준으로 전체 행(ROW)을 서브 그룹으로 그룹화시킬 수 있음 
    2. 둘 이상의 컬럼을 이용해 다중 그룹화 진행도 가능 
    3. 주로 그룹함수의 통계함수(SUM, AVG, COUNT, MIN, MAX)를 쓰기위해 사용
*/

SELECT * FROM tbl_menu;

-- 카테고리별 메뉴 수 조회 
-- => category_code 컬럼값이 일치하는 메뉴들끼리 그룹으로 묶기 
SELECT
    category_code
  , COUNT(*)
FROM
    tbl_menu
GROUP BY
    category_code;

-- 카테고리별 메뉴 가격 총합 구하기 
SELECT                      -- 3
    category_code
  , SUM(menu_price) 총합
FROM                        -- 1
    tbl_menu
GROUP BY                    -- 2
    category_code
ORDER BY                    -- 4
    총합;

-- 카테고리별 메뉴의 개수, 평균가격, 최대가격, 최소가격 조회 
SELECT
    category_code
  , COUNT(*) AS 메뉴개수
  , FLOOR(AVG(menu_price)) AS 평균가격
  , MAX(menu_price) AS 최대가격
  , MIN(menu_price) AS 최소가격
FROM
    tbl_menu
GROUP BY
    category_code;


use empdb;
SELECT * FROM employee;

-- 각 부서별 사원수, 총 급여합, 평균급여 
SELECT
    dept_code
  , COUNT(*) AS 사원수
  , SUM(salary) AS 급여합
  , FLOOR(AVG(salary)) AS 평균급여
FROM
    employee
GROUP BY
    dept_code;

use menudb;
-- 카테고리+주문가능여부별 개수 
SELECT
    category_code
  , orderable_status
  , COUNT(*)
FROM
    tbl_menu
GROUP BY
    category_code, orderable_status -- 여러 컬럼 제시 가능
ORDER BY
    category_code;

-- 메뉴명길이별로 
SELECT
    CHAR_LENGTH(menu_name)
  , COUNT(*)
FROM
    tbl_menu
GROUP BY
    CHAR_LENGTH(menu_name); -- 함수식 작성 가능

/*
    ## HAVING 절 ##
    1. GROUP BY절에 의해 생성된 서브 그룹을 대상으로 조건을 지정하는 절
    2. 그룹 함수를 이용한 조건은 HAVING 절에서 처리할 수 있음 (WHERE절 불가)
*/

-- 카테고리별 메뉴의 개수가 1개인 카테고리를 조회
SELECT
    category_code
  , COUNT(*)
FROM
    tbl_menu
-- WHERE COUNT(*) = 1
GROUP BY
    category_code
HAVING
    COUNT(*) = 1;

-- 카테고리별 메뉴총가격이 25000원 이상인 카테고리 조회
SELECT
    category_code
FROM
    tbl_menu
GROUP BY
    category_code
HAVING
    SUM(menu_price) >= 25000;

-- -------------------------- 실습 ----------------------
use empdb;

-- 부서별 평균급여가 300만원 이상인 부서 조회 
SELECT
    dept_code
  , AVG(salary)
FROM 
    employee
GROUP BY
    dept_code
HAVING
    AVG(salary) >= 3000000;

-- 부서별 보너스를 받는 사원이 없는 부서를 조회 
SELECT
    dept_code
--  , COUNT(*) "전체사원수"
--  , COUNT(bonus) "보너스를 받는 사원수"
FROM 
    employee
GROUP BY
    dept_code
HAVING
    COUNT(bonus) = 0;

/*
    ## WITH ROLLUP ## 
    그룹별 산출된 결과의 최종집계 및 중간집계를 계산해주는 함수
*/
use menudb;

SELECT
    category_code
  , SUM(menu_price)
FROM
    tbl_menu
GROUP BY 
    category_code
WITH ROLLUP;

SELECT
    category_code
  , orderable_status
  , COUNT(*)
FROM 
    tbl_menu
GROUP BY
    category_code, orderable_status
WITH ROLLUP -- 첫번째 컬럼 기준으로 중간집계 + 최종집계
ORDER BY
    category_code IS NULL;

/*
    ## 집합연산자(Set Operator) ##
    여러개의 질의 결과를 컬럼끼리 연결하여 하나의 ResultSet을 만드는 방식 
    
    - UNION     : 합집합 (중복값은 한번만 포함)
    - UNION ALL : 합집합 + 교집합 (중복값이 여러번 포함)
    - INTERSECT : 교집합 (MySQL에서 지원x)
    - MINUS     : 차집합 (MySQL에서 지원x)
*/

-- 카테고리별 메뉴 개수 조회 
SELECT category_code, COUNT(*)
FROM tbl_menu
WHERE category_code = 4
UNION
SELECT category_code, COUNT(*)
FROM tbl_menu
WHERE category_code = 5
UNION
SELECT category_code, COUNT(*)
FROM tbl_menu
WHERE category_code = 6
UNION
SELECT category_code, COUNT(*)
FROM tbl_menu
WHERE category_code = 8;

-- 카테고리번호가 10이거나 메뉴가격이 9000원 미만인 메뉴 조회

SELECT
    menu_code
  , menu_name
  , menu_price
  , category_code
FROM
    tbl_menu
WHERE
    category_code = 10; -- 6(우럭,생갈치,갈릭,정어리,날치알,아이스)

 SELECT
    menu_code
  , menu_name
  , menu_price
  , category_code
FROM
    tbl_menu
WHERE 
    menu_price < 9000; -- 9(열무,"우럭","생갈치","갈릭",코다리,"날치알",직화,"아이스",돌미나리)

-- 5개의 중복 데이터 존재 

-- UNION : 두 쿼리의 결과값을 합친 결과(중복데이터는 한번만 포함됨)
SELECT
    menu_code
  , menu_name
  , menu_price
  , category_code
FROM
    tbl_menu
WHERE
    category_code = 10
UNION
SELECT
    menu_code
  , menu_name
  , menu_price
  , category_code
FROM
    tbl_menu
WHERE 
    menu_price < 9000; -- 6 + 9 - 5 => 10개행 


-- UNION ALL : 두 쿼리의 결과를 합친 결과 (중복허용)
SELECT
    menu_code
  , menu_name
  , menu_price
  , category_code
FROM
    tbl_menu
WHERE
    category_code = 10
UNION ALL
SELECT
    menu_code
  , menu_name
  , menu_price
  , category_code
FROM
    tbl_menu
WHERE 
    menu_price < 9000; -- 6 + 9 => 15개행


-- 유의사항
SELECT
    menu_code
  , menu_name
  , menu_price
  , category_code
--  , orderable_status -- SELECT절의 컬럼수가 동일해야됨 
FROM
    tbl_menu
WHERE
    category_code = 10
-- ORDER BY menu_name ASC
UNION ALL
SELECT
    menu_code
  , menu_name
--  , menu_price
  , orderable_status -- 조회되는 컬럼이 다를 경우 첫번째쿼리의 컬럼명이 헤더에 노출됨 
  , category_code
FROM
    tbl_menu
WHERE 
    menu_price < 9000
ORDER BY menu_name; -- ORDER BY절은 마지막 쿼리에서 딱 한번만 작성 가능 