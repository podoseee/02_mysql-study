
/* ## SELECT(GROUP BY, HAVING) 실습문제 - empdb ## */
use empdb;

-- 1. EMPLOYEE 테이블에서 직급이 J1을 제외하고, 직급별 사원수 및 평균급여를 출력하세요.
 /*
    --------------- 출력 예시 -------------
    직급코드    직급별 사원수      평균급여
    ----------------------------------------
        J2           3              4726666
        J3           3              3600000
        J4           4              2330000
        J5           3              2820000
        J6           6              2624373
        J7           4              2017500
*/

select A.JOB_CODE       as "직급코드"
	  ,COUNT(A.JOB_CODE) as "직급별 사원수"
	  ,FLOOR(AVG(A.SALARY)) as "평균 급여"
from employee A
where 
		A.JOB_CODE <> 'J1'
group by 
	 	A.JOB_CODE;

-- 2. EMPLOYEE테이블에서 직급이 J1을 제외하고, 입사년도별 인원수를 조회해서, 입사년 기준으로 오름차순 정렬하세요.
--   (select에는 groupby절에 명시한 컬럼만 작성가능)
/*
    ---- 출력 예시 -------
    입사년     인원수
    ----------------------
    1994       3
    1996       1
    1997       1
    1999       3
    2000       1
    2001       3
    ...
    총 출력row는 17
*/
select 
	   DATE_FORMAT(A.HIRE_DATE,'%Y') as "입사년"
	  ,COUNT(DATE_FORMAT(A.HIRE_DATE,'%Y')) as "인원수"
from employee A
where 
	 A.JOB_CODE <> 'J1'
group by 
	 DATE_FORMAT(A.HIRE_DATE,'%Y')
order by 
	 DATE_FORMAT(A.HIRE_DATE,'%Y');


-- 3. 성별 급여의 평균(정수처리), 급여의 합계, 인원수를 조회한 뒤 인원수로 내림차순을 정렬 하시오.
/*
    ------------------- 출력 예시 -------------------
    셩별     평균          합계           인원수
    -------------------------------------------------
    남       3,317,333     49,760,000       15
    여       2,757,360     24,816,240       9
*/

select 
	  IF(SUBSTRING(A.EMP_NO,8,1) = '1' or SUBSTRING(A.EMP_NO,8,1) = '3','남','여') as "성별"
	 ,FLOOR(AVG(A.SALARY)) as "평균 급여"
	 ,SUM(A.SALARY) as "합계"
	 ,COUNT(A.EMP_NO) as "인원수"
from employee A
group by 
	  IF(SUBSTRING(A.EMP_NO,8,1) = '1' or SUBSTRING(A.EMP_NO,8,1) = '3','남','여');


-- 4. 직급별 인원수가 3명이상인 직급과 총원을 조회
/*
    ------------ 출력 예시 ---------------
    직급          인원수
    -------------------------------------
    J2              3
    J3              3
    J4              4
    J5              3
    J6              6
    J7              4
*/

select 
	  A.JOB_CODE as "직급"
	 ,COUNT(*) as "인원수"
from employee A
group by 
		A.JOB_CODE
having 
		COUNT(*) >= 3;