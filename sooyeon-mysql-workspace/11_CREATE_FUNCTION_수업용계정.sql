/*
    ## FUNCTION
    1. 데이터베이스에 저장된 서브 프로그램으로 단일 값을 반환하도록 설계되어있음
    2. 일반적으로 공통적인 수식이나비지니스 규칙을 정의해두고 sql문 또는 다른 저장 프로그램에서 재사용 가능
    
    CREATE FUNCTION 함수명(매개변수)
    RETURNS 반환타입
    BEGIN
        함수본문
        [DECLARE 변수선언]
        [SET 변수에 값 대입]
        [조건문]
        RETURN 반환값;
    END;
*/

-- DELIMITER $$ ~ $$DELIMITER : 함수 내의 구분들중 ; 을FUNCTION 생성문의 끝으로 해결되지않도록 묶어주는구문
DELIMITER $$
CREATE FUNCTION MYFUNC(param_menu VARCHAR(50))
RETURNS VARCHAR(100)
BEGIN
    DECLARE result VARCHAR(100); # 결과를 담을 변수 선언
    SET result = CONCAT('*',param_menu,'☜');
    RETURN result;
END$$ 
DELIMITER ;


SELECT MYFUNC('미나리밥');
SELECT MYFUNC(menu_name) FROM tbl_menu;


SHOW FUNCTION STATUS;





/*
    ## 조건문 - if
    IF condition THEN statement_list
        [ ELSEIF condition THEN statument_list ]
        ...
        [ ELSE statement_list ]
    END IF;
    
    
    
    
    ## 조건문 - CASE
    CASE
        WHEN condition THEN statement_list
        [ WHEN condition THEN statement_list ]
        ...
        [ ELSE statement_list ]
    END CASE;
    
    
    CASE case_value
        WHEN condition THEN statement_list
        [ WHEN condition THEN statement_list ]
        ...
        [ ELSE statement_list ]
    END CASE;
    
*/
DELIMITER $$
CREATE FUNCTION MYFUNC2(
    para_menu VARCHAR(50),
    para_category_code INT
)
RETURNS VARCHAR(100)
BEGIN
    DECLARE result VARCHAR(100);
    DECLARE EMOJI CHAR(1);
    CASE param_category_code
        WHEN 4 THEN SET emoji = '🥗🥗🥗🥗';
        WHEN 5 THEN SET emoji = '🍜🍜🍜';
        WHEN 6 THEN SET emoji = '🍣🍣🍣🍣';
        ELSE SET emoji = '😁😁😁😁😁😁😁😁😁😁';
    END CASE;
    RETURN CONCAT(emoji,para_menu,emoji);
END$$
DELIMITER ;


SELECT MYFUNC2(menu_name,category_code)
FROM tbl_menu;

