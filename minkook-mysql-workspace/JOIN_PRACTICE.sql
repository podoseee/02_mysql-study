
/* ## SELECT(JOIN) 실습문제 - empdb ## */
use empdb;

-- 1. 재직 중이고 휴대폰 마지막 자리가 2인 직원 중 입사일이 가장 최근인 직원 3명의
--    사원번호, 사원명, 전화번호, 입사일, 퇴직여부를 출력하세요. (JOIN 문제 아님)
/*
    ------------------------------ 출력 예시 ---------------------------------
    사원번호    사원명     전화번호        입사일                  퇴직여부
    --------------------------------------------------------------------------
    216         차태연     01064643212     2013-03-01 00:00:00     N
    211         전형돈     01044432222     2012-12-12 00:00:00     N
    206         박나라     01096935222     2008-04-02 00:00:00     N
*/
select EMP_ID   "사원번호"
	 , EMP_NAME "사원명"
	 , EMP_NO "전화번호"
	 , HIRE_DATE "입사일"
	 , QUIT_YN "퇴직여부"
from employee
where substring(PHONE,11,1) = '2'
order by HIRE_DATE DESC
limit 3
;


-- 2. 재직 중인 ‘대리’들의 직원명, 직급명, 급여, 사원번호, 이메일, 전화번호, 입사일을 출력하세요.
--    단, 급여를 기준으로 내림차순 출력하세요.
/*
    ---------------------------------- 출력 예시 -------------------------------------------------
    사원명     직급명     급여       사원번호        이메일                    입사일
    ----------------------------------------------------------------------------------------------
    전지연     대리      3660000     770808-2665412  jun_jy@ohgiraffers.com    2007-03-20 00:00:00
    차태연     대리      2780000     000704-3364897  cha_ty@ohgiraffers.com    2013-03-01 00:00:00
    장쯔위     대리      2550000     780923-2234542  jang_zw@ohgiraffers.com   2015-06-17 00:00:00
    하동운     대리      2320000     621111-1785463  ha_dh@ohgiraffers.com     1999-12-31 00:00:00
    전형돈     대리      2000000     830807-1121321  jun_hd@ohgiraffers.com    2012-12-12 00:00:00

*/


select 

   	   A.EMP_NAME "사원명"
   	 , B.JOB_NAME "직급명"
   	 , A.SALARY "급여"
   	 , A.EMP_ID "사원번호"
   	 , A.EMAIL "이메일"
   	 , A.HIRE_DATE "입사일"
   	 
from employee A
 	join job B on(B.JOB_CODE = A.JOB_CODE)
where B.JOB_NAME = (select C.JOB_NAME
					from job C
					where C.JOB_NAME = '대리'
					)
and A.QUIT_YN = 'N'
order by SALARY DESC
;


    
-- 3. 재직 중인 직원들을 대상으로 부서별 인원, 급여 합계, 급여 평균을 출력하고
--    마지막에는 전체 인원과 전체 직원의 급여 합계 및 평균이 출력되도록 하세요.
--    단, 출력되는 데이터의 헤더는 컬럼명이 아닌 ‘부서명’, ‘인원’, ‘급여합계’, ‘급여평균’으로 출력되도록 하세요. 
--    Hint. ROLLUP사용
/*
    -------------------------- 출력 예시 --------------------------
    부서명         인원      급여합계            급여평균
    ---------------------------------------------------------------
    기술지원부       2       4550000             2275000
    인사관리부       3       7820000             2606666.6666666665
    총무부           3       17700000            5900000
    해외영업1부      6       15760000            2626666.6666666665
    해외영업2부      3       10100000            3366666.6666666665
    회계관리부       4       11000000            2750000
                    21       66930000            3187142.8571428573

*/


select 
	  B.dEPT_TITLE  as "부서명"
	 ,count(*)  as "인원"
	 ,SUM(A.SALARY) as "급여합계"
	 ,AVG(A.SALARY) as "급여평균"
from employee A
    join department B on (B.DEPT_ID = A.DEPT_CODE)
 	join job C on(C.JOB_CODE = A.JOB_CODE)
