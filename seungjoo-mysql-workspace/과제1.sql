USE empdb;
SELECT * FROM department;   -- 부서
SELECT * FROM job;          -- 직급 
SELECT * FROM emploYEE;     -- 사원
SELECT * FROM sal_grade;    -- 급여등급
SELECT * FROM nation;       -- 국가
SELECT * FROM location;     -- 지역
-- 1.
SELECT e.EMP_NAME as emp_name
        ,e.salary as salary
        ,e.SALARY*12 as "salary*12"
        
FROM 
    emploYEE e

WHERE e.salary >= 3000000;

-- 2.
SELECT e.EMP_NAME as emp_name
        ,e.salary as salary
        ,e.SALARY*12 as 연봉
        , e.DEPT_CODE AS dept_code

FROM 
    emploYEE e

WHERE e.salary*12 >= 50000000;


-- 3. 
SELECT e.emp_name as emp_name

FROM emploYEE e

WHERE e.emp_name LIKE "%연";


-- 4. 

SELECT e.emp_name as emp_name
    , e.phone as pHone
FROM
    EMPLOYEE e
WHERE
    SUBSTRING(e.phone, 1,3) <> '010';
    
-- 5
SELECT 
    *
FROM 
    EMPLOYEE e
WHERE INSTR(e.email,'_') = 5 AND
    (dept_code = 'D9' OR dept_code = 'D5') AND
    e.hire_date BETWEEN '1990-01-01' AND '2001-12-31' AND
    e.salary>= 2700000;


-- 6 
SELECT 
    e.emp_name as emp_name
FROM
    EMPLOYEE e
ORDER BY  e.emp_name ASC;

-- 7
SELECT e.emp_id AS emp_id
    ,e.emp_name AS emp_name
    ,e.phone AS phone
    ,e.hire_date AS hire_date
    ,e.quit_yn AS quit_yn
FROM 
    EMPLOYEE e
WHERE
    e.emp_name LIKE '%2' AND
    e.quit_date IS NOT NULL
ORDER BY e.hire_date desc
LIMIT 3;

-- 8
SELECT e.emp_id AS emp_id
    , e.emp_name AS emp_name
FROM 
    EMPLOYEE e
WHERE e.manager_id IS NULL;
    
    

    