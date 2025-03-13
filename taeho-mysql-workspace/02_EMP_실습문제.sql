use empdb;
SELECT * FROM EMPLOYEE;
-- 1. employee 테이블에서 남자사원만 사원번호, 사원명, 주민번호, 연봉을 나타내세요.
--    연봉은 보너스 포함 연봉((기존 급여 + 급여 * bonus) * 12)으로 연산하시오.
--    주민번호의 뒷6자리는 *처리하세요.
SELECT
    EMP_ID AS '사원번호'
  , EMP_NAME AS '성명'
  , INSERT(EMP_NO, 9, 6, '******') AS '주민번호'
  , FORMAT((SALARY + SALARY*IFNULL(BONUS, 0)) * 12,0) AS 연봉
FROM
    employee
WHERE
    EMP_NO LIKE '%-1%' 
    OR EMP_NO LIKE '%-3%'; 

-- 2. EMPLOYEE 테이블에서 사원명, 아이디(이메일 @ 앞부분)을 조회하세요.
SELECT EMP_NAME
, LEFT(EMAIL, LOCATE('@', EMAIL) -1) AS 'EMAIL_ID'
FROM employee;

-- 3. 아래의 구문들을 실행하여 tbl_files 테이블이 생성되고 데이터가 추가되면 
--    파일경로를 제외하고 파일명만 아래와 같이 출력하세요.
/*
CREATE TABLE tbl_files (
   file_no BIGINT,
   file_path VARCHAR(500)
);
INSERT INTO tbl_files VALUES(1, 'c:\\abc\\deft\\salesinfo.xls');
INSERT INTO tbl_files VALUES(2, 'c:\\music.mp3');
INSERT INTO tbl_files VALUES(3, 'c:\\documents\\resume.hwp');
COMMIT;
*/

SELECT * FROM tbl_files;

SELECT 
FILE_NO AS '파일 번호'
, SUBSTRING_INDEX(FILE_PATH,'\\',-1) AS '파일명'
FROM tbl_files;

-- 4. 부서코드가 D5, D9인 직원들 중 2004년에 입사한 직원의 사번, 사원명, 부서코드, 입사일 조회
SELECT
    EMP_ID AS '사번'
    , EMP_NAME AS '사원명'
    , DEPT_CODE AS '부서코드'
    , HIRE_DATE AS '입사일'
FROM employee
WHERE (DATE_FORMAT(HIRE_DATE,"%Y")) = 2004;

-- 5. 직원명, 입사일, 입사한 달의 근무일수(주말에도 근무하는 걸로 가정) 조회
SELECT 
EMP_NAME AS '직원명'
    , HIRE_DATE AS '입사일'
    , DATEDIFF(LAST_DAY(HIRE_DATE), HIRE_DATE) + 1 AS '입사한 달의 근무일수'
FROM employee;

-- 6. EMPLOYEE 테이블에서 여자사원의 급여 총 합을 계산하시오.
SELECT
    SUM(SALARY) AS '급여 총 합'
FROM
    employee
WHERE
    EMP_NO LIKE ('%-2%') 
    OR EMP_NO LIKE ('%-4%');
    
-- 7. 부서코드가 D5인 사원들의 급여총합, 보너스 총합 조회
SELECT
    FORMAT(SUM(SALARY),0) AS '급여 총 합'
  , FORMAT(SUM(SALARY * BONUS),0) AS '보너스 총 합'
FROM
    employee
GROUP BY
    DEPT_CODE
HAVING
    DEPT_CODE = 'D5';

-- 8. 부서코드가 D5인 직원의 보너스 포함 연봉의 총합 을 계산
SELECT
    FORMAT((SUM(SALARY) + SUM(SALARY * BONUS)) * 12,0) AS '연봉'
FROM
    employee
GROUP BY
    DEPT_CODE
HAVING
    DEPT_CODE = 'D5';
    
-- 9. 남/여 사원 급여합계를 동시에 표현
SELECT 
    FORMAT(MAIL_SUM, 0) AS '남사원 급여 합계', 
    FORMAT(FEMAIL_SUM, 0) AS '여사원 급여 합계'
FROM 
    (SELECT SUM(e1.SALARY) AS 'MAIL_SUM'
    FROM employee e1 
    WHERE e1.EMP_NO LIKE '%-1%' OR e1.EMP_NO LIKE '%-3%') AS M
JOIN 
    (SELECT SUM(e2.SALARY) AS 'FEMAIL_SUM'
    FROM employee e2 WHERE e2.EMP_NO LIKE '%-2%' 
    OR e2.EMP_NO LIKE '%-4%'
) AS F;

-- 10. [EMPLOYEE] 테이블에서 사원들이 속해있는 부서의 수를 조회
SELECT
    COUNT(DISTINCT(DEPT_CODE)) AS '부서 수'
FROM
    employee;