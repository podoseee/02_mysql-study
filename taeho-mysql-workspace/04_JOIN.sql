-- 카테고리가 부여되지 않은 메뉴 데이터 한 개 추가하기
use menudb;
INSERT INTO tbl_menu VALUES(null, '찰순대',7000, null, 'Y');

/*
    ## JOIN ##
    1. 두 개 이상의 테이블에서 데이터를 조회할 때 사용되는 구문
    [
        테이블을 합쳐서 조회하는 방법
        1) union    : 세로로 데이터를 합침
        2) join       : 가로로 데이터를 합침
    ]
    2. 연결을 시킬때는 반드시 연관성이 있는 컬럼을 기준으로 JOIN 실행
    3. 종류
        1) EQUI JOIN : 두 컬럼을 가지고 동등비교를 통해 조인하는 방식
            - 내부 조인 (INNER JOIN)        : 교집합
            - 외부 조인 (OUTER JOIN)       : 합집합
            - 교차 조인 (CROSS JOIN)       : 곱집합
            - 자가 조인 (SELF JOIN)
            - 다중 조인 (MULTIPLE JOIN)
        2) NON EQUI JOIN : 동등 조건이 아닌 BETWEEN ADN, IN , IS NULL 등에 의한 조인
*/

/*
    ## 내부 조인 (Inner Join) ##
    - 두 테이블 간에 연관성이 있는 컬럼을 = 을 통해 매칭시켜 JOIN
    - 일치하지 않는 행이 존재하지 않을 경우 조회에서 제외
*/

SELECT menu_name, tbl_menu.category_code FROM tbl_menu
INNER JOIN tbl_category ON tbl_category.category_code = tbl_menu.category_code;

-- 좌측 tbl_meny의 category_code 가 null 인 행 제외
SELECT menu_name, category_code, category_name FROM tbl_menu m
INNER JOIN tbl_category c ON c.category_code = m.category_code;

-- 전체 메뉴의 메뉴명, 카테고리 명을 조회
-- on 방식: on 뒤에 매칭시킬 럼럼에 대한 조건을 작성
--              단, 두 컬럼명이 동일한 경우 각 테이블의 별칭을 활용해서 작성
SELECT menu_name, menu_price, category_name, ref_category_code FROM tbl_menu m
JOIN tbl_category c ON c.category_code = m.category_code;

-- USING 방식 : 매칭시킬 컬럼명이 동일한 경우 사용 가능한 방식
--                      USING 구문 뒤에 매칭시킬 컬럼명 한개만 작성
SELECT menu_code, menu_name, category_name
FROM tbl_menu
JOIN tbl_category USING(category_code);

-- change empdb;
use empdb;

SELECT
    emp_id
    , emp_name
    , emp_no
    , dept_title
FROM employee
JOIN department ON dept_id = dept_code;

-- 사원 데이터 조회 직급명도 같이 조회
SELECT
    emp_id
    , emp_name
    , job_name
FROM employee e 
-- JOIN job j ON j.job_code = e.job_code;
JOIN job USING(job_code)
WHERE job_name = '대리';

-- 인사관리부인 사원의 사번, 이름, 보너스 조회
SELECT * FROM employee;
SELECT * FROM department;
SELECT e.EMP_NO, e.EMP_NAME, e.BONUS 
FROM employee e
JOIN department d
ON e.DEPT_CODE = d.DEPT_ID;

-- department와 location을 참고해서 전체 부서들의 부서코드, 부서명, 근무지역명 조회
SELECT * FROM department;
SELECT * FROM location;

SELECT d.DEPT_ID, d.DEPT_TITLE, l.LOCAL_NAME 
FROM department d
JOIN location l 
ON d.LOCATION_ID = l.LOCAL_CODE;

-- 보너스를 받는 사원의 사번, 사원명, 보너스, 부서명 조회

SELECT 
    e.EMP_ID
    , e.EMP_NAME
    , e.BONUS
    , d.DEPT_TITLE
FROM employee e
LEFT JOIN department d 
ON d.DEPT_ID = e.DEPT_CODE
WHERE bonus IS NOT NULL;

-- 부서가 총무부가 아닌 사원의 사원명, 급여 조회
SELECT emp_name, salary
FROM employee
JOIN department
ON (dept_id= dept_code)
WHERE dept_code != 'D9';

    dept_title != '총무부';