where A.QUIT_YN = 'N'
 group by B.dEPT_TITLE 
WITH ROLLUP;



-- 4. 전체 직원의 사원명, 주민등록번호, 전화번호, 부서명, 직급명을 출력하세요.
--    단, 입사일을 기준으로 오름차순 정렬되도록 출력하세요.
/*
    ------------------------- 출력 예시 ---------------------------------
    사원명     주민등록번호          전화번호        부서명     직급명
    ---------------------------------------------------------------------
    선동일     621225-1985634        01099546325     총무부      대표
    고두밋     470808-2123341                        회계관리부  부사장
    유하진     800808-1123341                        회계관리부  차장
    하이유     690402-2040612        01036654488     해외영업1부 과장
    송은희     070910-4653546        01077607879     해외영업2부 차장
    이태림     760918-2854697        01033000002     기술지원부  대리
    정중하     770102-1357951        01036654875     해외영업2부 부장
    임시환     660712-1212123                        회계관리부  차장
    ...
    총 row 수는 24
*/


select A.EMP_NAME "사원명"
     , A.EMP_NO "주민등록번호"
     , A.PHONE "전화번호"
     , B.DEPT_TITLE "부서명"
   	 , C.JOB_NAME "직급명"

from employee A
    left join department B on (B.DEPT_ID = A.DEPT_CODE)
 	left join job C on(C.JOB_CODE = A.JOB_CODE)
order by A.HIRE_DATE asc
;



-- 5. 직급이 대리이면서 ASIA 지역에 근무하는 직원들의 사번, 사원명, 직급명, 부서명을 조회하시오.
/*
    --------------- 출력 예시 ---------------
    사번    사원명      직급명     부서명
    ------------------------------------------
    216	    차태연	    대리	   인사관리부
    217	    전지연	    대리	   인사관리부
*/

select 
	   A.EMP_NAME "사원명"
     , A.EMP_NO "주민등록번호"
     , B.DEPT_TITLE "부서명"
   	 , C.JOB_NAME "직급명"

from employee A
    left join department B on (B.DEPT_ID = A.DEPT_CODE)
 	left join job C on(C.JOB_CODE = A.JOB_CODE)
 	left join location D on (D.LOCAL_CODE = B.LOCATION_ID)
 where C.JOB_NAME = '대리'
 and D.LOCAL_NAME like '%ASIA%'
;

-- 6. 70년대 생이면서 성별이 여자이고 성이 전씨인 직원들의 사원명, 주민번호, 부서명, 직급명을 조회하시오.
/*
    -------------------- 출력 예시 -------------------------
    사원명         주민번호            부서명         직급명
    ---------------------------------------------------------
    전지연         770808-2665412       인사관리부    대리
*/


select 
	   A.EMP_NAME "사원명"
     , A.EMP_NO "주민등록번호"
     , B.DEPT_TITLE "부서명"
   	 , C.JOB_NAME "직급명"

from employee A
    left join department B on (B.DEPT_ID = A.DEPT_CODE)
 	left join job C on(C.JOB_CODE = A.JOB_CODE)
 	-- left join location D on (D.LOCAL_CODE = B.LOCATION_ID)
 where SUBSTRING(A.EMP_NO,1,1) = '7'
 and (SUBSTRING(A.EMP_NO,8,1) = '2' or SUBSTRING(A.EMP_NO,8,1) = '4') 
 and A.EMP_NAME like '전%'
;


-- 7. 이름에 '형'자가 들어가는 직원들의 사번, 사원명, 직급명을 조회하시오.
/*
    ---------- 출력 예시 ------------
    사번      사원명    직급명
    ---------------------------------
    211        전형돈    대리
*/
select 
       A.EMP_ID "사원번호"
	 , A.EMP_NAME "사원명"
     -- , B.DEPT_TITLE "부서명"
   	 , C.JOB_NAME "직급명"
