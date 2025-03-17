-- FUNCTION

DELIMITER $$
CREATE FUNCTION func_get_menu_with_str(param_menu VARCHAR(50))
RETURNS VARCHAR(100)
BEGIN
    DECLARE result VARCHAR(100);
    SET result = CONCAT('*', param_menu, 'helloWorld');
    RETURN result;
END$$ DELIMITER ; -- 바이너리 로깅으로 인한 에러 발생
-- result 뒤의 세미콜론을 함수 본문의 마지막으로 인식하지 하게 않기 위해
-- DELIMITER $$ ~ DELIMITER

SELECT func_get_menu_with_str(menu_name) FROM tbl_menu;


DELIMITER $$
CREATE FUNCTION MYFUNC2(
    param_menu VARCHAR(50),
    param_category_code INT
)
RETURNS VARCHAR(100)
BEGIN
    DECLARE emoji CHAR(1);
    CASE param_category_code
        WHEN 4 THEN SET emoji = '🍕';
        WHEN 5 THEN SET emoji = '🍔';
        WHEN 6 THEN SET emoji = '🍟';
        ELSE SET emoji = '🌭';
    END CASE;
    RETURN CONCAT(emoji, param_menu, emoji);
END$$ 
DELIMITER ;

DROP FUNCTION MYFUNC2;
SELECT MYFUNC2(menu_name, category_code) FROM tbl_menu;