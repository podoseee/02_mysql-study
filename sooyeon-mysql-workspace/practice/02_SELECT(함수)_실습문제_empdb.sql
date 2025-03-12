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
--    , RPAD(EMP_NO,15,'*') # 15까지를 오른쪽부터 *로 채움
SELECT * FROM employee;
SELECT
    EMP_ID AS 사원번호
    ,EMP_NAME AS 성명
    , INSERT(EMP_NO,9,6,REPEAT('*',5)) AS 주민번호
    , FORMAT(((SALARY+SALARY * COALESCE(BONUS,0)) * 12),0) AS 연봉
FROM
    employee
WHERE
    SUBSTRING(EMP_NO,8,1) IN (1,3)
;


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
SELECT
    EMP_NAME
    ,SUBSTRING_INDEX(EMAIL,'@',1) # EMAIL을 @ 기준으로 잘라서 첫번째 파트에 있는 값 반환
FROM
    employee
;


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
SELECT * FROM tbl_files;
SELECT
    file_no
    ,SUBSTRING_INDEX(file_path,'\\',-1)
FROM
    tbl_files
;


-- 4. 부서코드가 D5, D9인 직원들 중 2004년에 입사한 직원의 사번, 사원명, 부서코드, 입사일 조회
/*
    --------------- 출력 예시 ------------------------
    사번    사원명      부서코드    입사일
    --------------------------------------------------
    208	    김해술	    D5	        2004-04-30 00:00:00
*/
SELECT
    EMP_ID
    ,EMP_NAME
    ,DEPT_CODE
    ,HIRE_DATE
FROM
    employee
WHERE
    DEPT_CODE IN ('D5','D9')
AND YEAR(HIRE_DATE) = 2004
;


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
SELECT * FROM employee;
SELECT 
    EMP_NAME
    ,HIRE_DATE
    ,DAY(LAST_DAY(HIRE_DATE)) - DAY(HIRE_DATE) +1#입사당일
FROM
    employee
;


  
-- 6. EMPLOYEE 테이블에서 여자사원의 급여 총 합을 계산하시오.
/*
    ---------- 출력 예시 ------------
    급여 총 합
    ---------------------------------
    24816240
*/
SELECT
    SUM(SALARY)
FROM
    employee
WHERE
    SUBSTRING(EMP_NO,8,1) IN (2,4)
;

-- 7. 부서코드가 D5인 사원들의 급여총합, 보너스 총합 조회
/*
    ------- 출력 예시 ------------
    급여총합        보너스 총합
    ------------------------------
    15,760,000      745,000
*/
SELECT
    FORMAT(SUM(SALARY),0)
    ,FORMAT(SUM(SALARY*BONUS),0)
FROM
    employee
WHERE
    DEPT_CODE = 'D5'
;


-- 8. 부서코드가 D5인 직원의 보너스 포함 연봉의 총합 을 계산
/*
    ------- 출력 예시 ----------
    연봉
    ----------------------------
    198,060,000
*/
SELECT
    FORMAT(
        SUM((SALARY + SALARY*COALESCE(BONUS,0))*12),0)
FROM
    employee
WHERE
    DEPT_CODE = 'D5'
;


-- 9. 남/여 사원 급여합계를 동시에 표현
/*
    ---------------- 출력 예시 -------------------
    남사원 급여 합계          여사원 급여 합계
    ----------------------------------------------
    49,760,000                24,816,240
*/

SELECT
    
    # SQL 쿼리는 CASE 문 안에서 SUM(SALARY)을 사용하려고 했지만, 집계 함수(SUM())는 CASE 안에서 개별적으로 사용하면 오류가 발생
    FORMAT(SUM(CASE WHEN SUBSTRING(EMP_NO, 8, 1) IN ('1', '3') THEN SALARY ELSE 0 END),0) AS "남사원 급여 합계"
    ,FORMAT(SUM(CASE WHEN SUBSTRING(EMP_NO, 8, 1) IN ('2', '4') THEN SALARY ELSE 0 END),0) AS "여사원 급여 합계"
FROM
    employee
;

-- UNION
-- SELECT
--     FORMAT(SUM(SALARY),0)
-- FROM
--     employee
-- WHERE
--     SUBSTRING(EMP_NO,8,1) IN (2,4)
-- ;



-- 10. [EMPLOYEE] 테이블에서 사원들이 속해있는 부서의 수를 조회
/*
    ------ 출력 예시 -------
    부서 수
    ------------------------
    6
*/

SELECT
    COUNT(DISTINCT(DEPT_CODE))
FROM
    employee
;