/*
    ## 외부 조인 (Outer Join) ##
    좌측/우측 테이블을 기준으로 조인시키는 방법 
    기준이 되는 테이블에는 누락되는 행 없이 조회됨 
    즉, Inner Join에서 특정 테이블에 누락된 행을 같이 조회시키고자 할 때 사용
*/

-- Inner Join (메뉴테이블에 1개 행 누락, 카테고리테이블에 4개 행 누락)
SELECT
    menu_name
  , category_name
FROM
    tbl_menu
        JOIN tbl_category USING(category_code);

-- LEFT OUTER JOIN
SELECT
    menu_name
  , category_name
FROM
    tbl_menu
        LEFT /*OUTER*/ JOIN tbl_category USING(category_code); -- 카테고리 번호가 NULL이였던 메뉴 1개 추가적으로 조회됨

-- RIGHT OUTER JOIN
SELECT
    menu_name
  , category_name
FROM
    tbl_menu
        RIGHT JOIN tbl_category USING(category_code); -- 카테고리 번호가 1,2,3,7 이였던 카테고리 4개 추가적으로 조회됨

use empdb;

-- 전체 사원에 대해 사원명, 부서명, 급여 조회 
SELECT
    emp_name
  , IFNULL(dept_title, '없음')
  , salary
FROM
    employee
        LEFT JOIN department ON dept_id = dept_code;

/*
    ## 교차 조인 (Cross Join, Cartesian Product) ## 
    모든 테이블의 각 행들이 서로 매핑된 데이터가 조회됨 (곱집합)
    두 테이블의 행들이 모두 곱해진 행들의 조합이 출력
*/
use menudb;
SELECT
    menu_name
  , category_name
FROM
    tbl_menu
    CROSS JOIN tbl_category;

/*
    ## 자가 조인 (SELF JOIN) ## 
    조인 할 때 다른 테이블이 아닌 자기 자신과 조인을 맺는 방식
*/
SELECT * FROM tbl_category;

-- 카테고리명과 상위카테고리명을 조회
SELECT
    c1.category_code
  , c1.category_name
  , c1.ref_category_code
  , c2.category_code
  , c2.category_name
FROM
    tbl_category c1  -- c1.ref_category_code와 일치하는 카테고리번호를 가진 카테고리명을 조회 
        JOIN tbl_category c2 ON c2.category_code = c1.ref_category_code
;

use empdb;
-- 실습. 사원명과 사수명을 조회하시오.
--       사수에 대한 정보는 manager_id를 통해 기록하고 있음 
SELECT
    e1.emp_name 사원명
--  , e1.manager_id
--  , e2.emp_id
  , IFNULL(e2.emp_name, '없음') 사수명
FROM
    employee e1
        LEFT JOIN employee e2 ON e2.emp_id = e1.manager_id;

/*
    ## 비등가조인 (NON-EQUI JOIN) ##
    매칭시킬 컬럼에 대한 조건을 =이 아니라 다른 연산자로 할 경우
*/
SELECT * FROM employee; -- salary
SELECT * FROM sal_grade; -- min_sal, max_sal

-- 사원명, 급여, 급여등급
SELECT
    emp_name
  , salary
  , s.sal_level
FROM
    employee e
        JOIN sal_grade s ON e.salary BETWEEN s.min_sal AND s.max_sal;

/*
    ## 다중 조인 (Multiple Join) ##
*/
-- 사번, 사원명, 부서명, 직급명
SELECT * FROM employee;   -- dept_code, job_code
SELECT * FROM department; -- dept_id
SELECT * FROM job;        --            job_code

SELECT
    emp_id
  , emp_name
  , dept_title
  , job_name
FROM
    employee e
        LEFT JOIN department ON dept_id = dept_code
        JOIN job j ON j.job_code = e.job_code;

-- 실습. 사번, 사원명, 근무지역명 
SELECT * FROM employee;   -- dept_code
SELECT * FROM department; -- dept_id    location_id
SELECT * FROM location;   --            local_code

SELECT
    emp_id
  , emp_name
  , local_name
--    *
FROM
    employee
        JOIN department ON dept_id = dept_code
        JOIN location ON local_code = location_id;

-- 실습. 사번, 사원명, 부서명, 근무지역명, 근무국가명, 직급명 조회 (24개 행이 나오도록)
SELECT
    emp_id
  , emp_name
  , dept_title
  , local_name
  , national_name
  , job_name
FROM
    employee
        LEFT JOIN department ON dept_id = dept_code
        LEFT JOIN location ON location_id = local_code
        LEFT JOIN nation USING(national_code)
        JOIN job USING(job_code);


