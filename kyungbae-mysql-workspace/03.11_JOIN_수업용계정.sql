-- 카테고리가 부여되지 않은 메뉴 데이터 추가하기
INSERT INTO tbl_menu VALUES(null, '찰순대쥬스', 7000, null, 'Y');

SELECT * FROM tbl_menu;

-- 내부 조인 (Inner Join)
-- 전체 메뉴의 메뉴명, 카테고리명을 조회
-- 메뉴 - 22개행 , 카테고리 - 12개행
SELECT
    menu_name
    , m.category_code
    , category_name
FROM
    tbl_menu m
    /*INNER*/ JOIN tbl_category c ON m.category_code = c.category_code;
-- ON 방식 : ON 뒤에 매칭시킬 컬럼에 대한 조건 작성

-- USING 방식
SELECT
    menu_code
    , menu_name
    , category_name
FROM
    tbl_menu
    JOIN tbl_category USING(category_code);
    
-- ----------------------------------------------
use empdb;

SELECT * FROM employee; -- 사원데이터 (부서코드 : dept_code, 직급코드 : job_code)
SELECT * FROM department; -- 부서 데이터 (부서코드 : dept_id
SELECT * FROM job; -- 직급 데이터 ( 직급코드 : job_code)

SELECT
    emp_id
    , emp_name
    , emp_no
    , dept_code
    , dept_title
    , e.job_code
    , job_name
FROM
    employee e
    JOIN department d ON dept_code = dept_id
    JOIN job j ON e.job_code = j.job_code
ORDER BY
    dept_code, job_code DESC, emp_name;

SELECT
    emp_id
    , emp_name
    , job_name
FROM
    employee e
    -- JOIN job j ON e.job_code = j.job_code;
    -- JOIN job USING(job_code);
    NATURAL JOIN job;

-- 대리 직급인 사원만 조회하기
SELECT
    emp_name
    , job_name
FROM
    employee e
    JOIN job j ON j.job_code = e.job_code
WHERE
    job_name = '대리';

-- 실습. 인사관리부 사원의 사번, 이름, 보너스 조회
SELECT * FROM employee;
SELECT * FROM job;
SELECT * FROM department;
SELECT * FROM location;

SELECT
    emp_id
    , emp_name
    , bonus
FROM
    employee
    JOIN department ON dept_code = dept_id
WHERE
    dept_title = '인사관리부'
;

-- 실습. department / location 전체 부서들의 부서코드, 부서명, 근무지역명 조회
SELECT
    dept_id
    , dept_title
    , local_name
FROM
    department
    JOIN location ON local_code = location_id;

-- 실습. 보너스를 받는 사원의 사번, 사원명, 보너스, 부서명 조회
SELECT
    emp_id
    , emp_name
    , bonus
    , dept_title
FROM
    employee
    LEFT JOIN department ON dept_id = dept_code
WHERE
    bonus IS NOT NULL;
    
    
-- 실습. 부서가 총무부가 아닌 사원의 사원명, 급여조회
SELECT
    emp_name
    , salary
FROM
    employee
    JOIN department ON dept_id = dept_code
WHERE
    dept_title != '총무부';
    
-- ===========================================================================
-- 외부조인 OUTER JOIN
USE menudb;

-- inner join
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
    LEFT JOIN tbl_category USING(category_code); 
    -- 카테고리 번호가 NULL이였던 메뉴 조회

-- RIGHT OUTER JOIN
SELECT
    menu_name
    , category_name
FROM
    tbl_menu
    RIGHT JOIN tbl_category USING(category_code); 
    -- 카테고리 번호가 1,2,3,7 이였던 카테고리 4개 추가적으로 조회
    
-- -------------------------------------------------------------------------
USE empdb;
-- 전체 사원에 대해 사원명, 부서명, 급여 조회
SELECT
    emp_name
    , IFNULL(dept_title, '대기중')
    , salary
FROM
    employee e
    LEFT JOIN department d ON e.dept_code = d.dept_id
;

-- =========================================================================
-- 교차조인 CROSS JOIN
USE menudb;
SELECT
    menu_name
    , category_name
FROM
    tbl_menu
    /*CROSS*/ JOIN tbl_category;
    
-- 자가조인 SELF JOIN
SELECT * FROM tbl_category;
SELECT
    a.category_code
    , a.category_name
    , a.ref_category_code
    , b.category_code
    , b.category_name
FROM
    tbl_category a
    JOIN tbl_category b ON b.category_code = a.ref_category_code;

use empdb;
-- 사원명과 사수명을 조회
SELECT * FROM employee;
SELECT
    a.emp_name 사원명
    , b.emp_name 사수명
FROM
    employee a
    JOIN employee b ON b.emp_id = a.manager_id;

-- 비등가조인 (NON-EQUI JOIN)
SELECT * FROM employee;
SELECT * FROM sal_grade;

-- 사원명, 급여, 급여등급
SELECT
    emp_name
    , e.sal_level
    , salary
    , s.sal_level
FROM
    employee e
    JOIN sal_grade s ON e.salary BETWEEN s.min_sal AND s.max_sal;
/*WHERE
    e.sal_level != s.sal_level;*/

-- 다중조인 (multiple join)
-- 사번, 사원명 부서명, 직급명
SELECT * FROM employee; -- dept_code, job_code
SELECT * FROM department; -- dept_id
SELECT * FROM job; -- job_code
SELECT
    emp_id
    , emp_name
    , dept_title
    , job_name
FROM
    employee e
    LEFT JOIN department d ON dept_id = dept_code
    JOIN job j ON j.job_code = e.job_code;

-- 실습. 사번, 사원명, 부서명, 근무지역명 , 근무국가명, 직급명 조회
SELECT
    emp_id
    , emp_name
    , dept_title
    , local_name
    , national_name
    , job_name
FROM
    employee e
    LEFT JOIN department ON dept_id = dept_code
    LEFT JOIN location l ON local_code = location_id
    LEFT JOIN nation n ON n.national_code = l.national_code
    JOIN job j ON j.job_code = e.job_code;






