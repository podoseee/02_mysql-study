SELECT ASCII ('A'), CHAR(65);

SELECT LENGTH("사과"), BIT_LENGTH("APPLE"), CHAR_LENGTH("APPLE");

SELECT CONCAT("Hello","WORLD"), CONCAT_WS(",","Hello","WORLD");

SELECT 
    ELT(3, "Hello","WORLD")
  , FIELD("Hello", "Hello","WORLD")
  , FIND_IN_SET("Hello", "WORLD,Hello,WORLD")
;

SELECT
    *
FROM
    tbl_menu
ORDER BY
    FIND_IN_SET(menu_code, '15,12') DESC
;

SELECT
    INSTR('사과딸기바나나','딸기')
  , LOCATE('딸기', '사과딸기바나나');

SELECT
    FORMAT(1221412412412.214124, 4);

SELECT
    INSERT("my name is ino", 12, 3, menu_name)
FROM
    tbl_menu
;

SELECT
    menu_name
  , INSERT(menu_name, INSTR(menu_name, '쥬스'), 2, 'JUICE')
FROM tbl_menu
WHERE  
    menu_name LIKE '%쥬스%'
; 


SELECT 
    menu_name, REPLACE(menu_name, '쥬스', 'JUICE')
FROM tbl_menu    
    ;

SELECT
    SUBSTRING_INDEX('@@@@@@@@@@@', '@', 1);

SELECT
    TRUNCATE(123.1234, 2)
  , CEILING(123.1234)
  , FLOOR(123.1234)
  , ROUND(123.1234, 2)
  , TRUNCATE(123.1234, -1)
;

SELECT
    TRUNCATE(RAND() * 100 + 1, 0) AS RANDNUM;

SELECT
    DATE_FORMAT(NOW(), '%y-%m-%d')
  , DATE_FORMAT(NOW(), '%H-%i-%s');

SELECT
    AVG(menu_price)
  , CAST( AVG(menu_price) AS SIGNED INTEGER)
  , CONVERT( AVG(menu_price), SIGNED INTEGER)
FROM
    tbl_menu;

SELECT
    CAST( '2024-5-30' AS DATE);