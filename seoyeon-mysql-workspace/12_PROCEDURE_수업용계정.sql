/*
    ## PROCEDURE ##
    1. 데이터베이스에 저장된 서브프로그램으로
    2. 주로 데이터베이스 작업을 자동화하거나 복잡한 비즈니스 규칙을 구현할 때 사용함
    3. 저장된 프로시저는 CALL 키워드를 통해서 호출가능. SQL문에서 호출 불가
    
    CREATE PROCEDURE 프로시저명(parameter_list) -- IN(기본값)/OUT/INOUT
    BEGIN
        프로시저 본문
    END;
    
    CALL 프로시저명();    
*/

CREATE TABLE tbl_member(
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL,
    password VARCHAR(16) NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- 회원추가시 테이블에 INSERT하고 발생된 회원번호를 돌려주는 프로시저 생성
DELIMITER $$
CREATE PROCEDURE create_user(
    username VARCHAR(50), -- IN 모드 변수
    password VARCHAR(16), -- IN 모드 변수
    OUT mem_id INT        -- OUT 모드 변수
)
BEGIN
    INSERT INTO
        tbl_member(username, password)
    VALUES
        (username, password);
    
    SET mem_id = LAST_INSERT_ID();
END $$
DELIMITER ;

CALL create_user('lee-seoyeon', '486', @mem_id);
SELECT @mem_id;
SELECT * FROM tbl_member WHERE id = @mem_id;

CALL create_user('lee-taeyong', '701', @mem_id);
SELECT @mem_id;

/*
    ## 반복문 - LOOP ##
    LOOP
        반복문본문
    END LOOP;
    
    ## 반복문 = WHILE LOOP ##
    WHILE loop-condition DO
        반복문본문
    END WHILE;
    
    ## 반복문 - REPEAT ##
    REPEAT
        반복문본문
    UNTIL condition END REPEAT;
*/

-- 1부터 N까지의 합을 계산하는 프로시져
DELIMITER $$
CREATE PROCEDURE proc_loop(IN n INT, OUT sum INT)
BEGIN
    DECLARE i INT DEFAULT 1; -- 증감변수
    SET sum = 0;
    sum_label: LOOP
        SET sum = sum + i;
        SET i = i + 1;
        IF i > n THEN LEAVE sum_label;
        END IF;
    END LOOP;
END$$
DELIMITER ;

CALL proc_loop(10, @sum_result);
SELECT @sum_result;

-- 1부터 n까지 짝수의 합
DELIMITER $$
CREATE PROCEDURE proc_while_loop(IN n INT, OUT sum INT)
BEGIN
    DECLARE i INT DEFAULT 1;
    SET sum = 0;
    WHILE i <= n DO
        
        IF i % 2 = 0
            THEN SET sum = sum + i;
        END IF;
        SET i = i + 1;
    END WHILE;    
END$$
DELIMITER ;

CALL proc_while_loop(10, @sum);
SELECT @sum;

-- 제곱수가 1000을 넘지 않는 최대 정수 구하기

DELIMITER $$
DROP PROCEDURE proc_repeat_until;
CREATE PROCEDURE proc_repeat_until(OUT result INT)
BEGIN
    DECLARE i INT DEFAULT 0;
    REPEAT
        SET i = i + 1;
        SET result = i;
    UNTIL i * i > 1000 END REPEAT;
    SET result = result - 1;
END$$
DELIMITER ;

CALL proc_repeat_until(@result);
SELECT @result;
