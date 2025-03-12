SELECT 
    category_code
  , SUM(menu_price) 총합
FROM 
    tbl_menu
GROUP BY
    category_code
ORDER BY
    총합;
    
SELECT
    COUNT(*) 개수
  , AVG(menu_price) 평균가
  , MAX(menu_price) 최고가
  , MIN(menu_price) 최소가
FROM
    tbl_menu
GROUP BY
    category_code;
    
use empdb;
SELECT * FROM employee;

SELECT
    COUNT(*) 부서별사원수
  , SUM(SALARY) 총급여합
  , FLOOR(AVG(SALARY)) 평균급여
FROM
    employee
GROUP BY
    DEPT_CODE;
    
use menudb;

SELECT
    CHAR_LENGTH(menu_name)
  , SUM(menu_price)
  , COUNT(*)
FROM
    tbl_menu
GROUP BY
    CHAR_LENGTH(menu_name);
    
SELECT
    category_code
  , COUNT(*)
FROM
    tbl_menu
GROUP BY
    category_code;
    
SELECT
    category_code
  , SUM(menu_price) 메뉴총합
FROM
    tbl_menu
GROUP BY
    category_code
HAVING
    메뉴총합 >= 25000;
    
    
SELECT * FROM employee;

SELECT 
    DEPT_CODE
  , AVG(SALARY)
FROM 
    employee
GROUP BY
    DEPT_CODE
HAVING
    AVG(SALARY) >= 3000000;
    
SELECT
    DEPT_CODE
  , COUNT(BONUS)
FROM
    employee
GROUP BY
    DEPT_CODE
HAVING
    COUNT(BONUS) = 0;
use menudb;

SELECT
    category_code
  , orderable_status
  , COUNT(*)
FROM
    tbl_menu
GROUP BY
    category_code, orderable_status
WITH ROLLUP
ORDER BY
    category_code IS NULL;
    
SELECT
    *
FROM 
    tbl_menu
WHERE
    category_code = 10

UNION

SELECT
    *
FROM 
    tbl_menuemployee
WHERE
    menu_price < 9000;