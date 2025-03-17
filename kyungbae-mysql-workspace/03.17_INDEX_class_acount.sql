-- INDEX
-- 테이블 생성시 PK, FK 같은 경우 해당 컬럼을 가지고 자동으로 INDEX 생성
SHOW INDEX FROM tbl_menu;

-- 실행계획
EXPLAIN SELECT * FROM tbl_menu; -- ALL
EXPLAIN SELECT * FROM tbl_menu WHERE menu_name = '열무김치라떼'; -- ALL
EXPLAIN SELECT * FROM tbl_menu WHERE menu_code = 1; -- const (pk컬럼 equal조건 조회)
EXPLAIN SELECT * FROM tbl_menu WHERE category_code = 4; -- ref (fk컬럼 equal조건 조회)

CREATE TABLE phone(
    phone_code INT PRIMARY KEY,
    phone_name VARCHAR(100),
    phone_price DECIMAL(10,2)
);

INSERT INTO phone(phone_code, phone_name, phone_price)
VALUES  (1, 'galaxyS24', 1800000),
        (2, 'iphone16pro', 1900000),
        (3, 'galaxyZfold3', 1720000);

SELECT * FROM phone;

-- 인덱스 확인
SHOW INDEX FROM phone;

EXPLAIN
SELECT *
FROM phone
-- WHERE phone_name = 'iphone16pro'; -- ALL
-- WHERE phone_price = 3000000; -- ALL
WHERE phone_code = 1; -- const

-- 인덱스 생성
CREATE INDEX idx_phone_price
ON phone(phone_price);

EXPLAIN SELECT * FROM phone WHERE phone_price = 1800000; -- ref

-- 인덱스 삭제
DROP INDEX idx_phone_price ON phone;

CREATE INDEX idx_phone_name
ON phone(phone_name);

EXPLAIN
SELECT *
FROM phone
WHERE
    -- phone_name = 'iphone16pro'; -- ref
    -- phone_name != 'iphone16pro'; -- range
    -- phone_name LIKE 'iphone%'; -- range
    -- phone_name LIKE '%iphone%'; -- ALL (index 사용 안함)
    -- LEFT(phone_name, 1) = '1'; -- ALL (인덱스 컬럼에 변형이 가해질 경우 ALL)
    -- phone_name IS NULL; -- ref
    -- phone_name IS NOT NULL; -- range
    phone_name = 16; -- ALL (인덱스컬럼의 타입과 비교데이터의 타입이 다른경우
    
-- 복합인덱스
-- 두개 이상의 컬럼을 한번에 하나의 인덱스로 설정해서 생성
CREATE INDEX idx_phone_name_price
ON phone(phone_name, phone_price);

SHOW INDEX FROM phone;

EXPLAIN
SELECT *
FROM phone
-- WHERE phone_name = 'iphone16pro' AND phone_price = 1900000; -- ref
-- WHERE phone_price = 1900000 AND phone_name = 'iphone16pro'; -- ref
-- WHERE phone_name = 'iphone16pro'; -- ref
WHERE phone_price = 1900000; -- index





