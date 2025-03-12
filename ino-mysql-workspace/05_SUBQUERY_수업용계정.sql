use menudb;

SELECT
    category_name
FROM
    tbl_category
WHERE
    category_code = (SELECT category_code
                       FROM tbl_menu
                       WHERE menu_name = '열무김치라떼');
                       
SELECT category_code, menu_code, menu_name, menu_price, orderable_status FROM tbl_menu WHERE category_code = 4;


SELECT 
    menu_code
  , menu_name
  , menu_price
  , orderable_status 
FROM 
    tbl_menu 
WHERE 
    category_code = (SELECT category_code
                     FROM tbl_menu
                    WHERE menu_name = '민트미역국');

SELECT
    menu_code
  , menu_price
  , menu_name
FROM
    tbl_menu
WHERE
    menu_price < (SELECT AVG(menu_price) FROM tbl_menu);
    
SELECT
    menu_code
  , menu_price
  , menu_name
FROM
    tbl_menu
WHERE
    menu_price = (SELECT MAX(menu_price) 
                    FROM tbl_menu);
    
SELECT
    menu_code
  , menu_price
  , menu_name
  , category_name
FROM
    tbl_menu
        JOIN tbl_category USING(category_code)
WHERE
    menu_price > (SELECT menu_price 
                    FROM tbl_menu 
                    WHERE menu_name = '한우딸기국밥');
                    
SELECT
    menu_code
  , menu_name
  , menu_price
  , category_code
FROM    
    tbl_menu
WHERE
    (menu_price, category_code) = (SELECT menu_price
                       , category_code
                    FROM tbl_menu
                    WHERE menu_name = '생갈치쉐이크');
SELECT
    menu_name
  , menu_price
  , category_code
FROM
    tbl_menu
WHERE
    category_code IN ( SELECT category_code
                        FROM tbl_menu
                        WHERE menu_name IN ('열무김치라떼','우럭스무디'));

SELECT
    menu_code
  , menu_name
  , menu_price
FROM
    tbl_menu
WHERE
    menu_price <= ALL (SELECT menu_price
                        FROM tbl_menu);
                        
SELECT
    menu_code
  , menu_name
  , menu_price
  , category_code
FROM
    tbl_menu
WHERE
    menu_price > ALL (SELECT menu_price
                        FROM tbl_menu
                        WHERE category_code = 4);

SELECT menu_price, menu_name, category_code
                        FROM tbl_menu
                        WHERE category_code = 4;

use empdb;

SELECT * FROM department;
SELECT * FROM employee;

SELECT
    EMP_ID
  , EMP_NAME
  , SALARY
FROM
    employee
WHERE
    DEPT_CODE IN (SELECT DEPT_ID
                    FROM department
                    WHERE DEPT_TITLE LIKE '%영업%');
             
use menudb;
SELECT
    menu_name
  , menu_price
  , m.category_code
FROM
    tbl_menu m
WHERE
    menu_price = (SELECT MAX(menu_price)
                    FROM tbl_menu
                    WHERE category_code = m.category_code);
SELECT
    MAX(menu_price)
  , category_code
FROM
    tbl_menu
GROUP BY
    category_code;


SELECT
    m.menu_code
  , m.menu_name
  , (SELECT COUNT(*)
        FROM tbl_order_menu
        WHERE menu_code = m.menu_code)
FROM
    tbl_menu m;
    
use empdb;

SELECT * FROM employee;
SELECT
    EMP_ID
  , EMP_NAME
  , IFNULL(MANAGER_ID, '없음')
FROM
    employee;
    
SELECT
    e.emp_id
  , e.emp_name
  , e2.emp_name
FROM
    employee e
    JOIN employee e2 ON e2.emp_id = e.manager_id;
SELECT
    EMP_ID
  , EMP_NAME
  , SALARY
  , (SELECT COUNT(*)
       FROM employee e2
       WHERE e1.dept_code = e2.dept_code) AS 부서원수
  , (SELECT ROUND(AVG(SALARY))
       FROM employee e2
       WHERE e1.dept_code = e2.dept_code) AS 평균급여
FROM
    employee e1;
    
use menudb;
SELECT
    MAX(메뉴개수)
FROM (SELECT
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
    MAX(메뉴개수)
  , MIN(메뉴개수)
FROM
    menu_count;