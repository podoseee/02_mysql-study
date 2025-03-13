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
SELECT * FROM employee;
SELECT
    JOB_CODE
    , COUNT(*)
    ,AVG(SALARY)
    , FLOOR( AVG(SALARY)) # 소수점 버리고 출력해야됨 근데 CAST 왜 버려지지 않고 반올림되지? -> 그냥 FLOOR씀
FROM
    employee
GROUP BY
    JOB_CODE
HAVING
    JOB_CODE != 'J1'
;


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
SELECT * FROM employee;

SELECT
    LEFT(HIRE_DATE,4) AS 입사년
    , COUNT(*)
FROM
    employee
WHERE
    JOB_CODE != 'J1'
GROUP BY
    LEFT(HIRE_DATE,4)
ORDER BY
    입사년
;

-- 3. 성별 급여의 평균(정수처리), 급여의 합계, 인원수를 조회한 뒤 인원수로 내림차순을 정렬 하시오.
/*
    ------------------- 출력 예시 -------------------
    셩별     평균          합계           인원수
    -------------------------------------------------
    남       3,317,333     49,760,000       15
    여       2,757,360     24,816,240       9
*/
SELECT
    CASE
        WHEN SUBSTRING(EMP_NO, 8, 1) IN ('1', '3') THEN '남자'
        WHEN SUBSTRING(EMP_NO, 8, 1) IN ('2', '4') THEN '여자'
        ELSE '논바이너리'
    END AS 성별,
    FORMAT(AVG(SALARY),0),
    FORMAT(SUM(SALARY),0),
    COUNT(*)
FROM
    employee
GROUP BY
    성별
;

SELECT
    CASE
        WHEN SUBSTRING(EMP_NO, 8, 1) IN ('1', '3') THEN '남자'
        ELSE '여자'
    END AS 성별,
    FORMAT(AVG(SALARY),0),
    FORMAT(SUM(SALARY),0),
    COUNT(*)
FROM
    employee
GROUP BY
    성별
;
# 내가 조건을 ㄷ잘못 달아줌 그냥 1을 넣는 것은 if(1) 이라고 하는것ㄱ돠 똑같기ㅜ때문에 항상 참임 -  WHEN 1 THEN '남자'

    # SUBSTRING(EMP_NO,8,1)만 사용할 경우에는 1,2,3,4 총 4경우가 있어서 하나를 지정해주고 하는게 맞다.
    # 그니가 내가 코드가 틀린 이유는 SUBSTRING(EMP_NO,8,1) IN (1,3)이걸로 그룹바이로 하면 if(남자) else(여자) 로 처리가 되고 SELECT에서 CASE WHEN IN THEN으로 판단할 때 값이 0과 1이 오느느데 그걸로 CASE 문법을 판단할 ㅅ ㅜ없다는 거지 원래는 보통 EMP_NO로하면 값이 전달되어서 판단할 수 있는데 내가 조건을 잘못단거야?
    # 즉 그룹핑했을때 어떤 조건으로 분별하고 어떤 값이 기준이 되느냐가 중요하다
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
SELECT
    JOB_CODE
    ,COUNT(JOB_CODE)
FROM
    employee
GROUP BY
    JOB_CODE
HAVING
    COUNT(JOB_CODE) >= 3
;






