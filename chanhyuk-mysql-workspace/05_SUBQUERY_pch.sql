use menudb;
/*
    ## 서브쿼리 ##
    1. SUBAQUERY
    2. 하나의 쿼리문(main-query) 안에 포함되어있는 또다른 쿼리문(sub-query)
    3. 메인 쿼리를 위해 보조 역할을 수행함
    4. 실행순서
        서브쿼리 -> 메인쿼리
    5. 유형
        1) 일반 서브쿼리 (중첩 서브쿼리)
            - 단일행 서브쿼리
            - 다중행 서브쿼리
        2) 상관 서브쿼리
            - 스칼라 서브쿼리
        3) 인라인 뷰 (파생테이블)
    6. 유의사항
        1) 서브쿼리는 반드시 소괄호로 묶어서 표기할 것
        2) 서브쿼리는 연산자의 우측에 위치해야함
        3) 서브쿼리 내에 order by 절은 지원되지 않음
*/

-- 1) tbl_menu로부터 열무김치라떼의 카테고리번호 조회(서브쿼리)
select category_code from tbl_menu where menu_name = '열무김치라떼';

-- 2) tbl_category로 부터 해당 카테고리번호의 카테고리명 조회(메인쿼리)
select category_name from tbl_category where category_code = 8;

select 
    category_name
from 
    tbl_category
where
    category_code = (
        select 
            category_code 
        from 
            tbl_menu 
        where 
            menu_name = '열무김치라떼'
    );
    

-- 서브쿼리 예제 2
-- 1) tbl_menu로부터 민트미역국의 카테고리번호 조회
select category_code FROM tbl_menu WHERE menu_name = '민트미역국';

-- 2) tbl_menu로부터 해당 카테고리번호의 메뉴들 조회(메인쿼리)
select menu_code, menu_name, menu_price, orderable_status from tbl_menu where category_code = 4;

select
    menu_code
,   menu_name
,   menu_price
,   orderable_status
from
    tbl_menu
where
    category_code = (
    select category_code 
    FROM tbl_menu 
    WHERE menu_name = '민트미역국'
);

/*
    ## 단일행 서브쿼리 (Single Row Subquery) ##
    1. 서브쿼리의 결과값이 한 행일 경우
    2. 서브쿼리를 가지고 일반 비교 연산자 사용 가능
       >, <, >=, <=, =, !=, <>
*/

-- 가격이 제일 비싼 메뉴
select * from tbl_menu order by menu_price desc limit 1;

-- 한우딸기국밥보다 비싼 메뉴 조회
select menu_price from tbl_menu where menu_name = '한우딸기국밥';
select * 
from tbl_menu 
where menu_price > (
    select menu_price from tbl_menu where menu_name = '한우딸기국밥'
    );


/*
    ## 다중행 서브쿼리 (Multi Row Subquery) ##
    1. 서브쿼리의 결과값이 여러행일 경우
    2. 서브쿼리를 가지고 일반 비교연산자만을 가지고 비교 불가
    3. 사용가능한 연산자
        1) IN(값1, 값2, ..)
            여러개의 결과값 중에서 한개라도 일치하는 값이 있다면 참
        2) > ANY (값1, 값2, ..)
            값1 보다 크거나(or), 값2 보다 크거나(or), ... 일 경우 참
            즉, 여러개의 값들 중 한개라도 클 경우 참
        3) > ALL (값1, 값2, ...)
            값1 보다 크고(and), 값2 보다 크고(and), ... 여야만 참
            즉, 여러개의 값들보다 커야만 참
*/
-- 영업부에 해당하는 사원들의 사번, 사원명, 부서명, 급여 조회
use empdb;
select emp_id, emp_name, dept_title, salary
from employee join department on dept_id = dept_code
where dept_code in (select dept_id from department where dept_title like '%영업%');




/*
    ## 상관 서브쿼리 ##
    1. 메닝쿼리의 값을 서브쿼리에서 활용하는 방식
    2. 메인쿼리 테이블의 레코드(행)에 따라 서브쿼리의 결과도 매번 달라짐
    3. 메인쿼리에서 처리되는 각 행의 컬럼값에 따라 응답이 달라져야 될 경우 유용
*/
use menudb;
-- 카테고리별로 가격이 가장 비싼 메뉴 조회
SELECT
    menu_code
,   menu_name
,   menu_price
,   category_code
FROM
    tbl_menu m
WHERE
    menu_price = (select max(menu_price) from tbl_menu where category_code = m.category_code); -- m.category_code : 메인쿼리의 각 행 스캔시 그때마다의 카테고리번호
    
-- 카테고리별 평균가격보다 높은 가격의 메뉴 조회

/*
    ## 인라인 뷰(Inline-View) ##
    1. FROM 절에 작성하는 서브쿼리
    2. 서브쿼리 수행 결과를 마치 하나의 테이블처럼 활용 가능(가상 테이블)
    
    * View 란?
    1) 실제테이블에 근거한 논리적인 가상테이블
    2) 종류
        - inline view : from절에 작성하는 서브쿼리로 임시로 테이블처럼 활용, 1회용
        - stored view : 서브쿼리 구문을 view 객체로 생성해두고 사용 가능
                        영구적 사용 가능
*/

use menudb;
-- 카테고리별 메뉴개수가 가장 많은거 조회
SELECT
    max(메뉴개수)
    , min(메뉴개수)
FROM (SELECT
        category_code 카테고리,
        COUNT(*) 메뉴개수
      FROM
      tbl_menu
      GROUP BY
      category_code) menu_cnt;
      
WITH menu_count AS(
SELECT
category_code 카테고리,
COUNT(*) 메뉴개수
FROM
tbl_menu
GROUP BY
category_code
)

SELECT
*
FROM
    menu_count;















