/*
    *트랜잭션
    1) 데이터베이스의 논리적인 연산단위 (업무단위)
       즉, 한번에 수행되어야 할 최소의 작업 단위
    2) 트랜잭션 ACID 원칙
       1) Atomicity (원자성)
            : 트랜잭션과 관련된 일은 모두 실행하거나 모두 실행되지 않도록 하는 특성
       2) Consistency (일관성)
            : 트랜잭션이 성공했다면 데이터베이스는 그 일관성을 유지해야됨
       3) Isolation (독립성)
            : 트랜잭션을 수행하는 도중에 다른 연산작업이 끼어들면 안됨
       4) Durability (지속성)
            : 트랜잭션이 성공적으로 수행되었을 경우 그 결과가 완전하게 db에 반영이 되어야함
            
    ex) 계좌이체(본인--송금-->상대방) 업무단위
    >> 트랜잭션 시작
    1) 내 계좌에서 송금한 금액만큼 차감
    2) 상대방 계좌에서는 내가 송금한 금액만큼 증가
    >> 트랜잭션 완료
    
    2번 과정까지 성공적으로 됐다면    => 트랜잭션 전체 적용(COMMIT)
    2번 과정중에 문제가 발생했을 경우 => 트랜잭션 전체 취소(ROLLBACK)
   
   ## TCL ##
   1. Transaction Control Language
   2. 트랜잭션 제어어
   3. 트랜잭션 대상 구문 : DML(INSERT, UPDATE, DELETE)
   4. 종류
      1) COMMIT   : 트랜잭션에 포함되어있는 변경사항들을 영구적으로 저장 (실제 DB에 반영) 
      2) ROLLBACK : 트랜잭션에 포함되어있는 변경사항들을 일괄 취소시킨 후 마지막 COMMIT 시점으로 돌아감
      3) SAVEPOINT <savepoint명> : 임시저장점 설정
         ROLLBACK to <savepoint명>
*/
SHOW VARIABLES LIKE 'autocommit';
SET autocommit = 0; -- 비활성화

-- 계좌 테이블(ssg_back) 생성
-- id, INT, PK
-- name, VARCHAR(100), 필수
-- balance, BIGINT, 양수만 허용, 필수
CREATE TABLE ssg_bank(
    id INT PRIMARY KEY,
    name VARCHAR(100) NOT null,
    balance BIGINT NOT NULL CHECK (balance >= 0)
);

INSERT INFO
    ssg_bank
VALUES
    (1231, '홍길동', 1000000),
    (456, '김말순', 1000000;
COMMIT;

SELECT * FROM ssg_bank;

-- 작업1. 홍길동이 김말순에게 10만원 이체
UPDATE ssg_bank SET balance = balance - 100000 WHERE id = 1231; -- 홍길동 돈 차감
UPDATE ssg_bank SET balance = balance + 100000 WHERE id = 461; -- 김말순 돈 증가
-- 정상처리
COMMIT;

-- 작업2. 김말순이 홍길동에게 50만원 이체
UPDATE ssg_bank SET balance = balance - 500000 WHERE id = 456; -- 김말순 돈 차감
UPDATE ssg_bank SET balance = balance + 5000 WHERE id = 1231; -- 홍길동 돈 증가
-- 문제발생
ROLLBACK;

-- ==================================

use menudb;

DESC tbl_order;         -- 주문 테이블       1 (부모)
DESC tbl_order_menu;    -- 주문 메뉴 테이블  N (자식)

-- 작업1. 1번메뉴 2개, 2번메뉴 1개 주문완료 (총주문가격 14000)
INSERT INTO tbl_order 
VALUES(1234, DATE_FORMAT(CURDATE(), '%y/%m/%d'), DATE_FORMAT(CURTIME(), '%H:%i:%s'), 14000);
INSERT INTO tbl_order_menu
VALUES(1234, 1, 2);
INSERT INTO tbl_order_menu
VALUES(1234, 2, 1);
-- 정상처리
COMMIT;

SELECT * FROM tbl_order;
SELECT * FROM tbl_order_menu;

-- 작업2. 5번메뉴 1개, 6번메뉴 1개 주문완료 (총 가격 25000)
INSERT INTO tbl_order 
VALUES(4567, DATE_FORMAT(CURDATE(), '%y/%m/%d'), DATE_FORMAT(CURTIME(), '%H:%i:%s'), 25000);
INSERT INTO tbl_order_menu
VALUES(4567, 15, 1);
-- 문제 발생
ROLLBACK;

-- 작업3. 3번메뉴1개 4번메뉴1개 주문완료 (총가격 13000)
INSERT INTO tbl_order
VALUES(3333,DATE_FORMAT(CURDATE(), '%y/%m/%d'), DATE_FORMAT(CURTIME(), '%H:%i:%s'), 13000);
SAVEPOINT finish_insert_order;
INSERT INTO tbl_order_menu
VALUES(3333, 3, 1);
INSERT INTO tbl_order_menu
VALUES(3333, 4, 10);
-- 문제 발생
ROLLBACK TO finish_insert_order;

ROLLBACK;

SELECT * FROM tbl_order;
SELECT * FROM tbl_order_menu;
