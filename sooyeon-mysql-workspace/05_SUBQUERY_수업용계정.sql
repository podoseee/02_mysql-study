use menudb;

/*
    ## 서브쿼리
    1. SUBQUERY
    2. 하나의 쿼리문(main-query)안에 포함되어있는 또다른 쿼리문(sub-query)
    3. 메인 쿼리를 위해 보조 역할을 수행함
    4. 실행순서
        서브쿼리 -> 메인쿼리
    
    - 일반 서브쿼리 (중첩 서브쿼리)
        1) 단일행
        2) 다중행
    - 상관 서브쿼리
        1) 스칼라 서브쿼리
    - 인라인 뷰(파생테이블)
    
    5. 유의사항
        1) 서브쿼리는 반드시 소괄호로 묶어서 표기할 것
        2) 서브쿼리는 연산자의 우측에 위치해야함
        3) 서브쿼리 내에 order by절은 지원 안됨
*/

-- 간단 서브쿼리 예시1. 열무김치라떼의 카테고리면 조회
SELECT category_code FROM tbl_menu WHERE menu_name = '열무김치라떼'; # 8
SELECT category_name FROM tbl_category WHERE category_code = 8; # 8

-- 열무김치라떼와 category_code가 같은 카테고리 이름 출력 = 커피
SELECT
    category_name
FROM
    tbl_category
WHERE
    category_code = (SELECT category_code
                    FROM tbl_menu
                    WHERE menu_name = '열무김치라떼')
;

SELECT
    *
FROM
    tbl_menu
WHERE 
    category_code = (SELECT category_code
                    FROM tbl_menu
                    WHERE menu_name = '민트미역국') -- 4
;





/*
    단일행 서브쿼리 SINGLE ROW SUBAYERY
    1. 서브쿼리의 결과값이 한 행일 경우
    2. 서브쿼리를 가지고 일반 비교 연산자 사용 가능
        >, < , >=, <=, =, !=, <>
*/
-- 메뉴들의 평균 가격보다 저렴한 메뉴 조회
SELECT
    *
FROM
    tbl_menu
WHERE
    menu_price < (SELECT AVG(menu_price) FROM tbl_menu)
;

SELECT
    *
FROM
    tbl_menu
WHERE 
    menu_price = (SELECT MAX(menu_price) FROM tbl_menu)
;

SELECT
    *
FROM
    tbl_menu
WHERE 
    menu_price > (SELECT menu_price FROM tbl_menu WHERE menu_name = '한우딸기국밥')
;

SELECT
    *
FROM
    tbl_menu
WHERE
--     menu_price = (SELECT menu_price FROM tbl_menu WHERE menu_name = '생갈치쉐이크')
-- AND category_code =  (SELECT category_code FROM tbl_menu WHERE menu_name = '생갈치쉐이크')
    (menu_price, category_code) = (SELECT menu_price, category_code 
                                    FROM tbl_menu 
                                    WHERE menu_name = '생갈치쉐이크')
;




/*
    ## 다중행 서브쿼리 NULTI ROW SUBQUERY
    1. 서브쿼리의 결과값이 여러행일 경우
    2. 서브쿼리를 가지고일반 비교연산자만을 가지고 비교 불가
    3. 사용가눙한 연산자
        1) IN (값1, 값2, ...) : 여러개의 결과값 중에서 한개라도 일치하는 값이 있다면 참
        2) > ANY (값1, 값2, ...) : 값을 순차적으로 비교하여 1개라도 클 경우 참
        3) > ALL (값1, 값2, ...) : 모두 다 만족해야 참
*/

-- 열무김치라떼 OR 우럭스무디와 같은 카테고리의 메뉴 조회
SELECT
    *
FROM 
    tbl_menu
WHERE
    category_code IN (SELECT category_code  # 조회되는 결과가 1개 이상이기 때문에 IN으로 확인해야함
                        FROM tbl_menu
                        WHERE menu_name IN("열무김치라떼","우럭스무디"))
