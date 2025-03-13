use menudb;

/*
    ## 서브쿼리 ## 
    1. SUBQUERY
    2. 하나의 쿼리문(MAIN QUERY) 안에 포함되어있는 또다른 쿼리문(SUB QUERY)
    3. 메인 쿼리를 위해 보조 역할을 수행함
    4. 실행순서 
        서브쿼리 > 메인쿼리
    5. 유형
       1) 일반 서브쿼리 (중첩 서브쿼리)
        - 단일행 서브쿼리
        - 다중행 서브쿼리
       2) 상관 서브쿼리 
        - 스칼라 서브쿼리
       3) 인라인 뷰 (파생테이블)
    6. 유의사항
       1) 서브쿼리는 반드시 소괄호로 묶어서 표기할 것 
       2) 서브쿼리는 연산자의 우측에 위해야됨
       3) 서브쿼리 내에 order by 절은 지원 안됨 
*/

-- 간단 서브쿼리 예시1. 열무김치라떼의 카테고리명 조회 
-- 1) tbl_menu로 부터 열무김치라떼의 카테고리번호 조회
use menudb;

SELECT category_code  -- (sub)
FROM tbl_menu
WHERE menu_name = '열무김치라떼';

-- 2) tbl_category로부터 해당 카테고리번호의 카테고리명 조회 (main)
SELECT category_name 
FROM tbl_category 
WHERE category_code = 8; -- 커피

SELECT category_name 
FROM tbl_category 
WHERE category_code = (SELECT category_code  -- (sub)
                        FROM tbl_menu
                        WHERE menu_name = '열무김치라떼');  -- 서브쿼리 드레그 후 CTRL + SHIFT+ ENTER 하면 서브쿼리만 실행
                        
 -- 간단 서브쿼리 예시2 . 민트미역국과 같은 카테고리의 메뉴들 조회
SELECT * -- menu_name
FROM tbl_menu
WHERE category_code = (SELECT category_code
                         FROM tbl_menu
                        WHERE menu_name = '민트미역국');
 
/*
단일행 서브쿼리
1. 서브쿼리의 결과값이 한 행일 경우
2. 서브쿼리를 가지고 일반 비교 연산자 사용가능 
*/

-- 메뉴들의 평균가격 보다 저렴한 메뉴 조회
SELECT
    menu_code
  , menu_name
  , menu_price 
FROM
    tbl_menu
WHERE
    menu_price < (SELECT AVG(menu_price)
                    FROM tbl_menu);

-- 가격이 제일 비싼 메뉴 조회
SELECT
    MAX(menu_price)
    , menu_name
FROM 
    tbl_menu
WHERE
    menu_price > (SELECT MAX(menu_price)
                    FROM tble_menu);

-- 실습 . 생갈치쉐이크와 같은 가격이고, 같은 카테고리인 메뉴 조회 
SELECT
    menu_code
    , menu_name
    , menu_price
    , category_code
FROM 
    tbl_menu
WHERE
    (menu_price, category_code) = (SELECT menu_price, category_code
                    FROM tbl_menu
                    WHERE menu_name = '생갈치쉐이크');
                    -- 단일 행 (다중열) 서브쿼리 : 컬럼을 묶어서 비교 가능 

/*
    ## 다중행 서브쿼리 
    1. 서브쿼리의 결과값이 여러행인 경우
    2. 서브쿼리를 가지고 일반 비교연산자만을 가지로 비교불가 
    3. 사용가능한 연산자 
       1) IN (값1, 값2, ...) : 여러개의 결과값 중에서 한개라도 일치하는 값이 있다면 참
       2) > ANY(값1, 값2, ..) : 값1보다 크거나, 값2보다 크거나,...일 경우 참(결국엔 OR)
                                즉, 여러개의 값들 중 한개라도 클 경우 참
         > ALL(") : 크고, 크고, 모든 값들보다 커야 참이다. (AND 연상)
                    즉, 여러대의 값들 보다 커야만 참이다. 
*/

SELECT 
    menu_name
  , category_code
FROM
    tbl_menu
