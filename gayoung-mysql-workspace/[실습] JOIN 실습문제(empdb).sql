 use empdb;
-- 1. 재직 중이고 휴대폰 마지막 자리가 2인 직원 중 입사일이 가장 최근인 직원 3명의
--    사원번호, 사원명, 전화번호, 입사일, 퇴직여부를 출력하세요. (JOIN 문제 아님)

SELECT * FROM employee;

SELECT 
    EMP_ID
  , EMP_NAME
  , EMP_NO
  , HIRE_DATE
  , QUIT_YN
FROM
    employee
WHERE
    QUIT_YN = 'N'
    AND PHONE LIKE '%2'
ORDER BY
    HIRE_DATE DESC
LIMIT 3    
;
    
-- 2. 재직 중인 ‘대리’들의 직원명, 직급명, 급여, 사원번호, 이메일, 전화번호, 입사일을 출력하세요.
--    단, 급여를 기준으로 내림차순 출력하세요.
SELECT * FROM employee; -- JOB_CODE >>
SELECT * FROM department; -- JOB_CODE >> [JOB] JOB_CODE : JOB_NAME
SELECT 
    EMP_NAME 사원명
  , JOB_NAME 직급명
  , SALARY 급여
  , EMP_NO 사원번호
  , EMAIL 이메일
  , HIRE_DATE 입사일
FROM
    employee JOIN JOB USING(JOB_CODE)
WHERE 
    QUIT_YN = 'N'
    AND JOB_NAME = '대리'
ORDER BY 
    SALARY DESC
;

-- ********************************************
-- GROUP BY에 없는 컬럼은 집계 함수(Aggregate Function) 없이 SELECT할 수 없음.

-- 3. 재직 중인 직원들을 대상으로 부서별 인원, 급여 합계, 급여 평균을 출력하고
--    마지막에는 전체 인원과 전체 직원의 급여 합계 및 평균이 출력되도록 하세요.
--    단, 출력되는 데이터의 헤더는 컬럼명이 아닌 ‘부서명’, ‘인원’, ‘급여합계’, ‘급여평균’으로 출력되도록 하세요. 

SELECT 
    
    DEPT_TITLE '부서명'
  , COUNT(*) '인원'
  , SUM(SALARY) '급여 합계'
  , AVG(SALARY) '급여 평균'
FROM
    employee
    JOIN department ON DEPT_ID = DEPT_CODE
WHERE 
    QUIT_YN = 'N'
GROUP BY 
    DEPT_TITLE WITH ROLLUP
;
    
-- 4. 전체 직원의 사원명, 주민등록번호, 전화번호, 부서명, 직급명을 출력하세요.
--    단, 입사일을 기준으로 오름차순 정렬되도록 출력하세요.

SELECT * FROM employee;
SELECT * FROM department;
SELECT * FROM job;

SELECT 
    EMP_NAME
  , EMP_NO
  , PHONE
  , DEPT_TITLE 부서명 -- [employee]  dept_code >> [department] DEPT_ID : DEPT_TITLE
  , JOB_NAME 직급명 --  [employee] job_code >> [job] job_code : job_name
  
FROM employee 
    LEFT JOIN department ON DEPT_ID = DEPT_CODE
    LEFT JOIN job USING(JOB_CODE)
ORDER BY
    HIRE_DATE ASC
;


SELECT * FROM department;
SELECT * FROM job;
SELECT * FROM location;

-- 5. 직급이 대리이면서 ASIA 지역에 근무하는 직원들의 사번, 사원명, 직급명, 부서명을 조회하시오.
SELECT 
    EMP_ID 사번
  , EMP_NAME 사원명
  , JOB_NAME 직급명
  , DEPT_TITLE 부서명
FROM employee 
    LEFT JOIN department ON DEPT_ID = DEPT_CODE
    LEFT JOIN job USING(JOB_CODE)
    LEFT JOIN location ON LOCATION_ID = LOCAL_CODE
WHERE 
    JOB_NAME = '대리'
    AND LOCAL_NAME LIKE 'ASIA%'
;
 
 -- 6. 70년대 생이면서 성별이 여자이고 성이 전씨인 직원들의 사원명, 주민번호, 부서명, 직급명을 조회하시오.
 SELECT 
    EMP_NAME 사원명
  , EMP_NO 주민번호
  , DEPT_TITLE 부서명
  , JOB_NAME 직급명
FROM employee 
    JOIN department ON DEPT_CODE = DEPT_ID
    JOIN job USING(JOB_CODE)
WHERE
    EMP_NO LIKE '7%'
    AND SUBSTRING(EMP_NO, 8, 1) IN ('2', '4')
    AND EMP_NAME LIKE '전%'
