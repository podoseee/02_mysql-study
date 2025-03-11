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