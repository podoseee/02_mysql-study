-- PROCEDURE
CREATE TABLE tbl_member(
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_name VARCHAR(50) NOT NULL,
    password VARCHAR(16) NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO tbl_memeber(user_name, password)
VALUES ()

-- 회원추가시 테이블에 INSERT하고 발생된 회원번호를 돌려주는 프로시저 생성
DELIMITER $$
CREATE PROCEDURE create_user(
    /*IN*/ user_name VARCHAR(50), 
    /*IN*/ password VARCHAR(16),
    OUT mem_id INT
)
BEGIN
    INSERT INTO tbl_member(user_name, password)
    VALUES (user_name, password);
    SET mem_id = LAST_INSERT_ID();
END$$
DELIMITER ;


CALL create_user('gildong', '1234', @mem_id);
SELECT @mem_id;
SELECT * FROM tbl_member WHERE id = @mem_id;

CALL create_user('mallang', '2345', @mem_id);
SELECT @mem_id;

-- 반복문

-- 1부터 N까지의 합을 계산하는 프로시저
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
        SET i = i+1;
    END WHILE;
END$$
DELIMITER ;

CALL proc_while_loop(10, @sum_even);
SELECT @sum_even;

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

CALL proc_repeat_until(@sqrt_num);
SELECT @sqrt_num;