;

-- 7. 이름에 '형'자가 들어가는 직원들의 사번, 사원명, 직급명을 조회하시오.
SELECT 
    EMP_ID 사번
  , EMP_NAME 사원명
  , JOB_NAME 직급명
FROM employee 
    JOIN job USING(JOB_CODE)
WHERE 
    EMP_NAME LIKE '%형%'
;

SELECT * FROM department;

-- 8. 해외영업팀에 근무하는 사원명, 직급명, 부서코드, 부서명을 조회하시오.
  SELECT 
    EMP_NAME 사원명
  , JOB_NAME 직급명
  , DEPT_CODE 부서코드
  , DEPT_TITLE 부서명
FROM employee 
    LEFT JOIN job USING(JOB_CODE)
    LEFT JOIN department ON DEPT_CODE = DEPT_ID
WHERE   
    DEPT_TITLE LIKE '해외영업%'
;

SELECT * FROM employee;
SELECT * FROM JOB;
SELECT * FROM location;

-- 9. 보너스를 받는 직원들의 사원명, 보너스, 부서명, 근무지역명을 조회하시오
SELECT 
    EMP_NAME 사원명
  , BONUS 보너스 
  , DEPT_TITLE 부서명
  , LOCAL_NAME 근무지역명 
FROM employee
    LEFT JOIN department ON DEPT_CODE = DEPT_ID
    LEFT JOIN location ON location_id = local_code
WHERE 
    BONUS IS NOT NULL;


SELECT * FROM sal_grade;
SELECT * FROM employee;
-- 10. 급여등급테이블 sal_grade의 등급별 최대급여(MAX_SAL)보다 많이 받는 직원들의 
--     사원명, 직급명, 급여, 연봉을 조회하시오.
--     (사원테이블과 급여등급테이블을 SAL_LEVEL컬럼기준으로 동등 조인할 것)
SELECT 
    EMP_NAME AS '사원명'
  , JOB_NAME AS '직급명'
  , SALARY AS '급여'
  , SALARY * 12 AS '연봉'
  , MAX_SAL '최대급여'
FROM employee
    JOIN sal_grade USING(SAL_LEVEL) 
    JOIN job USING(JOB_CODE)
WHERE SALARY > MAX_SAL;

SELECT * FROM location;
SELECT * FROM job;
SELECT * FROM nation;

-- 11. 한국과 일본에 근무하는 직원들의 사원명, 부서명, 지역명, 국가명을 조회하시오.
SELECT 
    EMP_NAME AS '사원명'
  , DEPT_TITLE AS '부서명'
  ,  LOCAL_NAME AS '근무지역명' 
  , NATIONAL_NAME AS '국가명'
FROM employee
    LEFT JOIN department ON DEPT_CODE = DEPT_ID
    LEFT JOIN location ON LOCATION_ID = LOCAL_CODE
    LEFT JOIN nation USING(NATIONAL_CODE) 
WHERE
   NATIONAL_NAME IN ('한국', '일본');


-- 12. 같은 부서에 근무하는 직원들의 사원명, 부서명, 동료이름을 조회하시오. (self join 사용)
--     사원명으로 오름차순정렬
SELECT 
    e1.EMP_NAME AS '사원명',
    DEPT_TITLE AS '부서명',
    e2.EMP_NAME AS '동료이름'
FROM employee e1
JOIN department ON DEPT_CODE = DEPT_ID
JOIN employee e2 ON e1.DEPT_CODE = e2.DEPT_CODE 
WHERE e1.EMP_ID != e2.EMP_ID 
ORDER BY e1.EMP_NAME;

-- 13. 보너스포인트가 없는 직원들 중에서 직급이 차장과 사원인 직원들의 사원명, 직급명, 급여를 조회하시오.
SELECT 
    EMP_NAME AS '사원명',
    JOB_NAME AS '직급명',
    FORMAT(SALARY,0) AS '급여'
FROM employee
JOIN job USING(JOB_CODE)
WHERE BONUS IS NULL
AND JOB_NAME IN ('차장', '사원');

-- 14. 재직중인 직원과 퇴사한 직원의 수를 조회하시오. (JOIN 문제 아님)
SELECT
    '재직' AS 재직여부,
    SUM(CASE WHEN QUIT_YN = 'N' THEN 1 ELSE 0 END) AS 인원수
FROM employee
UNION ALL
SELECT
    '퇴사' AS 재직여부,
    SUM(CASE WHEN QUIT_YN = 'Y' THEN 1 ELSE 0 END) AS 인원수
FROM employee;