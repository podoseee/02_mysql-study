use menudb;

-- 서브쿼리

-- 예시1. 열무김치라떼의 카테고리명 조회
-- tbl_menu로 부터 열무김치라뗴의 카테고리번호 조회 -> 서브쿼리
SELECT
    menu_name
    , category_code
FROM
    tbl_menu
WHERE
    menu_name = '열무김치라떼';
    
-- tbl_category로 부터 해당 카테고리 번호의 카테고리명 조회 -> 메인쿼리
SELECT
    category_name
FROM
    tbl_category
WHERE
    category_code = 8
;
-- 서브쿼리 활용
SELECT
    category_name
FROM
    tbl_category
WHERE
    category_code = (
    SELECT
        category_code
    FROM
        tbl_menu
    WHERE
        menu_name = '열무김치라떼'
    -- 결과 => 8
    )
;

-- 예시2. 민트미역국과 같은 카테고리의 메뉴들 조회
SELECT
    menu_code
    , menu_name
    , menu_price
    , orderable_status
FROM
    tbl_menu
WHERE
    category_code = (
    SELECT
        category_code
    FROM
        tbl_menu
    WHERE
        menu_name = '민트미역국'
    );
    
-- 메뉴들의 평균가격보다 저렴한 메뉴 조회
SELECT
    menu_code
    , menu_name
    , menu_price
FROM   
    tbl_menu
WHERE
    menu_price < (/*전체메뉴들의평균가격*/
                   SELECT AVG(menu_price)
                     FROM tbl_menu); -- 10704원

-- 가격이 제일 비싼 메뉴 조회
SELECT
    menu_code
    , menu_name
    , menu_price
FROM
    tbl_menu
WHERE
    menu_price = (SELECT MAX(menu_price)
                    FROM tbl_menu);
    
-- 한우딸기국밥보다 비싼 메뉴 조회
SELECT
    menu_name
    , menu_code
    , menu_price
FROM
    tbl_menu
WHERE
    menu_price > (SELECT menu_price
                    FROM tbl_menu
                    WHERE menu_name = '한우딸기국밥');

SELECT * FROM tbl_menu;

-- 생갈치쉐이크와 같은 가격이고 같은 카테고리인 메뉴 조회 (메뉴코드, 메뉴명, 가격, 카테고리번호)
SELECT
    menu_code
    , menu_name
    , menu_price
    , category_code
FROM
    tbl_menu
WHERE
    menu_price = (SELECT menu_price
                    FROM tbl_menu
                    WHERE menu_name = '생갈치쉐이크')
AND category_code = (SELECT category_code
                        FROM tbl_menu
                        WHERE menu_name = '생갈치쉐이크');


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

-- ---------------------------------------------------------------------
-- 다중행 서브쿼리

-- 열무김치라떼 또는 우럭스무디와 같은 카테고리의 메뉴 조회
SELECT
    menu_name
    , category_code
FROM
    tbl_menu
WHERE
    category_code IN (/*열무김치라떼또는우럭스무디카테고리*/
                        SELECT category_code
                        FROM tbl_menu
                        WHERE menu_name IN('열무김치라떼', '우럭스무디'));

-- 가장 싼메뉴 조회 (메뉴의 가격이 모든 메뉴들의 가격보다 작거나 같은 메뉴)
SELECT
    menu_name
    , menu_price
FROM
    tbl_menu
WHERE
    menu_price <= ALL (SELECT menu_price
                        FROM tbl_menu);

-- 한식메뉴(4번카테고리)들보다 비싼 메뉴 조회
SELECT
    *
FROM
    tbl_menu
WHERE
    menu_price > ALL ( SELECT menu_price
                        FROM tbl_menu m
                             JOIN tbl_category c ON c.category_code = m.category_code
                        WHERE category_name = '한식');

-- ----------------------------------------------
use empdb;
-- 영업부에 해당하는 사원들의 사번, 사원명, 부서명, 급여 조회
SELECT * FROM employee;
SELECT
    emp_id 사번
    , emp_name 사원명
    , dept_title 부서명
    , FORMAT(salary, 0) 급여
FROM
    employee
    JOIN department ON dept_id = dept_code
WHERE
    dept_code IN (SELECT dept_id
                    FROM department
                    WHERE dept_title LIKE '%영업%');

-- ==========================================================
use menudb;
-- 상관 서브쿼리
-- 카테고리별로 가격이 가장 비싼 메뉴 조회
SELECT
    menu_code
    , menu_name
    , menu_price
    , category_code
FROM
    tbl_menu m
WHERE
    menu_price = (/*해당메뉴 카테고리의 최대가격*/
                    SELECT MAX(menu_price)
                    FROM tbl_menu
                    WHERE category_code = m.category_code);

-- 카테고리별 평균가격보다 높은 가격의 메뉴 조회
SELECT * FROM tbl_menu ORDER BY category_code;
SELECT
    menu_code
    , menu_name
    , menu_price
    , category_code
FROM
    tbl_menu m
WHERE
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
        WHERE category_code = m.category_code)
        AS category_name
FROM
    tbl_menu m;

-- 전체 메뉴 조회시 각메뉴별로 몇건 주문되었는지
SELECT
    m.menu_code
    , m.menu_name
    /*해당 메뉴의 주문 건수*/
    , (SELECT COUNT(*)
        FROM tbl_order_menu
        WHERE menu_code = m.menu_code) 주문건수
FROM
    tbl_menu m;

-- -------------------------------------------
use empdb;
-- 전 사원의 사번, 사원명, 사수명 조회
SELECT * FROM employee;
SELECT
    emp_id
    , emp_name
    , IFNULL((SELECT emp_name
        FROM employee
        WHERE emp_id = e.manager_id), '없음') 사수명
FROM
    employee e;
    
    
-- 전 사원의 사번, 사원명, 급여, 본인부서의 부서원수, 본인부서의 평균급여 조회
SELECT
    emp_id
    , emp_name
    , FORMAT(salary, 0)
    , (SELECT COUNT(*)
        FROM employee
        WHERE dept_code = e.dept_code) 부서원수
    , IFNULL((SELECT FORMAT(AVG(salary), 0)
        FROM employee
        WHERE dept_code = e.dept_code), '부서없음'/*FORMAT(e.salary, 0)*/) 평균급여
FROM
    employee e;

-- ------------------------------------------------------------
use menudb;
-- 인라인뷰
-- 카테고리별 메뉴개수가 가장 많은거 조회
SELECT
    MAX(메뉴개수)
FROM
    (SELECT
        category_code 카테고리
        , COUNT(*) 메뉴개수
        FROM
            tbl_menu
        GROUP BY
            category_code) menu_count;


WITH menu_count AS (
        SELECT
        category_code 카테고리
        , COUNT(*) 메뉴개수
        FROM
            tbl_menu
        GROUP BY
            category_code
)
SELECT
    MIN(메뉴개수)
FROM
    menu_count;









