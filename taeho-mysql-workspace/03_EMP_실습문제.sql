use empdb;
SELECT * FROM employee;
-- 1. EMPLOYEE 테이블에서 직급이 J1을 제외하고, 직급별 사원수 및 평균급여를 출력하세요.

SELECT 
    JOB_CODE AS '직급코드'
    , COUNT(JOB_CODE)  AS '직급별 사원 수'
    ,  FLOOR(AVG(SALARY)) AS '평균 급여'
FROM employeedepartment
WHERE JOB_CODE != 'J1'
GROUP BY  JOB_CODE;

-- 2. EMPLOYEE테이블에서 직급이 J1을 제외하고, 입사년도별 인원수를 조회해서, 입사년 기준으로 오름차순 정렬하세요.
SELECT 
DATE_FORMAT(HIRE_DATE,"%Y") AS '입사년'
, COUNT(DATE_FORMAT(HIRE_DATE,"%Y")) AS '인원수'
FROM employee
WHERE JOB_CODE != 'J1'
GROUP BY (DATE_FORMAT(HIRE_DATE,"%Y"))
ORDER BY (DATE_FORMAT(HIRE_DATE,"%Y"));

-- 3. 성별 급여의 평균(정수처리), 급여의 합계, 인원수를 조회한 뒤 인원수로 내림차순을 정렬 하시오.
SELECT 
IF(LEFT(SUBSTRING_INDEX(EMP_NO, '-', -1), 1) IN ('1', '3'), '남성', '여성') AS '성별',
    FORMAT(FLOOR(AVG(salary)),0) AS '평균 연봉',
    FORMAT(SUM(salary),0) AS '합계',
    COUNT(*) AS '인원수'
FROM employee
GROUP BY 성별
ORDER BY 인원수 DESC;


-- 4. 직급별 인원수가 3명이상인 직급과 총원을 조회
SELECT JOB_CODE AS '직급' , COUNT(JOB_CODE) AS '인원수' FROM employee
GROUP BY JOB_CODE
HAVING (COUNT(JOB_CODE)) >= 3;