from employee A
    -- left join department B on (B.DEPT_ID = A.DEPT_CODE)
 	left join job C on(C.JOB_CODE = A.JOB_CODE)
 	-- left join location D on (D.LOCAL_CODE = B.LOCATION_ID)
 where A.EMP_NAME like '%형%'
 ;




-- 8. 해외영업팀에 근무하는 사원명, 직급명, 부서코드, 부서명을 조회하시오.
/*
    ------------------- 출력 예시 ---------------------
    사원명     직급명     부서코드        부서명
    ---------------------------------------------------
    박나라     사원        D5             해외영업1부
    하이유     과장        D5             해외영업1부
    김해술     과장        D5             해외영업1부
    심봉선     부장        D5             해외영업1부
    윤은해     사원        D5             해외영업1부
    대북혼     과장        D5             해외영업1부
    송은희     차장        D6             해외영업2부
    유재식     부장        D6             해외영업2부
    정중하     부장        D6             해외영업2부

*/
select 
	   A.EMP_NAME "사원명"
	 , C.JOB_NAME "직급명"
	 , B.DEPT_ID "부서코드"
     , B.DEPT_TITLE "부서명"
   
from employee A
    left join department B on (B.DEPT_ID = A.DEPT_CODE)
 	left join job C on(C.JOB_CODE = A.JOB_CODE)
 	-- left join location D on (D.LOCAL_CODE = B.LOCATION_ID)
 where B.DEPT_TITLE like '%해외영업%'
 ;




-- 9. 보너스를 받는 직원들의 사원명, 보너스, 부서명, 근무지역명을 조회하시오.
/*
    --------------------- 출력예시 ---------------------------------------
    사원명         보너스포인트          부서명         근무지역명
    ----------------------------------------------------------------------
    선동일         0.3                   총무부         ASIA1
    유재식         0.2                   해외영업2부    ASIA3
    하이유         0.1                   해외영업1부    ASIA2
    심봉선         0.15                  해외영업1부    ASIA2
    장쯔위         0.25                  기술지원부     EU
    하동운         0.1                    
    차태연         0.2                   인사관리부     ASIA1
    전지연         0.3                   인사관리부     ASIA1
    이태림         0.35                  기술지원부     EU

*/


select 
	   A.EMP_NAME "사원명"
	 , A.BONUS "보너스포인트"
     , B.DEPT_TITLE "부서명"
     , D.LOCAL_NAME "근무지역명"
   
from employee A
    left join department B on (B.DEPT_ID = A.DEPT_CODE)
 	-- left join job C on(C.JOB_CODE = A.JOB_CODE)
 	left join location D on (D.LOCAL_CODE = B.LOCATION_ID)
 where A.BONUS is not null
 ;




-- 10. 급여등급테이블 sal_grade의 등급별 최대급여(MAX_SAL)보다 많이 받는 직원들의 
--     사원명, 직급명, 급여, 연봉을 조회하시오.
--     (사원테이블과 급여등급테이블을 SAL_LEVEL컬럼기준으로 동등 조인할 것)
/*
    --------------------- 출력예시 ---------------------------------------
    사원명     직급명     급여        연봉            최대급여
    ----------------------------------------------------------------------
    고두밋      부사장     4480000    53760000        2999999
*/

select * from department;
select * from job;
select * from employee;
select * from location;
select * from nation;
select * from sal_grade;

select 
	   A.EMP_NAME "사원명"
	 , C.JOB_NAME "직급명"
	 , A.SALARY  "급여"
	 , A.SALARY * 12 "연봉"
	 ,(select MAX_SAL
	   from sal_grade 
	   where SAL_LEVEL = A.SAL_LEVEL
	  ) as "최대급여"
from employee A
 	left join job C on(C.JOB_CODE = A.JOB_CODE)
 	left join SAL_GRADE D on (D.SAL_LEVEL = A.SAL_LEVEL)
 where A.SALARY > (select MAX_SAL
				   from sal_grade 
				   where SAL_LEVEL = A.SAL_LEVEL
				   )		




