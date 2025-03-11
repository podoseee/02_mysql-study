/*
    ## GROUPBY 절 ##
    1. 특정 컬럼 값을 기준으로 전체 행을 서브그룹으로 그룹화시킬 수 있음
    2. 둘 이상의 컬럼을 이용해 다중 그룹화 진행도 가능
    3. 주로 그룹함수의 통계함수를 쓰기 위해 사용
*/

SELECT * FROM tbl_menu;

SELECT COUNT(*), category_code
FROM tbl_menu
GROUP BY category_code;

-- 카테고리별 메뉴 가격 총합 구하기

/*
    ## HAVING 절 ##
    1. GROUP BY절에 의해 생성된 서브 그룹을 대상으로 조건을 지정하는 절 
    2. 그룹 함수를 이용한 조건은 HAVING 저에서 처리할 수 있음 (WHERE절 불가)
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
    COUNT(*) = 1;
;

-- --------------- 실습 ------------------
use empdb;
-- 부서별 평균급여가 300만원 이상인 부서 조회
SELECT * FROM empdb.department;
SELECT * FROM empdb.employee;
SELECT * FROM empdb.department;
SELECT * FROM empdb.department;

SELECT 
    DEPT_CODE
FROM 
    employee
GROUP BY 
    DEPT_CODE
HAVING
    AVG(SALARY) > 3000000
;
use empdb;
-- 부서별 보너스를 받는 사원이 없는 부서를 조회
SELECT 
    DEPT_CODE
FROM 
    employee
GROUP BY 
    DEPT_CODE
HAVING
    COUNT(BONUS) = 0
;

/*
    ## WITH ROLLUP ##
    그룹 별 산출된 결과의 최종집계 및 중간집계를 계산해주는 함수 
*/

use menudb;

SELECT
    category_code 
  , orderable_status
  , COUNT(*)
FROM
    tbl_menu
GROUP BY
      category_code 
    , orderable_status
WITH ROLLUP -- 첫번째 컬럼 기준으로 중간집계 + 최종집계
ORDER BY
    category_code IS NULL
;

/*
    ## 집합연산자(Set Operator)
    여러개의 질의 결과를 컬럼끼리 연결하여 하나의 ResultSet을 만드는 방식 
    
    - UNION     : 합집합 (중복값 한번만 포함)
    - UNION ALL : 합집합 + 교집합 
    - INTERSECT : 교집합
    - MINUS     : 차집합 
*/

-- 카테고리별 메뉴 개수 조회
SELECT 
    menu_name
  , menu_price
FROM
    tbl_menu
WHERE
    menu_price<9000
UNION
SELECT 
    menu_name
  , menu_price
FROM
    tbl_menu
WHERE
    category_code = 10
    
ORDER BY menu_name;
-- order by절은 마지막 쿼리에서 딱 한번만 작성가능 (ex union)





