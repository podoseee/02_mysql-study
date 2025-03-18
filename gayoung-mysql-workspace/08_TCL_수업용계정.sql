/*
    * 트랜잭션
    1) 데이터베이스의 논리적인 연산단위(업무단위)
        즉, 한번에 수행되어야 할 최소의 작업 단위
    2) 트랜잭션 acid 원칙
       - 원자성
       - 일관성
       - 독립성
       - 지속성
    ex) 계좌이체(본인 >> 송금>> 상대방) 업무단위
        1) 내 계좌에서 송금한 금액만큼 차감
        2) 상대방 계좌에서는 내가 송금한 금액만츰 증가 
        
-- ********************************************************
/* 
    ## TCL ##
    COMMIT, ROLLBACK
    SAVEPOINT <savepoint명>  : 임시저장점 설정
    ROLLBACK TO <savepoint>
*/

SHOW VARIABLES LIKE 'autocommit';
SET autocommit = 0; -- 비활성화 

-- 계좌 테이블(ssg_bank) 생성
-- id, INT, PK
-- name, VARCHAR(100), 필수
-- balance, BIGINT, 양수만 허용, 필수

CREATE TABLE ssg_bank(
    id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    balance BIGINT CHECK(Balance>0) NOT NULL
    );
ALTER TABLE ssg_bank
    MODIFY balance BIGINT CHECK(Balance>=0)
    ;
DESC ssg_bank;

INSERT INTO
    ssg_bank
VALUES
    (123, '이가영', 120000),
    (1234, '이가영4', 420000);
COMMIT;

SELECT * FROM ssg_bank;

-- 작업1. 이가영이 이가영4에게 10만원 이체 
UPDATE ssg_bank SET balance = balance -100000 WHERE id = 123;
UPDATE ssg_bank SET balance = balance +100000 WHERE id = 1234;
 
 COMMIT;
 
 
 


    