-- 11. 한국과 일본에 근무하는 직원들의 사원명, 부서명, 지역명, 국가명을 조회하시오.
/*
    --------------------- 출력예시 ---------------------------------------
    사원명         부서명         지역명         국가명
    ----------------------------------------------------------------------
    방명수         인사관리부     ASIA1          한국
    차태연         인사관리부     ASIA1          한국
    전지연         인사관리부     ASIA1          한국
    임시환         회계관리부     ASIA1          한국
    이중석         회계관리부     ASIA1          한국
    유하진         회계관리부     ASIA1          한국
    고두밋         회계관리부     ASIA1          한국
    박나라         해외영업1부    ASIA2          일본
    하이유         해외영업1부    ASIA2          일본
    김해술         해외영업1부    ASIA2          일본
    심봉선         해외영업1부    ASIA2          일본
    윤은해         해외영업1부    ASIA2          일본
    대북혼         해외영업1부    ASIA2          일본
    선동일         총무부         ASIA1          한국
    송종기         총무부         ASIA1          한국
    노옹철         총무부         ASIA1          한국

*/



select 
	   A.EMP_NAME "사원명"
     , B.DEPT_TITLE "부서명"
     , D.LOCAL_NAME "근무지역명"
     , E.NATIONAL_NAME
   
from employee A
    left join department B on (B.DEPT_ID = A.DEPT_CODE)
 	left join job C on(C.JOB_CODE = A.JOB_CODE)
 	left join location D on (D.LOCAL_CODE = B.LOCATION_ID)
 	left join nation E on (E.NATIONAL_CODE = D.NATIONAL_CODE)
where NATIONAL_NAME in ('한국','일본')
 ;

-- 12. 같은 부서에 근무하는 직원들의 사원명, 부서명, 동료이름을 조회하시오. (self join 사용)
--     사원명으로 오름차순정렬
/*
    ------------------ 출력예시 ----------------
    사원명         부서명         동료사원명
    --------------------------------------------
    고두밋         회계관리부     임시환
    고두밋         회계관리부     이중석
    고두밋         회계관리부     유하진
    김해술         해외영업1부    박나라
    김해술         해외영업1부    하이유
    김해술         해외영업1부    심봉선
    김해술         해외영업1부    윤은해
    김해술         해외영업1부    대북혼
    ...
    총 row 66
*/
select * from department;
select * from job;
select * from employee;
select * from location;
select * from nation;
select * from sal_grade;

select A.EMP_NAME
      ,B.EMP_NAME
      ,C.DEPT_TITLE
from employee A
join employee B  on (B.DEPT_CODE = A.DEPT_CODE)
left join department C on(C.dept_id = B.dept_code)
where  A.EMP_NAME <> B.EMP_NAME
order by A.EMP_NAME
;
		
-- 13. 보너스포인트가 없는 직원들 중에서 직급이 차장과 사원인 직원들의 사원명, 직급명, 급여를 조회하시오.
/*
    --------------------- 출력예시 -------------
    사원명         직급명         급여
    ---------------------------------------------
    송은희         차장           2,800,000
    임시환         차장           1,550,000
    이중석         차장           2,490,000
    유하진         차장           2,480,000
    박나라         사원           1,800,000
    윤은해         사원           2,000,000
    ...
    총 row수는 8
*/
select 
	   A.EMP_NAME "사원명"
     , C.JOB_NAME "직급명"
     , A.SALARY "급여"
from employee A
left join job C on(C.JOB_CODE = A.JOB_CODE)
 	-- left join location D on (D.LOCAL_CODE = B.LOCATION_ID)
 	-- left join nation E on (E.NATIONAL_CODE = D.NATIONAL_CODE)

 ;




-- 14. 재직중인 직원과 퇴사한 직원의 수를 조회하시오. (JOIN 문제 아님)
/*
  --------------------- 출력예시 -------------
  재직여부          인원수
  --------------------------------------------
  재직              23
  퇴사              1
*/



select if(QUIT_YN = 'N','재직','퇴사') "재직여부"
	  ,COUNT(*) "인원수"
from employee A
group by QUIT_YN
;







