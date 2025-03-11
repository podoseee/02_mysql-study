-- 1. employee 테이블로부터 급여가 300만원 이상인 사원들의 사원명, 급여, 연봉(급여*12) 조회
SELECT EMP_NAME, SALARY, SALARY*12 AS '연봉' FROM employee WHERE SALARY > 3000000;

-- 2. employee 테이블로부터 연봉이 5000만원 이상인 사원들의 사원명, 급여, 연봉, 부서코드 조회
SELECT EMP_NAME, SALARY, SALARY*12 AS '연봉', DEPT_CODE FROM employee WHERE SALARY*12 > 50000000;

-- 3. employee 테이블에서 이름이 '연'으로 끝나는 사원의 이름을 출력하시오
SELECT EMP_NAME FROM employee WHERE EMP_NAME LIKE '%연';

-- 4. employee 테이블에서 전화번호 처음 3자리가 010이 아닌 사원의 이름, 전화번호를 출력하시오.
SELECT EMP_NAME, PHONE FROM employee WHERE PHONE NOT LIKE '010%';

-- 5. employee 테이블에서 메일주소 '_'의 앞이 4자이면서, DEPT_CODE가 D9 또는 D5이고 
--    고용일이 90/01/01 ~ 01/12/31이면서, 월급이 270만원 이상인 사원의 전체 정보를 출력하시오 (송중기 사원 데이터가 조회되어야됨)
SELECT * FROM employee 
WHERE LENGTH(SUBSTRING_INDEX(EMAIL,'_',1)) = 4
AND DEPT_CODE IN('D9','D5')
AND HIRE_DATE BETWEEN '1990-01-01' AND '2001-12-31'
AND SALARY > 2700000;

-- 6. employee 테이블에서 현재 근무중인 사원의 이름을 오름차순으로 정렬해서 출력하시오
SELECT EMP_NAME FROM employee
WHERE QUIT_YN = 'N'
ORDER BY EMP_NAME;

-- 7. 재직 중이고 휴대폰 마지막 자리가 2인 직원 중 입사일이 가장 최근인 직원 3명의 
--    사원번호, 직원명, 전화번호, 입사일, 퇴직여부를 출력하세요.

SELECT EMP_ID, EMP_NAME, PHONE, HIRE_DATE, QUIT_YN
FROM employee
WHERE RIGHT(PHONE, 1) = 2
ORDER BY HIRE_DATE DESC
LIMIT 3;

-- 8. 관리자(사수)를 따로 두고 있지 않은 사원의 사번, 이름을 조회하시오. 
--    참고. 각 사원들마다의 관리자가 누구인지는 MANAGER_ID에 기록되어있음
SELECT EMP_ID, EMP_NAME
FROM employee
WHERE MANAGER_ID IS NULL;