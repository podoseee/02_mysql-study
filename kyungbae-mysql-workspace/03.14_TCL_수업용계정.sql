-- TCL
-- TRANSACTION
SHOW VARIABLES LIKE 'autocommit';
SET AUTOCOMMIT = 'off';

-- 계좌 테이블(ssg_bank) 생성
CREATE TABLE ssg_bank(
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    balance BIGINT DEFAULT 0 NOT NULL,
    CHECK (balance >= 0 )
);
DROP TABLE IF EXISTS ssg_bank;
DESC ssg_bank;

INSERT INTO ssg_bank
VALUES  (1231, '홍길동', 1000000),
        (456, '김심심', 1000000);
COMMIT;

SELECT * FROM ssg_bank;

-- 작업1. 홍길동이 김심심에게 10만원 이체
UPDATE ssg_bank SET balance = balance - 100000 WHERE id = 1231; -- 홍길동 돈 차감
UPDATE ssg_bank SET balance = balance + 100000 WHERE id = 456;  -- 김심심 돈 증가
-- 정상 처리 완료
COMMIT; -- DB 반영 완료

-- 작업2. 김말순이 홍길동에게 50만원 이체
UPDATE ssg_bank SET balance = balance - 500000 WHERE id = 456; -- 김심심 돈 차감
UPDATE ssg_bank SET balance = balance + 5000 WHERE id = 1231;  -- 홍길동 돈 증가
SELECT * FROM ssg_bank;
-- 이체 실패 : 일관성 문제
ROLLBACK; -- 전체 진행 취소

-- ======================================================================
USE menudb;

DESC tbl_order;         -- 주문 테이블       1 (부모)
DESC tbl_order_menu;    -- 주문 메뉴 테이블  n (자식)

-- 작업1. 1번메뉴 2개, 2번메뉴 1개 주문완료 (총주문가격 14000)
INSERT INTO tbl_order 
VALUES (1234, 
        DATE_FORMAT(CURDATE(), '%y/%m/%d'), 
        DATE_FORMAT(CURTIME(), '%H:%i:%s'),
        14000
        );
INSERT INTO tbl_order_menu
VALUES (1234,1, 2);
INSERT INTO tbl_order_menu
VALUES (1234,2, 1);
-- 정상 처리
COMMIT;

SELECT * FROM tbl_order;
SELECT * FROM tbl_order_menu;

-- 작업2. 5번메뉴 1개, 6번메뉴 1개 주문완료 (총 가격 25000)
INSERT INTO tbl_order 
VALUES (4567, 
        DATE_FORMAT(CURDATE(), '%y/%m/%d'), 
        DATE_FORMAT(CURTIME(), '%H:%i:%s'),
        25000
        );
INSERT INTO tbl_order_menu
VALUES(4567, 15, 1);
-- 문제 발생
ROLLBACK;

-- 작업3. 3번메뉴1개, 4번메뉴1개 주문완료 (총가격 13000)
INSERT INTO tbl_order 
VALUES (3333,
        DATE_FORMAT(CURDATE(), '%y/%m/%d'), 
        DATE_FORMAT(CURTIME(), '%H:%i:%s'),
        13000
        );
        
SAVEPOINT order_finished;

INSERT INTO tbl_order_menu
VALUES(3333, 3, 1);
INSERT INTO tbl_order_menu
VALUES(3333, 4, 10);
-- 문제 발생 :
ROLLBACK TO order_finished;

ROLLBACK;

SELECT * FROM tbl_order;
SELECT * FROM tbl_order_menu;




