-- GROUPING

-- GROUP BY 절

SELECT * FROM tbl_menu;

-- 카테고리별 메뉴 수 조회
-- => category_code 컬럼 값이 일치하는 메뉴들끼리 그룹으로 묶기
SELECT
    category_code
    , COUNT(*)
    -- 그밖에 다른 column은 조회 불가
FROM
    tbl_menu
GROUP BY
    category_code;

-- 카테고리별 메뉴 가격 총합 구하기
SELECT              -- 3
    category_code
    , SUM(menu_price) AS '총합'
FROM                -- 1
    tbl_menu
GROUP BY            -- 2
    category_code
ORDER BY            -- 4
    총합;

-- 불러온 테이블을 해당 컬럼값을 기준으로 그룹을 만든 뒤 그것을 표출 및 함수 진행

-- 카테고리 별 메뉴의 개수, 평균가격, 최대가격, 최소가격 조회
SELECT * FROM menudb.tbl_menu;
SELECT
    category_code
    , COUNT(*) 개수
    , FLOOR(AVG(menu_price)) 평균가격
    , MAX(menu_price) 최대가격
    , MIN(menu_price) 최소가격
FROM
    tbl_menu
GROUP BY
    category_code;

-- ------------------------------------------------------------

USE empdb;

SELECT * FROM employee;

-- 부서별 사원수, 총 급여합, 평균급여
SELECT
    dept_code
    , COUNT(*) AS 사원수
    , SUM(salary) AS '총 급여합'
    , FLOOR(AVG(salary)) AS 평균급여
FROM
    employee
GROUP BY
    dept_code;

-- -------------------------------------------
USE menudb;

-- 카테고리 + 주문가능여부별 개수
SELECT
    category_code
    , orderable_status
    , COUNT(*)
FROM
    tbl_menu
GROUP BY
    category_code, orderable_status
ORDER BY
    category_code;

-- 메뉴명길이별로
SELECT
    CHAR_LENGTH(menu_name)
    , COUNT(*)
FROM
    tbl_menu
GROUP BY
    CHAR_LENGTH(menu_name);

-- ===================================================
-- HAVING 절

-- 카테고리 별 메뉴의 개수가 1개인 카테고리를 조회
SELECT
    category_code
    , COUNT(*)
FROM
    tbl_menu
-- WHERE COUNT(*) = 1 -- Error : invaild use of group function
-- *수행순서에 따라 해당 구문이 실행될 수 없음
GROUP BY
    category_code
HAVING
    COUNT(*) = 1;

-- 카테고리별 메뉴총가격이 25000원 이상인 카테고리 조회
SELECT
    category_code
    , SUM(menu_price) AS 메뉴총가격
FROM
    tbl_menu
GROUP BY
    category_code
HAVING
    SUM(menu_price) > 25000;

-- ---------------------------------------------------------
USE empdb;

SELECT * FROM employee;
-- 부서별 평균 급여가 300만원 이상인 부서 조회
SELECT
    dept_code
    , FLOOR(AVG(salary))
FROM
    employee
GROUP BY
    dept_code
HAVING
    FLOOR(AVG(salary)) > 3000000;

-- 부서별 보너스를 받는 사원이 없는 부서를 조회
SELECT
    dept_code
    , COUNT(*) 사원수
    , COUNT(bonus) '보너스를 받는 사원수'
FROM
    employee
GROUP BY
    dept_code
HAVING
    -- SUM(bonus) IS NULL;
    COUNT(bonus) = 0;

-- ------------------------------------------------------
USE menudb;

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
WITH ROLLUP -- 첫번째 COLUMN 기준으로 소계 + 총계
ORDER BY
    category_code IS NULL;

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
SELECT menu_code, menu_name, menu_price, category_code
FROM tbl_menu
WHERE category_code = 10
UNION
SELECT menu_code, menu_name, menu_price, category_code
FROM tbl_menu
WHERE menu_price < 9000;

-- UNION ALL
SELECT menu_code, menu_name, menu_price, category_code
FROM tbl_menu
WHERE category_code = 10
UNION ALL
SELECT menu_code, menu_name, menu_price, category_code
FROM tbl_menu
WHERE menu_price < 9000
ORDER BY menu_name;

-- 유의사항
SELECT menu_code, menu_name, menu_price, category_code
FROM tbl_menu
WHERE category_code = 10
UNION ALL
SELECT menu_code, menu_name, orderable_status, category_code
FROM tbl_menu
WHERE menu_price < 9000
ORDER BY menu_name; -- ORDER BY 절은 마지막 쿼리에서 딱 한번만 작성 가능