;

-- 가장 싼메뉴 조회
SELECT
    *
FROM 
    tbl_menu
WHERE
    menu_price <= ALL (SELECT menu_price FROM tbl_menu)  #메뉴 가격 반환 결과가 한개가 아니라 ALL로 모두 순차적 비교해야함
;

SELECT
    *
FROM 
    tbl_menu
WHERE
    menu_price > ALL (SELECT menu_price FROM tbl_menu WHERE category_code = 4)
;


SELECT * FROM department;


SELECT
    EMP_ID
    ,EMP_NAME
    , DEPT_CODE
    ,DEPT_TITLE
    ,SALARY
FROM
    employee
        LEFT JOIN department ON DEPT_ID = DEPT_CODE
WHERE
--    DEPT_TITLE LIKE '%영업%'
    DEPT_CODE IN (SELECT DEPT_ID FROM department WHERE DEPT_TITLE LIKE "%영업%")
;





















-- 동작하는 순서를 먼저 공부






/*
    ## 상관 서브쿼리
    1. 메인 서브쿼리의 값을 서브 쿼리에서 활용하는 방식
    2. 메인쿼리 테이블의 레코드(행)에 따라 서브쿼리의 결과도 매번 달라진다
    3. 메인쿼리에서 처리되는 각 행의 컬럼가뵤에 따라 응답이 달라져야될 경우 유용
*/


-- 카테고리별로 가격이 가장 비싼 메뉴 조회
SELECT
    menu_code
    ,menu_name
    ,menu_price
    ,m.category_code
FROM
    tbl_menu m
WHERE
    menu_price = (SELECT MAX(menu_price)
                    FROM tbl_menu
                    WHERE category_code = m.category_code) # 헤당 카테고리의 최대 가격
;

-- 카테고리벼ㅛㄹ 평균 가겨보다 높은 가격의 메뉴 조회
SELECT
    menu_code
    ,menu_name
    ,menu_price
    ,m.category_code
FROM
    tbl_menu m
WHERE
    menu_price >  (SELECT AVG(menu_price)
                    FROM tbl_menu
                    WHERE category_code = m.category_code)

;


-- 스칼라 서브쿼리
/*
    서브쿼리 VS 조인
    - 양이 많다면 조인
*/
SELECT
    menu_name
    ,m.category_code
    ,(SELECT category_name
        FROM tbl_category
        WHERE category_code = m.category_code) AS 카테고리명
FROM
    tbl_menu m
;
    


-- 전체 메뉴 조회시 각메뉴별로 몇건 주문되었는지
SELECT
    m.menu_code
    ,m.menu_name
    ,(SELECT category_name
        FROM tbl_category
        WHERE category_code = m.category_code) AS 카테고리명
FROM
    tbl_menu m
;
/*
    순회하는 순서는 from -> where -> group by => having => select => dorder by => limit
    위의 코드도 tbl_menu 테이블을 참조할것이라는 것을 확인한 후
    SELECT절에 들어간다. 만약 
*/


-- 실습, 전 사원의 사번, 시원명, 사수명 조회(단 사수가 없을 경우 '없음'으로 조회)
SELECT * FROM employee;
SELECT
    e.EMP_ID
    ,e.EMP_NAME
    , COALESCE((SELECT EMP_NAME
        FROM employee
        WHERE EMP_ID = e.MANAGER_ID),'업따')
FROM
    employee e
;


-- 실습. 전 사원의 사번, 사원명, 급여, 본인부서의 부서원수, 본인 부서의 평균급여 조회
SELECT
    e.EMP_ID
    ,e.EMP_NAME
    ,e.SALARY
    
    ,(SELECT COUNT(*)
        FROM employee
        WHERE DEPT_CODE = e.DEPT_CODE)
        
    ,FLOOR((SELECT AVG(SALARY)
        FROM employee
        WHERE DEPT_CODE = e.DEPT_CODE))
FROM
    employee e
;
    




















