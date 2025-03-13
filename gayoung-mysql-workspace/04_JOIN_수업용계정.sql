-- 카테고리가 부여되지 않은 메뉴 데이터 한개 추가하기 
use menudb;
INSERT INTO tbl_menu VALUES(null, '찰순대주스', 7000, null, 'Y'); -- NN 낫널 해제

SELECT * FROM tbl_category;

/*
    ## JOIN ##
    1. 두개 이상의 테이블에서 데이터를 조회할때 사용되는 구문
       [
       tbl_category     테이블을 합쳐서 조회하는 방법
            *******************************
            1) union : 세로로 데이터를 합침
            2) join : 가로로 데이터를 합침
       ]
    2. 연결을 시킬때는 반드시 연관성이 있는 컬럼을 기준으로 조인 
    3. 종류
       1) EQUI JOIN : 두 컬럼을 가지고 동등비교(=)를 통해서 조인하는 방식 
          - INNER JOIN : 교집합 (일반적으로 사용하는 JOIN)
          - OUTER JOIN : 합집합 
          - CROSS JOIN : 곱집합 
          - SELF JOIN 
          - 다중 조인 (MULTIPLE JOIN)
       2) NON-EQUI JOIN : 동등조건(=)이 아닌 BETWEEN AND, IN, IS NULL 등에 의한 조인 
       
    */ 
    /*
        ## 내부조인 ##
        두 테이블 간에 연관성이 있는 컬럼으로 = 을 통해 매칭시켜 조회
        만약 일치하는 행이 존재하지 않을 경우 조회에서 제외됨 
    */

-- on 방식 : on 뒤에 매칭시킬 컬럼에 대한 조건 잣겅
--           단, 두 컬럼명이 돌일할 경우 각 테이블의 별칭을 활용해서 작성
--            (그렇지 않으면 ambiguous 발생)
    SELECT
        menu_name
      , category_name
    FROM
        tbl_menu Atbl_menu
        /*INNER*/ JOIN tbl_category B ON A.category_code = B.category_code;

-- 좌측 tbl_menu의 category_code가 null인 1개의 행 제외
-- 우측도 code가 1,2,3,7인 행 제외

-- **************
-- USING 방식 : 매칭시킬 컬럼명이 동일할 경우, 사용 가능한 방식 
--              USING 구문 뒤에 매칭시킬 컬럼명 한개만 작성하면됨

SELECT 
    menu_code
  , menu_name
  , category_name
FROM
    tbl_menu
    JOIN tbl_category USING(category_code)  -- 근데 되도록 on 사용하기
;

use empdb;
SELECT * FROM department;
SELECT * FROM employee;

SELECT
    emp_id
  , emp_name
  , emp_no
  , dept_title
FROM
    employee
    JOIN department ON dept_id = dept_code;

SELECT
* 
  --  EMP_ID
 -- , EMP_NAME
 -- , BONUS
FROM
    employee
    JOIN department ON dept_id = dept_code
WHERE
    dept_title = '인사관리부';
    
SELECT
    DEPT_ID
  , DEPT_TITLE
  , LOCAL_NAME
FROM
    DEPARTMENT
    JOIN LOCATION ON LOCAL_CODE = LOCATION_ID;
    

SELECT 
    *
FROM
    EMPLOYEE
    JOIN DEPARTMENT ON DEPT_ID = DEPT_CODE
WHERE
    BONUS IS NOT NULL;


SELECT
    *
FROM 
    employee
    JOIN department ON (dept_id = dept_code)
WHERE
    dept_title != '총무부';
    
    
/*
    ## 외부 조인 (outer join) ##
    좌측/ 우측 테이블을 기준으로 조인시키는 방법
    기준이 되는 테이블에는 누락되는 행 없이 조회됨
    즉, inner join에서 특정 테이블에 누락된 행을 같이 조회시키고자 할 때 사용
*/

