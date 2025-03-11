INSERT INTO tbl_menu VALUES(null, '찰순대쥬스', 7000, null,'Y');

SELECT * FROM tbl_menu;

SELECT
    menu_name
  , category_code
FROM
    tbl_menu
    INNER JOIN tbl_category USING (category_code) ;

SELECT
    menu_name
 , category_name
FROM
    tbl_menu m
    JOIN tbl_category c ON m.category_code = c.category_code ;
    -- JOIN tbl_category USING (category_code) ;
    
use empdb;

SELECT
    emp_id
  , emp_name
  , emp_no
  , dept_title
FROM
    employee
    JOIN department ON dept_id = dept_code;

SELECT
    emp_id
  , emp_name
  , job_name
FROM
    employee e
    -- JOIN job j ON e.job_code = j.job_code;
    NATURAL JOIN job;
    
SELECT
    *
FROM
    employee e
    JOIN job j ON j.job_code = e.job_code
WHERE
    job_name = '대리';

SELECT * FROM employee;
-- 인사관리부 사원 사번, 이름, 보너스
SELECT
    EMP_ID
  , EMP_NAME
  , BONUS
FROM
    employee e
    JOIN department d ON d.DEPT_ID = e.DEPT_CODE
WHERE
    DEPT_TITLE = '인사관리부';
-- department, location -> 전체 부서 부서코드, 부서명, 근무지역명 조회
SELECT * FROM department;
SELECT * FROM location;
SELECT 
    d.DEPT_ID
  , d.DEPT_TITLE
  , l.NATIONAL_CODE
FROM
    department d
    JOIN location l ON l.LOCAL_CODE = d.LOCATION_ID;
    
SELECT
    e.EMP_ID
  , e.EMP_NAME
  , e.BONUS
  , d.DEPT_TITLE
FROM
    employee e
    LEFT OUTER JOIN department d ON  e.DEPT_CODE = d.DEPT_ID
WHERE
    bonus IS NOT NULL;

SELECT
    EMP_NAME
  , SALARY
FROM
    employee e
    JOIN department d ON d.DEPT_ID = e.DEPT_CODE
WHERE
    DEPT_TITLE != '총무부';