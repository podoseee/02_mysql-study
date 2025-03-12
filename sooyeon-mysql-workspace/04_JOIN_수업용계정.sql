-- 카테고리가 부여되지 않은 메뉴 데이터 한 개 추가하기
INSERT INTO tbl_menu VALUES(null, '찰순대쥬스',7000,null, 'Y');

SELECT * FROM tbl_menu;
/*
    ## JOIN
    1. 두 개 이상의 테이블에서 데이터를 조회할 때 사용되는 구문
        [
            테이블을 합쳐서 조회하는 방법
            1) UNION : 세로로 데이터를 합침
            2) JOIN : 가로로 데이터를 합침
        ]
    2. 연관성이 있는 컬럼을 기준으로 조인
     
     - EQUI JOIN : 두 컬럼가지고 동등비교(=)를 통해서 조인하는 방식
        - 내부 조인 INNER JOIN : 교집합 , 일반적으로 사용하는 JOIN
        - 외부 조인 OUTER JOIN : 합집합 
        - 교차 조인 CROSS JOIN : 곱집합
        - 자가 조인 SELF JOIN
        - 다중 조인 MULTIPLE JOIN
     - NON-EQUT JOIN : 동등조건(=)이 아닌 BETWEEN AND, IN, IS NULL 등에 의한 조인
*/

/*
    ## 내부 조인  INNER JOIN
    두 테이블 간의 연관성이 있는 컬럼으로 =을 이용하여 매칭시켜 조회
    만약 일치하는 행이 존재하지 않을 경우 조회에서 제외됨
*/

-- 메뉴 22행
-- 카테고리 12개행
-- 전체 메뉴(22행) 의 메뉴명, 카테고리명을 조회


-- ON 방식 : ON 뒤에 매칭시킬 컬럼에 대한 조건 작성, 두 컬럼명이 동일할 경우 각 테이블의 별칭을 활용하여 작성
SELECT
    menu_name
    , menu_price
    , m.category_code # 두 테이블중 어느 컬럼인지를 명시해야함
    ,category_name
FROM
    tbl_menu m
    INNER JOIN tbl_category c ON c.category_code = m.category_code; # tbl_menu와 tbl_category에 있는 category_code이 연결됨 그리고 category_name를 조회함. 만약 존재하지 않을 경우 출력하지 않음
;

--  USING 방식 : 매칭시킬 컬럼명이 동일할 경우 사용가능한 방식, USING구문 뒤에 매칭시킬 컬럼명 한개면 작성하면 됨
SELECT
    menu_code
    , menu_name
    , category_name
FROM
    tbl_menu
    JOIN tbl_category USING(category_code) # 권장하지 않음
;



-- ==============================================================================================================================================

use empdb;
SELECT * FROM employee;
SELECT * FROM department;

SELECT
    EMP_ID
    ,EMP_NAME
    ,EMP_NO
    ,DEPT_TITLE
FROM
    employee 
    JOIN department ON DEPT_ID = DEPT_CODE # 조인하는 컬럼 이름이 테이블마다 달라서 명시 안해도 됨
;

SELECT
    EMP_NAME
    , JOB_NAME
     , e.JOB_CODE
FROM
    employee e
    JOIN job j ON j.JOB_CODE = e.JOB_CODE
--    JOIN job USING(job_code);
--     NATURAL JOIN job
;

-- 대리 직급인 사원만 조회
SELECT
    EMP_NAME
    ,JOB_NAME
FROM
    employee e
    JOIN job j ON j.JOB_CODE = e.JOB_CODE
WHERE
    JOB_NAME = '대리'
;








-- 실습, 인사관리부인 사원의 사번, 이름 , 보너스 조회
SELECT
    EMP_ID AS 사번
    ,EMP_NAME AS 이름
    ,COALESCE(BONUS,-1) AS 보너스
--     , DEPT_TITLE
FROM
    employee
    JOIN department ON DEPT_ID = DEPT_CODE
WHERE
    DEPT_TITLE = '인사관리부'
;

-- 실습2 department, location을 참고하여 전체 부서들의 부서코드, 부서명, 근무지역명 조회
SELECT
    DEPT_ID AS 부서코드
    ,DEPT_TITLE AS 부서명
    ,LOCAL_NAME AS 근무지역명
FROM 
    department
    JOIN location ON LOCAL_CODE = LOCATION_ID
;
# 그니까 department에 LOCATION_ID컬럼이 있지 location에도 똑같은 값을 같는데 그냥 컬럼 이름만 다른 LOCAL_CODE이 있단말이야. 둘이 join해서 만약 department의 LOCATION_ID = location의 LOCAL_CODE이 같으면 location의 LOCAL_NAME이 출력
-- 실습3 보너스를 받는 사원의 사번, 사원명, 보너스, 부서명 조회
SELECT
    EMP_ID AS 사번
    ,EMP_NAME AS 사원명
    ,COALESCE(BONUS, '없음') AS 보너스
    ,DEPT_TITLE AS 부서명
FROM
    employee
    LEFT JOIN department ON DEPT_ID = DEPT_CODE
WHERE
    BONUS IS NOT NULL
;

-- 실습4 :  부서가 총무부가 아닌 사원의 사원명 급여 조회
SELECT
    EMP_NAME AS 사원명
    ,SALARY AS 급여
--     ,DEPT_TITLE
FROM
    employee
    JOIN department ON DEPT_ID = DEPT_CODE
WHERE
    DEPT_TITLE != '총무부'
;