-- inner join : 메뉴테이블에 1개 행 누락, 카테고리에서는 4개 행 누락 /매칭이 안돼서/) 
SELECT
    menu_name
  , category_name
FROM
    tbl_menu
        LEFT OUTER JOIN tbl_category USING(category_code);
        -- 카테고리 번호가 NULL이었던 메뉴 1개 추가적으로 조회됨 
use empdb;

-- 전체 사원에 대해 사원명, 부서명, 급여 조회
 
 SELECT 
    emp_name
  , IFNULL(dept_title, '없음') 
  , salary
FROM
    employee
        LEFT JOIN department ON dept_id = dept_code
;

/*
크로스 조인
모든 테이블의 각 행들이 서로 매핑된 형태로 조인됨
조건을 누락시켰을 때 발생가능성 있음
**********************************
*/

SELECT
    menu_name
  , category_name
FROM
    tbl_menu
    CROSS JOIN tbl_category;
    
/*
셀프조인
조인할 때 다른 테이블이 아닌 자기 자신과 조인을 맺는 방식 
*/
use menudb;
SELECT 
    c1.category_code
  , c1.category_name
  , c1.ref_category_code
  , c2.category_code
  , c2.category_name
FROM 
    tbl_category c1 -- c1.ref_category_code와 일치하는 카테고리번호를 가진 카테고리명을 조회
        JOIN tbl_category c2 ON c2.category_code = c1.ref_category_code;
        
use empdb;
SELECT * FROM employee;
-- 실습. 사원명()과 사수명(MANAGER_ID > NAME)을 조회하시오

SELECT 
    emp.EMP_NAME 사원명 
  , mng.EMP_NAME 사수명
FROM 
    employee emp
        JOIN employee mng ON emp.MANAGER_ID = mng.EMP_ID;
/*
    ## 비등가조인 (NON-EQUI JOIN)
    매칭시킬 컬럼에 대한 조건을 =이 아니라 다른 연산자로 할 경우
*/
SELECT * FROM employee; -- salary
SELECT * FROM sal_grade; -- min_sal, max_sal

-- 사원명, 급여, 급여등급 

SELECT 
    emp_name
  , salary
  , s.sal_level -- 해당 컬럼이 두테이블에 모두 있어서 as 지정해줘야됨 
FROM
    employee 
        JOIN sal_grade s ON salary BETWEEN min_sal AND max_sal;
        
/*
    ## 다중 조인
*/

-- 사번, 사원명, 부서명, 직급명
SELECT * FROM employee;  -- dept_code, job_code
SELECT * FROM department; -- dept_id
SELECT * FROM job;        --            job_code

use empdb;
SELECT * FROM location;
SELECT * FROM department;
SELECT * FROM employee; 
SELECT
    emp_id
  , emp_name
  , dept_title
  , job_name
FROM
    employee e
        LEFT JOIN department ON dept_id = dept_code
        JOIN job j /*컬럼명 같으니까*/ ON j.job_code = e.job_code; 

-- 실습. 사번, 사원명, 근무지역명
-- dept_code >> [department] dept_id : location_ID >>[location]local_code:local_name
SELECT
    emp_id
  , emp_name
  , local_name
  
FROM
    employee
        JOIN department ON dept_code = dept_id  -- 조인 순서도 중요함
        JOIN location ON location_id = local_code;

SELECT * FROM location;
SELECT * FROM department;
SELECT * FROM employee; -- DEPT_CODE >> [department] DEPT_ID : DEPT_TITLE : LOCATION_ID >> [LOCATION] LOCAL_CODE : NATIONAL_CODE, LOCAL_NAME

SELECT
    EMP_ID
  , EMP_NAME
  , DEPT_TITLE
  , LOCAL_NAME 
  , NATIONAL_NAME
  , JOB_NAMEs
FROM
    employee
        LEFT JOIN department ON dept_id = dept_code
        LEFT JOIN location ON location_id = local_code
        LEFT JOIN nation USING(national_code)
        JOIN job USING(job_code);
    