WHERE
    category_code IN (SELECT category_code
                        FROM tbl_menu
                       WHERE menu_name IN ('열무김치라떼', '우럭스무디'));
                       
/*
    ## 상관 서브쿼리 ##
    1. 메인쿼리의 값을 서브쿼리에서 활용하는 방식
    2. 메인쿼리 테이블의 레코드에 따라 서브쿼리의 결과도 매번 달라짐
    3. 메인쿼리에서 처리되는 각행의 컬럼값에 따라 응답이 달라져야될 경우 유용
*/    

use menudb;
SELECT * FROM tbl_menu;

-- 카테고리별로 가격이 가장 비싼 메뉴를 조회 
SELECT 
    menu_name
  , menu_price
  , category_code
FROM
    tbl_menu m
WHERE
    menu_price = (SELECT 
                    MAX(menu_price)
                 FROM 
                    tbl_menu
                 WHERE 
                    category_code = m.category_code); 
                    -- m.category_code: 메인쿼리의 각 행 스캔시, 그때마다의 카테고리
                    
-- 카테고리별 평균가격보다 높은 가격의 메뉴 조회 
SELECT
    menu_code
  , menu_name
  , m.category_code
  , menu_price
FROM 
    tbl_menu m
WHERE
--    menu_price > 해당메뉴카테고리의평균가격;
    menu_price > (SELECT AVG(menu_price)
                    FROM tbl_menu
                   WHERE category_code = m.category_code)
ORDER BY
    category_code;

-- * 스칼라 서브쿼리
-- 메뉴명과 카테고리명 조회 (서브쿼리 활용)
 SELECT 
    menu_name
  , m.category_code
  , (SELECT category_name
       FROM tbl_category
      WHERE category_code = m.category_code) 카테고리명
FROM
    tbl_menu m;
                        
-- 전체 메뉴 조회시 각메뉴별로 몇건 주문되었는지 
SELECT
    m.menu_code
  , m.menu_name 
  , (SELECT COUNT(*)
       FROM tbl_order_menu
       WHERE menu_code = m.menu_code) "주문건수"
FROM 
    tbl_menu m;
    
use empdb;
-- 실습. 전 사원의 사번, 사원명, 사수명 조회 (단, 사수가 없을 경우 "없음"으로 조회되도록)
SELECT * FROM employee;

SELECT 
    EMP_ID
  , EMP_NAME
  , IFNULL((SELECT EMP_NAME
      FROM employee
      WHERE e.MANAGER_ID = EMP_ID), '없음') 사수명
FROM employee e;

-- 실습. 전 사원의 사번, 사원명, 급여,  본인부서의 부서원수, 본인부서의 평균급여 조회
SELECT 
    EMP_ID
  , EMP_NAME
  , SALARY
  , (SELECT COUNT(*)
      FROM employee
     WHERE dept_code = e.dept_code) 부서원수
  , ROUND((SELECT AVG(SALARY)
       FROM employee
    WHERE dept_code = e.dept_code)) 부서평균급여
FROM
   employee e;   
   
    
/*
    ## 인라인 뷰 (Inline-View) ##
    1. FROM절에 작성하는 서브쿼리
    2. 서브쿼리 수행 결과를 마치 하나의 테이블처럼 활용 가능 (가상 테이블)
    
    * View란?
    1) 실제테이블에 근거한 논리적인 가상테이블 
    2) 종류
       - inline view : from절에 작성하는 서브쿼리로 임시로 테이블처럼 활용, 1회용
       - stored view : 서브쿼리 구문을 VIEW 객체로 생성해두고 사용 가능 
                       영구적으로 사용 가능
*/

use menudb;
-- 카테고리별 메뉴개수가 가장 많은거 조회

SELECT MAX(개수)
FROM (SELECT 
    category_code, count(menu_name) 개수
FROM tbl_menu
GROUP BY category_code) menu_count
;

with menu_count as 
 (SELECT 
    category_code, count(menu_name) 개수
FROM tbl_menu
GROUP BY category_code)
SELECT
    * 
FROM 
    menu_count;


                        