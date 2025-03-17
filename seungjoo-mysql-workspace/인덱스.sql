use menudb;
EXPLAIN SELECT * FROM tbl_menu; -- ALL 풀스캔임
EXPLAIN SELECT * FROM tbl_menu WHERE menu_name = '열무김치라떼'; -- 풀 스캔
EXPLAIN SELECT * FROM tbl_menu WHERE menu_code = 1; -- pk는 인덱스로 등록되어있음 -> const임 성능 굉장히 좋음!!!
EXPLAIN SELECT * FROM tbl_menu WHERE category_code = 4; -- ref(인덱스로 등록되어있는 fk컬럼으로 equal조건)

CREATE TABLE phone(
    phone_code INT PRIMARY KEY,
    phone_name VARCHAR(100),
    phone_price DECIMAL(10,2)
    );
INSERT INTO phone(phone_code, phone_name, phone_price)
VALUES(1, 'galaxyS24', 180000), 
        (2, 'IPHONE16PRO', 1900000),
        (3, 'galaxyZfold3', 1720000);

select * from phone;

show index from phone;

EXPLAIN
SELECT * FROM phone
-- WHERE phone_name = 'IPHONE16PRO';-- ALL타입, 풀스캔임, 모든 행들을 비교하면서 조건 검사하고 있다는 소리임
-- WHERE phone_price = 3000000;  ALL임
WHERE phone_code = 1; -- contst

-- 인덱스 생성, 인덱스라는 객체이므로 생성하면 됨
CREATE INDEX idx_phone_price
ON phone(phone_price);

show INDEX FROM phone;

EXPLAIN SELECT * FROM phone WHERE phone_price = 180000; -- ref로 조회가 됨

dROP INDEX idx_phone_price on phone; -- 인덱스 삭제

CREATE INDEX idx_phone_name
ON phone(phone_name);

EXPLAIN
SELECT *
FROM phone
where 
   --  phone_name = 'IPHONE16PRO'; -- ref
  -- phone_name != 'iphone16pro'l -- range 범위로 검색)
  -- phone_name LIKE 'IPHONE%'L -- range
  -- phone_name LIKE '%IPHONE%' --x, ALL(앞에 %가 있으면 ALL이 됨)
    -- LEFT(phone_name, 1) = 'i'; -- x ALL(인덱스 컬럼에 변형(산술 연산식, 함수식)이 가해질 경우 ALL이 됨)
 -- phone_name IS NULL; -- o, ref 
 -- phone_name IS NOT NULL; -- o, range
    phone_name = 16; -- x, ALL(인덱스 컬럼의 타입과 비교데이터의 타입이 다른경우)
    
