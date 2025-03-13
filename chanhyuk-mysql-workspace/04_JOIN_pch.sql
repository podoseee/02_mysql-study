select * from tbl_menu;

-- 카테고리가 부여되지 않은 메뉴 데이터 한 개 추가하기
INSERT INTO tbl_menu VALUES(null, "찰순대쥬스", 7000, null, 'Y');

/*
    ## JOIN ##
    1. 
    [
        테이블을 합쳐서 조회하는 방법
        1) union: 세로로 데이터를 합침
        2) join : 가로로 데이터를 합침
    ]
    2. 연결을 싴리때는 반드시 연관성이 있는 컬럼을 기준으로 조인
    3. 종류
        1) EQUI JOIN : 두 컬럼으로 동등비교를 통해 조인하는 방식
            - 내부 조인 (INNER JOIN) : 교집합 (일반적 JOIN)
            - 외부 조인 (OUTER JOIN) : 합집합
            - 교차 조인 (CROSS JOIN) : 곱집합
            - 자가 조인 (SELF JOIN)
            - 다중 조인 (MULTIPLE JOIN)
        2) NON-EQUI JOIN : 동등조건(=) 이 아닌 BETWEEN AND, IN, IS NULL 등에 의한 조건
*/

/*
    ## 내부 조인 (INNER JOIN) ##
    두 테이블간에 연관성이 있는 컬럼으로 =을 통해 매칭시켜 조회
    만약 일치하는 행이 존재하지 않을 경우 조회에서 제외됨
*/

-- 전체 메뉴의 메뉴명, 카테고리명 조회
SELECT 
    a.menu_name,
    b.category_name
FROM 
    tbl_menu a
-- INNER JOIN tbl_category b ON a.category_code = b.category_code;
JOIN tbl_category b ON a.category_code = b.category_code;




-- empdb 연습
use empdb;
select * from employee;     -- 사원 데이터(부서코드 : dept_code, 직급코드:job_code) -> 24row
SELECT * FROM department;   -- 부서 데이터(부서코드 : dept_id                     ) -> 9 row
select * from job;          -- 직급 데이터(                      직급코드:job_code) -> 7 row
select
    emp_id
,   emp_name
,   emp_no
,   dept_title
from
    employee
    join department ON dept_id = dept_code;

-- 부서가 총무부가 아닌 사원의 사원명, 급여 조회
SELECT
    emp_name
,   salary
FROM
    employee
    JOIN department ON (dept_id = dept_code)
WHERE
    dept_title != '총무부';



/*
    ## 외부 조인 (Outer Join) ##
    좌측/우측 테이블을 기준으로 조인시키는 방법
    기준이 되는 테이블에는 누락되는 행 없이 조회됨
    즉, Inner Join에서 특정 테이블에 누락된 행을 같이 조회시키고자 할 때 사용
*/

-- Inner Join
SELECT
    menu_name
    ,category_name
FROM
    tbl_menu
        RIGHT JOIN tbl_category USING(category_code);


SELECT
    menu_name
    ,category_name
from
    tbl_menu
    CROSS JOIN tbl_category;
    
    
/*
    ## 자가 조인 (SELF JOIN) ##
*/

use empdb;
-- 실습. 사번, 사원명, 근무지역명
SELECT
    emp_id
,   emp_name
,   local_name
FROM
    employee
    JOIN department ON dept_id = dept_code
    JOIN location ON local_code = location_id;

-- 사번, 사원명, 부서명, 근무지역명,  근무국가명, 직급명 조회
select * from employee;
select * from department;
select * from job;
select * from location;
select * from nation;
select emp_id, emp_name, dept_title, local_name, national_name, job_name 
from
    employee e
    LEFT join department d on e.dept_code = d.dept_ID
    LEFT join location l on l.local_code = d.location_id
    LEFT join nation n on n.national_code = l.national_code
    LEFT JOIN job j on j.job_code = e.job_code;
















