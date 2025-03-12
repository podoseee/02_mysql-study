SHOW TABLES;

DESC TBL_MENU;

SELECT * FROM tbl_category;

SELECT menu_name FROM tbl_menu;

SELECT
    menu_code
  , menu_name
  , menu_price
FROM
    tbl_menu;
    
SELECT
    menu_code
  , menu_name
  , menu_price
  , category_code
  , orderable_status
  FROM
    tbl_menu;
    
SELECT
    menu_name
  , menu_price
  , orderable_status
FROM
    tbl_menu
WHERE
    menu_price >= 13000
;

SELECT
    NULL && 0;
    
SELECT
    category_code
  , category_name
  , ref_category_code
FROM
    tbl_category
ORDER BY
    ref_category_code IS NULL DESC, ref_category_code DESC
LIMIT 3
;


SELECT
    menu_code
  , menu_name
  , menu_price
FROM 
    tbl_menu
ORDER BY
    menu_price DESC
  , menu_name
LIMIT
    5
;