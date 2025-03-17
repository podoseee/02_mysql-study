CREATE VIEW vw_menu_kr
AS
SELECT
    menu_code
  , menu_name
  , menu_price
  , orderable_status
FROM
    tbl_menu
WHERE
    category_code = 4;

EXPLAIN SELECT * FROM vw_menu_kr;

EXPLAIN SELECT * FROM tbl_menu WHERE menu_name = '열무김치라떼';
SHOW INDEX FROM tbl_menu; -- ALL ( full scan )
EXPLAIN SELECT * FROM tbl_menu WHERE menu_code = 1; -- const ( primary key column -> equal condition )
EXPLAIN SELECT * FROM tbl_menu WHERE category_code = 4; -- ref ( index fk column -> equal condition )

CREATE TABLE phone(
    phone_code INT PRIMARY KEY
  , phone_name VARCHAR(100)
  , phone_price DECIMAL(10, 2)
);

INSERT INTO phone(phone_code, phone_name, phone_price)
VALUES (1, 'galaxys24', 1800000)
      ,(2, 'iphone24', 1780000)
      ,(3, 'galaxyZ4', 1720000);
      
SHOW INDEX FROM phone;

EXPLAIN
SELECT *
FROM phone
-- WHERE phone_name = 'iphone16pro';
WHERE phone_price = 3000000;
-- WHERE phone_code = 1;

CREATE INDEX idx_phone_price
ON phone(phone_price);

DROP INDEX idx_phone_price ON phone;

CREATE INDEX idx_phone_name
ON phone(phone_name);

EXPLAIN
SELECT *
FROM phone
WHERE
--    phone_name = 'iphone16pro'; -- o, ref
--   phone_name !=  'iphone16pro'; -- o, range
--   phone_name LIKE 'iphone%'; -- o, range
--   phone_name LIKE '%iphone%'; -- x, ALL
--    LEFT(phone_name, 1) = 'i'; -- x, ALL 인덱스 컬럼 변형(산술 연산 혹은 함수 적용)시 ALL
--    phone_name IS NULL; -- o, ref
--    phone_name IS NOT NULL; -- o, range
--    phone_name = 16; -- x, ALL(인덱스 컬럼의 타입과 비교 데이터간 타입 불일치 시)
    