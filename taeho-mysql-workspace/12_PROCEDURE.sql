CREATE TABLE tbl_member(
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL,
    password VARCHAR(16) NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- 회원 추가시 테이블에 INSERT 하고 발생된 회원번호를 돌려주는 프로시저 생성
DELIMITER $$
CREATE PROCEDURE create_user(
    IN username VARCHAR(255), -- IN 모드 변수
    IN password VARCHAR(16), -- IN 모드 변수
    OUT mem_id INT -- OUT 모드 변수
)
BEGIN
    INSERT INTO
        tbl_member(username, password)
    VALUES
        (username, password);
    SET mem_id = LAST_INSERT_ID();
END$$
DELIMITER ;


CALL create_user('ino', '1234', @param);
SELECT @param;
SELECT * FROM tbl_member WHERE id = @param;

DELIMITER $$
CREATE PROCEDURE proc_loop(n INT,OUT result INT)
BEGIN  
    DECLARE i INT DEFAULT 1; -- 증감변수
    SET result = 0;
    sum_label: LOOP
        SET result = result + i;
        SET i = i + 1;
        IF i > n THEN LEAVE sum_label;
        END IF;
    END LOOP;
END$$
DELIMITER ;

CALL proc_loop(6, @answer);
SELECT @answer;

DELIMITER $$
CREATE PROCEDURE proc_while(n INT,OUT result INT)
BEGIN
    DECLARE i INT DEFAULT 1;
    SET result = 0;
    WHILE i <= n DO
        IF i % 2 = 0 
            THEN SET result = result + i;
        END IF;
        SET i = i + 1;
    END WHILE;
END$$
DELIMITER ;

CALL proc_while(10, @p1);

SELECT @p1;

DELIMITER $$
CREATE PROCEDURE proc_repeat(OUT result INT)
BEGIN
    DECLARE i INT DEFAULT 0;
    SET result = 1;
    REPEAT
        SET i = i + 1;
        SET result = i;
    UNTIL i * i > 1000 END REPEAT;
    SET result = POW(result -1,2);
END$$
DELIMITER ;

DROP PROCEDURE proc_repeat;
CALL proc_repeat(@repeat);

SELECT @repeat;