-- 카테고리가 부여되지 않은 메뉴 데이터 한 개 추가하기 
INSERT INTO tbl_menu VALUES(null, '찰순대쥬스', 7000, null, 'Y');
SELECT * FROM tbl_menu;

/*
    ## JOIN ##
    1. 두 개 이상의 테이블에서 데이터를 조회할 때 사용되는 구문 
       [
          테이블을 합쳐서 조회하는 방법 
          1) union : 세로로 데이터를 합침 
          2) join  : 가로로 데이터를 합침 
       ]
    2. 연결을 시킬때는 반드시 연관성이 있는 컬럼을 기준으로 조인
    3. 종류
       1) EQUI JOIN : 두 컬럼가지고 동등비교(=)를 통해서 조인하는 방식
          - 내부 조인 (INNER JOIN) : 교집합 (일반적으로 사용하는 JOIN)
          - 외부 조인 (OUTER JOIN) : 합집합 
          - 교차 조인 (CROSS JOIN) : 곱집합 
          - 자가 조인 (SELF JOIN)
          - 다중 조인 (MULTIPLE JOIN)
       2) NON-EQUI JOIN : 동등조건(=)이 아닌 BETWEEN AND, IN, IS NULL 등 에 의한 조인 
*/

/*
    ## 내부 조인 (Inner Join) ##
    두 테이블간에 연관성이 있는 컬럼으로 =을 통해 매칭시켜 조회 
    만약 일치하는 행이 존재하지 않을 경우 조회에서 제외됨 
*/

-- 메뉴 - 22개행
-- 카테고리 - 12개행

-- 전체 메뉴의 메뉴명, 카테고리명을 조회 

-- ON 방식 : ON 뒤에 매칭시킬 컬럼에 대한 조건 작성 
--           단, 두 컬럼명이 동일할 경우 각 테이블의 별칭을 활용해서 작성 (아니면 ambiguous 발생)
SELECT
    menu_name
  , menu_price
  , category_name
  , ref_category_code
FROM
    tbl_menu m
    /*INNER*/ JOIN tbl_category c ON c.category_code = m.category_code;
    
-- 좌측 tbl_menu의 category_code가 null인 1개의 행 제외 
-- 우측 tbl_category의 category_code가 1,2,3,7인 4개의 행 제외

-- USING 방식 : 매칭시킬 컬럼명이 동일할 경우 사용가능한 방식 
--              USING 구문 뒤에 매칭시킬 컬럼명 한개만 작성하면됨 
SELECT
    menu_code
  , menu_name
  , category_name
FROM
    tbl_menu
    JOIN tbl_category USING(category_code);
    
-- empdb 연습
use empdb;

SELECT * FROM employee;   -- 사원 데이터 (부서코드:dept_code, 직급코드:job_code)  -> 24 row
SELECT * FROM department; -- 부서 데이터 (부서코드:dept_id)                       -> 9 row
SELECT * FROM job;        -- 직급 데이터                     (직급코드:job_code)  -> 7 row

-- 사원 데이터 조회시 부서명도 같이 조회 
SELECT
    emp_id
  , emp_name
  , emp_no
  , dept_title
FROM
    employee
    JOIN department ON dept_id = dept_code; -- 22개의 행 조회 

-- 사원 데이터 조회 직급명도 같이 조회 
SELECT
    emp_id
  , emp_name
  , job_name
FROM
    employee e
--    JOIN job j ON j.job_code = e.job_code;
--    JOIN job USING(job_code);
    NATURAL JOIN job; -- 매칭시킬 컬럼이 두 테이블간에 단 한개만 존재할 경우 NATURAL JOIN도 가능 

-- 대리 직급인 사원만 조회하기 
SELECT
    emp_name
  , job_name
FROM
    employee e
    JOIN job j ON j.job_code = e.job_code
WHERE
    job_name = '대리';

-- 실습. 인사관리부인 사원의 사번, 이름, 보너스 조회 
SELECT
    emp_id
  , emp_name
  , bonus 
--  , dept_title
FROM 
    employee
    JOIN department ON dept_id = dept_code
WHERE
    dept_title = '인사관리부';

-- 실습. department과 location을 참고해서 전체 부서들의 부서코드, 부서명, 근무지역명 조회 
SELECT * FROM department; -- location_id(지역코드)
SELECT * FROM location;   -- local_code(지역코드)

SELECT
    dept_id
  , dept_title
  , local_name
FROM
    department
    JOIN location ON local_code = location_id;
