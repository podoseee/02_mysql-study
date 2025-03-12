/* ## SELECT(Basic) 실습문제 - empdb) ## */
use empdb;

-- 아래의 select문들을 실행하여 각 테이블에 어떤 컬럼과 어떤 데이터가 담겨있는지 파악하고 진행하시오.
SELECT * FROM department;   -- 부서
SELECT * FROM job;          -- 직급 
SELECT * FROM emploYEE;     -- 사원
SELECT * FROM sal_grade;    -- 급여등급
SELECT * FROM nation;       -- 국가
SELECT * FROM location;     -- 지역



-- 1. employee 테이블로부터 급여가 300만원 이상인 사원들의 사원명, 급여, 연봉(급여*12) 조회
SELECT
    emp_name
  , salary
  , salary * 12
FROM employee;
/*
    ------------ 출력 예시 ------------
    emp_name    salary      salary*12  
    -----------------------------------
    선동일	    8000000	    96000000
    송종기	    6000000	    72000000
    노옹철	    3700000	    44400000
    유재식	    3400000	    40800000
    정중하	    3900000	    46800000
    심봉선	    3500000	    42000000
    대북혼	    3760000	    45120000
    전지연	    3660000	    43920000
    고두밋	    4480000	    53760000
    
    총 row수는 9
*/



-- 2. employee 테이블로부터 연봉이 5000만원 이상인 사원들의 사원명, 급여, 연봉, 부서코드 조회
SELECT
    emp_name
  , salary
  , salary * 12 AS 연봉
  , dept_code
FROM employee
WHERE salary * 12 > 50000000
;

/*
    --------------- 출력 예시 --------------------
    emp_name    salary      연봉        dept_code
    ----------------------------------------------
    선동일	    8000000	    96000000	D9
    송종기	    6000000	    72000000	D9
    고두밋	    4480000	    53760000	D2
    
    총 row수는 3
*/



-- 3. employee 테이블에서 이름이 '연'으로 끝나는 사원의 이름을 출력하시오
SELECT
    emp_name
FROM 
    employee
WHERE
    emp_name
    LIKE '%연';
/*
    --- 출력 예시 --
    emp_name
    ----------------
    차태연
    전지연
    
    총 row수는 2
*/


    
-- 4. employee 테이블에서 전화번호 처음 3자리가 010이 아닌 사원의 이름, 전화번호를 출력하시오.
SELECT
    emp_name
  , phone
FROM 
    employee
WHERE
    LEFT(phone, 3) != 010;
/*
    ------ 출력 예시 ------
    emp_name    pHoNE      
    ------------------------
    심봉선	    0113654485
    윤은해	    0179964233
    하동운	    01158456632
    
    총 row수는 3
*/


    
-- 5. employee 테이블에서 메일주소 '_'의 앞이 4자이면서, DEPT_CODE가 D9 또는 D5이고 
--    고용일이 90/01/01 ~ 01/12/31이면서, 월급이 270만원 이상인 사원의 전체 정보를 출력하시오 (송중기 사원 데이터가 조회되어야됨)
SELECT 
    *
FROM employee
WHERE 
    SALARY >= 2700000
    AND DEPT_CODE IN ('D9', 'D5')
    AND HIRE_DATE BETWEEN '1990-01-01' AND '2001-12-31'
    -- AND LOCATE('_', EMAIL) = 5;
    AND INSTR(EMAIL, '_') = 5;

-- 6. employee 테이블에서 현재 근무중인 사원의 이름을 오름차순으로 정렬해서 출력하시오

SELECT
    emp_name
FROM
    employee
ORDER BY
    emp_name;
/*
    --- 출력 예시 --
    emp_name
    ----------------
    고두밋
    김해술
    노옹철
    ...
    차태연
    하동운
    하이유
    
    총 row수는 23
*/



    
-- 7. 재직 중이고 휴대폰 마지막 자리가 2인 직원 중 입사일이 가장 최근인 직원 3명의 
--    사원번호, 직원명, 전화번호, 입사일, 퇴직여부를 출력하세요.

SELECT
    emp_id
  , emp_name
  , phone
  , hire_date
  , quit_yn
FROM
    employee
ORDER BY
    hire_date DESC
LIMIT 3
;
/*
    ------------------------------- 출력 예시 ----------------------------
    emp_id  emp_name    phone           hire_date               quit_yn
    ----------------------------------------------------------------------
    216	    차태연	    01064643212	    2013-03-01 00:00:00	    N
    211	    전형돈	    01044432222	    2012-12-12 00:00:00	    N
    206	    박나라	    01096935222	    2008-04-02 00:00:00	    N
    
    총 row수는 3
*/




-- 8. 관리자(사수)를 따로 두고 있지 않은 사원의 사번, 이름을 조회하시오. 
--    참고. 각 사원들마다의 관리자가 누구인지는 MANAGER_ID에 기록되어있음 

SELECT
    emp_id
  , emp_name
FROM
    employee
WHERE
    MANAGER_ID IS NULL;
/*
    ------ 출력 예시 ------
    emp_id  emp_name      
    ------------------------
    200	    선동일
    213	    하동운
    215	    대북혼
    218	    이오리
    219	    임시환
    220	    이중석
    221	    유하진
    223	    고두밋
    
    총 row수는 8
*/