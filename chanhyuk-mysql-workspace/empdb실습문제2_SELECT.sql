/* ## SELECT(함수) 실습문제 - empdb ## */
use empdb;

-- 1. employee 테이블에서 남자사원만 사원번호, 사원명, 주민번호, 연봉을 나타내세요.
--    연봉은 보너스 포함 연봉((기존 급여 + 급여 * bonus) * 12)으로 연산하시오.
--    주민번호의 뒷6자리는 *처리하세요.
/*
    --------------- 출력 예시 ------------------------
    사원번호    성명      주민번호           연봉
    --------------------------------------------------
    200        선동일     621225-1******   124,800,000
    201        송종기     631126-1******   72,000,000
    202        노옹철     861015-1******   44,400,000
    204        유재식     660508-1******   48,960,000
    205        정중하     770102-1******   46,800,000
    208        김해술     870927-1******   30,000,000
    209        심봉선     750206-1******   48,300,000
    ...
    총 row수는 15
*/
select * from employee;
select EMP_ID as "사원번호", EMP_NAME as"성명", INSERT(EMP_NO,9,6,"******") as"주민번호", (SALARY+SALARY*IFNULL(BONUS, 0))*12 as "연봉"
from employee;


-- 2. EMPLOYEE 테이블에서 사원명, 아이디(이메일 @ 앞부분)을 조회하세요.
/*
    --------- 출력 예시 -----------
    emp_name        email_id
    -------------------------------
    선동일          sun_di
    송종기          song_jk
    노옹철          no_hc
    송은희          song_eh
    유재식          yoo_js
    정중하          jung_jh
    박나라          pack_nr
    하이유          ha_iy
    김해술          kim_hs
    ...
    총 row수는 24
*/
select * from employee;
select emp_name, SUBSTRING_INDEX(email, '@', 1) as "email_id"
from employee;


-- 3. 아래의 구문들을 실행하여 tbl_files 테이블이 생성되고 데이터가 추가되면 
--    파일경로를 제외하고 파일명만 아래와 같이 출력하세요.
CREATE TABLE tbl_files (
   file_no BIGINT,
   file_path VARCHAR(500)
);
INSERT INTO tbl_files VALUES(1, 'c:\\abc\\deft\\salesinfo.xls');
INSERT INTO tbl_files VALUES(2, 'c:\\music.mp3');
INSERT INTO tbl_files VALUES(3, 'c:\\documents\\resume.hwp');
COMMIT;
/*
    출력결과 :
    --------------------------
    파일번호      파일명
    ---------------------------
    1             salesinfo.xls
    2             music.mp3
    3             resume.hwp
    ---------------------------
*/
select * from  tbl_files;
select file_no as "파일번호", SUBSTRING_INDEX(file_path, '\\', -1) as "파일명" from tbl_files;

    
-- 4. 부서코드가 D5, D9인 직원들 중 2004년에 입사한 직원의 사번, 사원명, 부서코드, 입사일 조회
/*
    --------------- 출력 예시 ------------------------
    사번    사원명      부서코드    입사일
    --------------------------------------------------
    208	    김해술	    D5	        2004-04-30 00:00:00
*/
select * from employee;
select EMP_ID as "사번", EMP_NAME as "사원명", DEPT_CODE as "부서코드", HIRE_DATE as "입사일"
from employee
where (DEPT_CODE = "D9" or DEPT_CODE = "D5") and DATE_FORMAT(HIRE_DATE, '%Y') = 2004;


-- 5. 직원명, 입사일, 입사한 달의 근무일수(주말에도 근무하는 걸로 가정) 조회
/*
    --------------- 출력 예시 ------------------------
    직원명  입사일                  입사한 달의 근무일수
    --------------------------------------------------
    선동일	1990-02-06 00:00:00	    23
    송종기	2001-09-01 00:00:00	    30
    노옹철	2001-01-01 00:00:00	    31
    송은희	1996-05-03 00:00:00	    29
    유재식	2000-12-29 00:00:00	    3
    정중하	1999-09-09 00:00:00	    22
    박나라	2008-04-02 00:00:00	    29
    하이유	1994-07-07 00:00:00	    25
    김해술	2004-04-30 00:00:00	    1
    심봉선	2011-11-11 00:00:00	    20
    윤은해	2001-02-03 00:00:00	    26
    전형돈	2012-12-12 00:00:00	    20
    장쯔위	2015-06-17 00:00:00	    14
    하동운	1999-12-31 00:00:00	    1
    방명수	2010-04-04 00:00:00	    27
    대북혼	2017-06-19 00:00:00	    12
    차태연	2013-03-01 00:00:00	    31
    전지연	2007-03-20 00:00:00	    12
    이오리	2016-11-28 00:00:00	    3
    임시환	1999-09-09 00:00:00	    22
    이중석	2014-09-18 00:00:00	    13
    유하진	1994-01-20 00:00:00	    12
    이태림	1997-09-12 00:00:00	    19
    고두밋	1994-01-20 00:00:00	    12

    총 row수는 24
*/
select * from employee;
select DATE_FORMAT(DATE_ADD(CURDATE(), INTERVAL 1 MONTH), '%Y-%m-01');
select EMP_NAME as "직원명", HIRE_DATE as "입사일", DATEDIFF(DATE_FORMAT(DATE_ADD(HIRE_DATE, INTERVAL 1 MONTH), '%Y-%m-01'), DATE_FORMAT(HIRE_DATE, '%Y-%m-%d')) as "입사한 달의 근무일수"
from employee;

  
-- 6. EMPLOYEE 테이블에서 여자사원의 급여 총 합을 계산하시오.
/*
    ---------- 출력 예시 ------------
    급여 총 합
    ---------------------------------
    24816240
*/
SELECT * FROM EMPLOYEE;
select sum(salary)
from EMPLOYEE
WHERE substring(EMP_NO, 8, 1) = 2 or substring(EMP_NO, 8, 1) = 4;


-- 7. 부서코드가 D5인 사원들의 급여총합, 보너스 총합 조회
/*
    ------- 출력 예시 ------------
    급여총합        보너스 총합
    ------------------------------
    15,760,000      745,000
*/
select * from employee;
select format(sum(salary), 0) as "급여총합", format(sum(salary*IFNULL(BONUS, 0)), 0) as "보너스 총합"
from employee
where dept_code = "D5";


-- 8. 부서코드가 D5인 직원의 보너스 포함 연봉의 총합 을 계산
/*
    ------- 출력 예시 ----------
    연봉
    ----------------------------
    198,060,000
*/
select * from employee;
select format(sum(salary+salary*IFNULL(BONUS, 0))*12, 0) as "연봉"
from employee
where dept_code = "D5";


-- 9. 남/여 사원 급여합계를 동시에 표현
/*
    ---------------- 출력 예시 -------------------
    남사원 급여 합계          여사원 급여 합계
    ----------------------------------------------
    49,760,000                24,816,240
*/
select * from employee;

select 
    format(sum(CASE WHEN substring(EMP_NO, 8, 1) = 1 or substring(EMP_NO, 8, 1) = 3 THEN salary ELSE 0 END),0) as "남사원 급여 합계"
,   format(sum(CASE WHEN substring(EMP_NO, 8, 1) = 2 or substring(EMP_NO, 8, 1) = 4 THEN salary ELSE 0 END),0) as "여사원 급여 합계"
from employee;


-- 10. [EMPLOYEE] 테이블에서 사원들이 속해있는 부서의 수를 조회
/*
    ------ 출력 예시 -------
    부서 수
    ------------------------
    6
*/
select * from employee;
select count(distinct(dept_code)) as "부서 수"
from employee;
