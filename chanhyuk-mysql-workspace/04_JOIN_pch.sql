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


















