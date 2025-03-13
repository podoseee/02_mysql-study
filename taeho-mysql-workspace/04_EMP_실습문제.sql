use empdb;

-- 1. 재직 중이고 휴대폰 마지막 자리가 2인 직원 중 입사일이 가장 최근인 직원 3명의
--    사원번호, 사원명, 전화번호, 입사일, 퇴직여부를 출력하세요. (JOIN 문제 아님)
SELECT * FROM employee;
SELECT 
emp_id AS '사원번호'
, emp_name AS '사원명'
, phone AS '전화번호'
, hire_date AS '입사일'
, quit_yn AS '퇴직여부'
FROM employee
WHERE quit_yn = 'N'
AND SUBSTRING(PHONE,-1) = '2'
ORDER BY hire_date DESC
LIMIT 3;

-- 2. 재직 중인 ‘대리’들의 직원명, 직급명, 급여, 사원번호, 이메일, 전화번호, 입사일을 출력하세요.
--    단, 급여를 기준으로 내림차순 출력하세요.
SELECT * FROM employee;
SELECT * FROM job;
SELECT 
e.emp_name AS '사원명'
, j.job_name AS '직급명'
, e.salary AS '급여'
, e.emp_no AS '사원번호'
, e.email AS '이메일'
, e.phone AS '전화번호'
, e.hire_date AS '입사일'
 FROM employee e
 JOIN job j
 ON j.job_code = e.job_code
WHERE e.job_code = 'J6'
AND e.quit_yn = 'N'
ORDER BY e.salary DESC;

-- 3. 재직 중인 직원들을 대상으로 부서별 인원, 급여 합계, 급여 평균을 출력하고
--    마지막에는 전체 인원과 전체 직원의 급여 합계 및 평균이 출력되도록 하세요.
--    단, 출력되는 데이터의 헤더는 컬럼명이 아닌 ‘부서명’, ‘인원’, ‘급여합계’, ‘급여평균’으로 출력되도록 하세요. 
--    Hint. ROLLUP사용
select * from employee;
select * from department;

SELECT 
d.dept_title AS '부서명'
,COUNT(*) AS '인원'
, SUM(e.salary)  AS '급여합계'
, AVG(e.salary) AS '급여평균'
FROM employee e
JOIN department d ON d.dept_id = e.dept_code
WHERE quit_yn = 'N'
GROUP BY e.dept_code, d.dept_title
WITH ROLLUP
HAVING
GROUPING(e.dept_code) = 1
OR GROUPING(d.dept_title) = 0;

-- 4. 전체 직원의 사원명, 주민등록번호, 전화번호, 부서명, 직급명을 출력하세요.
--    단, 입사일을 기준으로 오름차순 정렬되도록 출력하세요.
SELECT * FROM employee;
select * from department;
select * from job;

SELECT
e.emp_name AS '사원명'
, e. emp_no AS '주민등록번호'
, e.phone AS '전화번호'
, d.dept_title AS '부서명'
, j.job_name AS '직급명'
FROM employee e
LEFT JOIN department d ON d.dept_id = e.dept_code
JOIN job j ON j.job_code = e.job_code 
ORDER BY e.hire_date;

-- 5. 직급이 대리이면서 ASIA 지역에 근무하는 직원들의 사번, 사원명, 직급명, 부서명을 조회하시오.
select * from employee;
select * from job;
select * from department;
select * from location;

SELECT
e.emp_id AS '사번'
, e.emp_name AS'사원명'
, j.job_name AS '직급명'
, d.dept_title AS ' 부서명'
FROM employee e
JOIN job j ON j.job_code = e.job_code
JOIN department d ON d.dept_id = e.dept_code
JOIN location l ON l.local_code = d.location_id
WHERE e.job_code = 'J6'
AND l.local_code IN ('L1', 'L2', 'L3');

-- 6. 70년대 생이면서 성별이 여자이고 성이 전씨인 직원들의 사원명, 주민번호, 부서명, 직급명을 조회하시오.
SELECT 
e.emp_name AS '사원명'
, e. emp_no AS '주민번호'
, d.dept_title AS '부서명'
, j.job_name AS '직급명'
FROM employee e
JOIN department d ON d.dept_id = e.dept_code
JOIN job j ON j.job_code = e.job_code
WHERE SUBSTR(e.emp_no,1,2) BETWEEN 70 AND 79
AND e.emp_name LIKE('전%');

