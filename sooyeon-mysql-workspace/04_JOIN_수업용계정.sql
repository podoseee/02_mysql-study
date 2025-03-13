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











-- ==================================================================================================================
-- 외
-- 부
-- 조
-- 인
/*
    좌측/우측 테이블을 기준으로 조인시키는 방법
    기준이 되는 테이블에는 누락되는 행 없이 조회
    즉 INNER JOIN에서 특정 테이블에서 누락된 행을 같이 조회시키고자 할 때 사용
*/

# 메뉴 테이블에서 1개 행 누락, 카테고리 테이블에서 4개행 누락
SELECT
    menu_name
    ,category_name
FROM
    tbl_menu
        JOIN tbl_category USING(category_code) # 찰순대쥬스는 매칭되는 카테고리코드가 없기 떄문에 뜨지 않음
; # 그냥 조인은 두 테이블에서 일치하는 데이터만 반환함

-- LEFT PUTER JOIN
SELECT
    menu_name
    ,category_name
FROM
    tbl_menu
        LEFT JOIN tbl_category USING(category_code) # tbl_menu을 기준으로 모든 행을 유지하며 동작되며 없는 경우, category_code이 NULL이 됨
;
    
-- RIGHT OUTER JOIN
SELECT
    menu_name
    ,category_name
FROM
    tbl_menu
        RIGHT JOIN tbl_category USING(category_code); # tbl_category을 기준으로 모든 행을 유지하여 없는 경우, tbl_menu이 NULL이 됨

use empdb;

-- 전체 사원에 대해 사원명, 부서명, 급여 조회
SELECT
    EMP_NAME
    ,DEPT_TITLE
    ,SALARY
FROM
    employee
        LEFT JOIN department ON DEPT_ID = DEPT_CODE # 부서가 NULL인 사원도 띄워야함
;




use menudb;
-- ===================================
/*
## 교차 조인 Cross Join, Cartesian Product
모든 테이블의 각 행들이 서로 매핑된 데이터가 조회됨
두 테이블의 행들이 모두 곱해진 행들의 조합이 출력
*/
SELECT
    menu_name
    ,category_name
FROM
    tbl_menu
        JOIN tbl_category; # == CROSS JOIN tbl_category;
    

/*
    ## 자가조인 SELF JOIN
    조인할 때 다른 테이블이 아닌 자기 자신과 조인을 맺는 방식
*/
SELECT * FROM tbl_category; # 자기 자신의 컬럼과 관련있음 식사 -한식,중식,일식

SELECT
    c1.category_code
    ,c1.category_name
    ,c1.ref_category_code
    
    ,c2.category_code
    ,c2.category_name
FROM
    tbl_category c1
        JOIN tbl_category c2 ON c2.category_code = c1.ref_category_code
; # category_code ref_category_code 재정의?

use empdb;

SELECT * FROM employee;
SELECT
    e1.EMP_NAME
    ,COALESCE(e2.EMP_NAME,"업다") # MANAGER_ID이 EMP_ID라고 재정의했으며, EMP_ID와 매칭이 되는 EMP_NAME이 출력이된다.
FROM
    employee e1
        LEFT JOIN employee e2 ON e2.EMP_ID = e1.MANAGER_ID # 사수 정보는 ID로 저장하고 그 ID는 사원번호임으로 두개가 같다고 재정의한다.
;

SELECT * FROM employee;
SELECT * FROM SAL_GRADE;

SELECT
    EMP_NAME
    ,SALARY
    ,s.SAL_LEVEL
FROM
    employee e
        JOIN SAL_GRADE s ON e.SALARY BETWEEN s.MIN_SAL AND S.MAX_SAL # SALARY가 MIN_SAL과 MAX_SAL 사이에 있는 SAL_GRADE의 SAL_LEVEL과 매칭 - 범위를 지정함
        # JOIN SAL_GRADE s ON  s.SAL_LEVEL = e.SAL_LEVEL
;


/*
    다중 조인
*/
-- 사번, 사원명, 부서명, 직급명
SELECT * FROM employee; -- DEPT_CODE, JOB_CODE
SELECT * FROM department; -- DEPT_ID
SELECT * FROM job; -- JOB_CODE

SELECT
    EMP_ID
    ,EMP_NAME
    ,DEPT_TITLE # department과
    , JOB_NAME # job과
FROM    
    employee e
        LEFT JOIN department ON DEPT_CODE = DEPT_ID
        JOIN job j ON j.JOB_CODE = e.JOB_CODE
;

-- 사번 사원명 근무지역명\
SELECT * FROM location;
SELECT * FROM department;
SELECT
    EMP_ID
    ,EMP_NAME
    ,LOCAL_NAME
FROM
    employee
    LEFT JOIN department ON DEPT_ID = DEPT_CODE ## department의 근무코드가 employee의 근무코드를 참조
    JOIN location ON LOCAL_CODE = LOCATION_ID ## location의 지역코드가 department의 지역아이디를 참조 
    # 즉 location(LOCAL_CODE) <- department의(LOCATION_ID) DEPT_ID<- employee(DEPT_CODE)
    /*
        고용자의 근무지역을 출력하기 위해서는location 테이블이 필요한데 공공된 컬럼이 없다.
         department는 근무 지역을 판별한 컬럼과 고용자의 부서 아이디도 소지하고 있다 즉 증검다리가 된다.
         먼저 employee와 공통적인ㄴ 필드 DEPT_CODE departmentDEPT_ID를 같다고 정의한다.
         이제 이 두 컬럼 값이 같다면 동일시 처리한다.
         그리고 location의 컬럼 LOCAL_CODE과 department의 LOCATION_ID를 정의해 최종 연결한다.
         그럼 동일시 처리된 employee의 department이 만약 location과 LOCAL_CODE이 같을 경우
         employee는 location의 컬럼을 끌어다 쓸 수 있는 것이다.
    */

;

SELECT * FROM job;
SELECT * FROM nation;
SELECT
    EMP_ID
    ,EMP_NAME
    , DEPT_TITLE
    ,l.LOCAL_CODE
    ,n.NATIONAL_NAME
    ,j.JOB_NAME
FROM
    employee e
    LEFT JOIN department d ON d.DEPT_ID = e.DEPT_CODE
    LEFT JOIN location l ON l.LOCAL_CODE = d.LOCATION_ID
    LEFT JOIN nation n ON n.NATIONAL_CODE = l.NATIONAL_CODE
     JOIN job j ON j.JOB_CODE = e.JOB_CODE
;
/*
    지역명을 출력하기 위해서는 위위서와 마찬가지로 징검다리인 department기 필요하다
    DEPT_ID와 DEPT_CODE를 동일시 정의하고 location과 department기의 LOCAL_CODE까지 이어준다.
    [LOCAL_CODE, NATIONAL_CODE] -> employee -> (DEPT_CODE==DEPT_ID) -> department -> (LOCATION_ID == LOCAL_CODE) -> location
     [NATIONAL_NAME] -> location -> (NATIONAL_CODE == NATIONAL_CODE) -> nation
     
    직무를 출력하기 위해서는 
    employee의 JOB_CODE와 job의 JOB_CODE를 정의한다. 
    [JOB_NAME] -> employee -> (JOB_CODE == JOB_CODE) -> job

*/






















