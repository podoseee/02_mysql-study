-- FUNCTION

DELIMITER $$
CREATE FUNCTION MYFUNC(menu VARCHAR(50))
RETURNS VARCHAR(100)
BEGIN
    DECLARE result VARCHAR(100); -- 결과를 담을 변수 선언
    SET result = CONCAT('**', menu, '**');
    RETURN result;
END$$ 
DELIMITER ;

SELECT MYFUNC('미나리밥');

SHOW FUNCTION STATUS;

SELECT MYFUNC(menu_name)
FROM tbl_menu;

-- 조건문
-- IF , CASE
DELIMITER $$
CREATE FUNCTION MYFUNC2(
    menu VARCHAR(50),
    category_code INT
)
RETURNS VARCHAR(100)
BEGIN
    -- DECLARE result VARCHAR(100);
    DECLARE emoji CHAR(1);
    CASE category_code
        WHEN 4 THEN SET emoji = '🟦';
        WHEN 5 THEN SET emoji = '🈲';
        WHEN 6 THEN SET emoji = '🈂';
        ELSE SET emoji = '❌';
    END CASE;
    RETURN CONCAT(emoji, menu, emoji);
END$$
DELIMITER ;

SELECT MYFUNC2(menu_name, category_code)
FROM tbl_menu;