-- 7. 이름에 '형'자가 들어가는 직원들의 사번, 사원명, 직급명을 조회하시오.
SELECT 
e.emp_id AS '사번'
,e.emp_name AS '사원명'
, j.job_name AS '직급명'
FROM employee e
JOIN job j ON j.job_code = e.job_code
WHERE e.emp_name LIKE('%형%');

-- 8. 해외영업팀에 근무하는 사원명, 직급명, 부서코드, 부서명을 조회하시오.
select * from employee;
select * from job;
select * from department;
select * from location;

SELECT
e.emp_name AS '사원명'
, j.job_name AS '직급명'
, d.dept_id AS '부서코드'
, d.dept_title AS '부서명'
FROM employee e
JOIN job j ON j.job_code = e.job_code
JOIN department d ON d.dept_id = e.dept_code
WHERE e.dept_code IN('D5','D6','D7');

-- 9. 보너스를 받는 직원들의 사원명, 보너스, 부서명, 근무지역명을 조회하시오.
select * from employee;
select * from location;

SELECT
e.emp_name AS'사원명'
, e.bonus AS '보너스포인트'
, d.dept_title AS ' 부서명'
, l.local_name AS '근무지역명'
FROM employee e
LEFT JOIN department d ON d.dept_id = e.dept_code
LEFT JOIN location l ON l.local_code = d.location_id
JOIN job j ON j.job_code = e.job_code
WHERE e.bonus  IS NOT NULL;

-- 10. 급여등급테이블 sal_grade의 등급별 최대급여(MAX_SAL)보다 많이 받는 직원들의 
--     사원명, 직급명, 급여, 연봉을 조회하시오.
--     (사원테이블과 급여등급테이블을 SAL_LEVEL컬럼기준으로 동등 조인할 것)
select * from sal_grade;
select * from employee;
SELECT
e.emp_name AS '사원명'
,j.job_name AS '직급명'
,e.salary AS '급여'
,  (e.salary * (1 + IFNULL(e.bonus, 0))) * 12 AS '연봉'
, s.max_sal AS' 최대급여'
FROM employee e
JOIN job j ON j.job_code = e.job_code
JOIN sal_grade s ON s.sal_level = e.sal_level
WHERE e.salary > s.max_sal;

-- 11. 한국과 일본에 근무하는 직원들의 사원명, 부서명, 지역명, 국가명을 조회하시오.
select * from employee;
select * from location;
select * from nation;

SELECT
e.emp_name AS '사원명'
, d.dept_title AS '부서명'
, l.local_name AS '지역명'
, n.national_name AS '국가명'
FROM employee e
JOIN department d ON d.dept_id = e.dept_code
JOIN location l ON l.local_code = d.location_id
JOIN nation n ON n.national_code = l.national_code;


-- 12. 같은 부서에 근무하는 직원들의 사원명, 부서명, 동료이름을 조회하시오. (self join 사용)
--     사원명으로 오름차순정렬
select * from employee;

SELECT
e1.emp_name AS '사원명'
, d.dept_title AS '부서명'
, e2.emp_name AS '동료사원명'
FROM employee e1
JOIN employee e2 ON e1.dept_code = e2.dept_code
JOIN department d ON d.dept_id = e1.dept_code
WHERE e1.emp_name != e2.emp_name
ORDER BY e1.emp_name;

-- 13. 보너스포인트가 없는 직원들 중에서 직급이 차장과 사원인 직원들의 사원명, 직급명, 급여를 조회하시오.
select * from job;
select * from employee;
SELECT 
e.emp_name AS '사원명'
, j.job_name AS '직급명'
, FORMAT(e.salary,0) AS '급여'
FROM employee e
JOIN job j ON j.job_code = e.job_code
WHERE e.bonus IS NULL
AND e.job_code IN('J7','J4');
use empdb;
-- 14. 재직중인 직원과 퇴사한 직원의 수를 조회하시오. (JOIN 문제 아님)
select * from employee;

SELECT '재직' AS '재직여부', COUNT(*) AS '인원수'
FROM employee
WHERE quit_yn  = 'N'
UNION ALL
SELECT '퇴사' AS '재직여부', COUNT(*) AS '인원수'
FROM employee
WHERE quit_yn = 'Y';
