/*
    ## GROUP BY 절
    1. 특정 걸럼 값을 기준으로 전체 행을 서브 그룹으로 그룹화할 수 있음
    2. 둘 이상의 컬럼을 이용해 다중 그룹화 진행 가능
    3. 주로 그룹함수의 통계 함수(SUM,AVG,COUNT,MIN,MAX)를 쓰기 위해 사용
    4. 여러 컬럼 제시 가능
*/

SELECT * FROM tbl_menu;

-- 카테고리별 메뉴 수 조회
-- > category_code 컬럼값이 일치하는 메뉴들끼리 그룹으로 묶기
SELECT
    category_code
    , COUNT(*) # 그룹별 몇개의 컬럼이 속해있는지 출력
    # SELECT에 선언이 가능한 컬럼은 GROUP BY에 선언된 컬럼과 통계함수만 가능함
FROM
    tbl_menu
GROUP BY
    category_code # 8개의 row생성. 8개의 그룹으로 묶임
; 

-- 카테고리별 메뉴 가격 총합 구하기
SELECT
    category_code ## 카테고리별 그룹핑하고
    ,SUM(menu_price) AS 총합 # 가격의 총 합을 구한다
FROM
    tbl_menu
GROUP BY
    category_code
ORDER BY
    총합;
;
-- > 동작 순서 [ FROM -> GROUP BY -> SELECT -> ORDER BY ]


-- 카테고리별 메뉴의 개수, 평균 가격, 최대 가겨ㅛㄱ, 최소 가격 조회
SELECT
    category_code
    , COUNT(*) AS 메뉴개수
    , CAST(AVG(menu_price) AS SIGNED INTEGER) AS 평균가격
    , MAX(menu_price) AS 최대가격
    , MIN(menu_price) AS 최소가격
FROM
    tbl_menu
GROUP BY
    category_code
;

use empdb;
SELECT * FROM employee;

SELECT
    COALESCE(DEPT_CODE, 0)AS 부서코드
    , COUNT(*) AS 부서별사원수
    , SUM(COALESCE(SALARY, 0)) AS 총합
    , FLOOR(AVG(SALARY))AS 평균급여
FROM
    employee
GROUP BY
    DEPT_CODE
;


use menudb;
-- 카테고리+주문가능여부별개수

SELECT
    category_code
    ,orderable_status
    , COUNT(*)
FROM
    tbl_menu
GROUP BY
    category_code
    , orderable_status
ORDER BY
    category_code
;


-- 메뉴명 길이 별로
SELECT
    CHAR_LENGTH(menu_name)
    , COUNT(*)
FROM
    tbl_menu
GROUP BY
    CHAR_LENGTH(menu_name)
;

/*
    ## HAVING 절
    1. GROUP BY절에 의해 생성된 서브 그룹을 대상으로 조건을 지정하는 절
    2. 그룹 함수를 이용한 조건은 HAVING 절에서 처리 가능 - WHERE절 불가능
    
    
    HAVING은 집계 결과가 나온 후 필터링을 적용하는 단계.
    즉, HAVING은 그룹화된 결과를 필터링할 때만 사용하고, WHERE은 개별 행을 필터링할 때 사용하면 됨.
*/
-- 카테고리별 메뉴의 개수가 1개인 카테고리를 조회
SELECT
    category_code
    , COUNT(*)
FROM
    tbl_menu
GROUP BY
    category_code
HAVING
    COUNT(*) = 1 ## 원래 조건은 WHERE절에 작성해야하지만 GROUP BY후에는 HAVING절을 사용한다.
;


-- 카테고리별 메뉴 총가격이 25000원인 이상의 카고리 조회
SELECT
    category_code
    , SUM(menu_price)
FROM
    tbl_menu
GROUP BY
    category_code
HAVING
    SUM(menu_price) >= 25000
;

-- ==============================================-===========================================================실습
use empdb;

-- 1. 부서별 평균급여가 300만원 이상인 부서 조회
SELECT
    DEPT_CODE
    , FLOOR(AVG(SALARY)) AS 평균급여
FROM
    employee
GROUP BY
    DEPT_CODE
HAVING
    평균급여 >= 3000000
;

-- 2. 부서별 보너스를 받는 사원이 없는 부서를 조회
SELECT
    DEPT_CODE
    ,BONUS
    , COUNT(*)
FROM
    employee
GROUP BY
    DEPT_CODE, BONUS # 부서별로 한번 나뉘고 또 거기에 보너스가 있는지 없는지 나뉨
HAVING
    BONUS IS NULL
;
-- > 보너스를 받는 경우도 있기 때문에 오답

SELECT
    DEPT_CODE
    ,COUNT(BONUS) ## NULL은 새지않음
FROM
    employee
GROUP BY
    DEPT_CODE
HAVING
    COUNT(BONUS) = 0
;



/*
    ## WITH ROLLUP
    그룹별 산출된 결과의 최종집계 및 중간집계를 계산해주는 함수
*/
use menudb;

SELECT
    category_code
    ,SUM(menu_price)
FROM
    tbl_menu
GROUP BY
    category_code
WITH ROLLUP # 한번더 최종 총합
;

SELECT 
    category_code
    ,orderable_status
    , COUNT(*)
FROM
    tbl_menu
GROUP BY
    category_code, orderable_status
WITH ROLLUP -- 중간 집계 추가
ORDER BY
    category_code
    , orderable_status
;

-- UNION 합쳐서 출력, 중복된 데이터는 한번만 출력


SELECT
    menu_code
    ,menu_name
    ,menu_price
    ,category_code
FROM
    tbl_menu
WHERE
    category_code = 10 # 6개 
UNION
SELECT
    menu_code
    ,menu_name
    ,menu_price
    ,category_code
FROM
    tbl_menu
WHERE
    menu_price < 9000; # 9개



SELECT
    menu_code
    ,menu_name
    ,menu_price
    ,category_code
FROM
    tbl_menu
WHERE
    category_code = 10 # 6개 
UNION ALL                       -- UNION ALL 유의사항 묶은 SELECT절의 컬럼 수가 동일해야함(종류는 달라도 됨)
SELECT
    menu_code
    ,menu_name
    ,menu_price
    ,category_code
FROM
    tbl_menu
WHERE
    menu_price < 9000 # 9개
ORDER BY
    menu_name # ORDER BY는 마지막에 한번만 작성
;


















