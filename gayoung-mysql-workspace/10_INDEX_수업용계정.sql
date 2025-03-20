/*
    ## INDEX 인덱스
    1. 색인객체 
    2.sql 명령문의 처리 속도를 향상시키기 위한 객체로 데이터를 빠르게 조회할 수 있는 포인터를 제공
    3. 주로 WHERE절 조건이나 JOIN 연산에 사용되는 컬럼을 가지고 생성함 
    4. 특징
        - 이진트리구조로 저장됨. 만들어짐 
        - key-value형태로 생성됨
        - key에는 인덱스로 지정된 컬럼값, value로넌 행이 저장된 주소값 저장 
    5. 장점
        - 데이터 검색시 전체 테이블을 검색하는 대신 인덱스를 통해 검색하므로 속도가 향상됨
        - 시스템에 걸리는 부하를 줄여 시스템 전체 성능을 향상시킬 수 있음
    6. 단점
        - 인덱스 생성을 위한 추가 저장공간이 필요함
        - 인덱스 생성시 시간이 걸림
        - 인덱스 지정된 데이터가 번경(insert, update, delete)될 때마라 인덱스도 갱신해야됨
          >> 즉, 변경작업이 빈번한 테이블에 index생성시 오히려 성능저하가 발생될 수 있음 
          
   ## 적용예 ##
   1. 어떤 컬럼에 인덱스를 만드는게 좋은가
      - 중복된 데이터값이 없는 고유한 데이터값을 가지는 칼럼에 만드는게 제일 좋음 
        >> 선택도(seletivity)가 좋은 컬림이라고 함 
        ex ) 아이디/주민번호/이메일 >> good
             성명 : not bad
             성별/여부 : bad
   2. 효율적인 인덱스 사용예
      - WHERE 절에 자주사용되는 컬럼
      - 두개이상의 컬럼이 WHERE이나 JOIN의 조건으로 자주 사용되는 경우
      - 한번 입력된 데이터 의 변경이 자주 일어나지 않는 경우
      - 한 테이블에 저장된 데이터 용량이 클 경우
   3. 비효율적인 인덱스 사용 예
      - 중복값이 많음 컬럼
      - NULL이 많은 경우
      - 무분별하게 인덱스 생성시 오히려 성능 저하 
    
*/

-- 테이블 생성식 fk, pk같은 경우, 해당 컬럼을 가지고 자동으로 인덱스가 생성됨 
SHOW INDEX FROM tbl_menu;

 /*
    ## 실행계획 ##
    테이블 접근 방법, 조인의 순서, 데이터 처리 방식 등등이 표현되어 있음
    
    * TYPE 종류 (성능 우선순위로 나열)
    - system : 0개 또는 하나의 row를 가진 테이블
    - const : primary key나 unique key의 모든 컬럼에 대해 equal 조건으로 검색. 반드시 1건의 레코드만 반환
    - ref : 조인의 순서와 인덱스의 종류와 관계없이 equal 조건으로 검색
    - unique_subquery : IN(서브쿼리) 형태의 조건에서 반환 값에 중복없음
    - index_subquery : unique_subquery와 비슷하지만 반환 값에 중복있음
    - range : 인덱스를 하나의 값이 아니라 범위로 검색
    - index : 인덱스를 처음부터 끝까지 읽는 인덱스 풀 스캔
    - ALL : 풀스캔을 의미하며 성능 가장 안 좋음
*/

EXPLAIN SELECT * FROM tbl_menu; -- 실행계획이 어떻게 되는지 설명 
-- rows : 반환 예상치 
EXPLAIN SELECT * FROM tbl_menu WHERE menu_name = '열무김치라떼'; -- all 풀스캔
EXPLAIN SELECT * FROM tbl_menu WHERE menu_code = 1; -- const (primary key 컬럼으로 equal조건으로 조회)
EXPLAIN SELECT * FROM tbl_menu WHERE category_code = 4; -- ref (index로 등록되어있는 fk 컬럼으로 equal조건으로 조회)

 CREATE TABLE phone(
    phone_code INT PRIMARY KEY,
    phone_name VARCHAR(100),
    phone_price DECIMAL(10,2)
    );

INSERT INTO phone(phone_code, phone_name, phone_price)
VALUES(1, 'galaxyS24', 1800000),
      (2, 'iphone16pro', 19000000),
      (3, 'galaxyZfold3', 1720000);

SELECT * FROM phone;

SHOW INDEX FROM phone;

EXPLAIN
SELECT *
FROM phone 
WHERE phone_name = 'iphone16pro';

CREATE INDEX idx_phone_price
ON phone(phone_price);

EXPLAIN SELECT * FROM phone WHERE phone_price = 1800000; -- ref 인덱스를 사용하면서 조회되고 있음 

-- 따라서 where절에서 자주 사용하는 칼럼은 index로 만들어 사용하자

DROP INDEX idx_phone_price ON phone;
SHOW INDEX FROM phone;

CREATE INDEX idx_phone_name
ON  phone(phone_name);

EXPLAIN
SELECT *
FROM phone
WHERE
--    phone_name = 'iphone16pro'; -- o, ref
--    phone_name != 'iphone16pro'; -- o, range
--    phone_name LIKE 'iphone%'; -- o, range
--    phone_name LIKE '%iphone%'; -- x, ALL  (앞에 %가 있으면 ALL이됨)
--    LEFT(phone_name, 1) = 'i'; -- x, ALL (인덱스 컬럼에 변형(산술연산식, 함수식)이 가해질 경우 ALL이됨)
--    phone_name IS NULL; -- o, ref
--    phone_name IS NOT NULL; -- o, range
    phone_name = 16; -- x, ALL (인덱스컬럼의 타입과 비교데이터의 타입이 다른 경우)

DROP INDEX idx_phone_name_price ON phone;

-- *복합인덱스
-- 두개 이상의 컬럼을 한번에 하나의 인덱스로 설정해서 생성가능

CREATE INDEX idx_phone_name_price 
ON phone(phone_name, phone_price);

SHOW INDEX FROM phone;

EXPLAIN -- 두개 이상의 컬럼으로 조건검사
SELECT *
FROM phone
-- WHERE phone_name = 'iphone16pro' AND phone_price = 1900000; -- o, ref
-- WHERE phone_price = 1900000 AND phone_name = 'iphone16pro'; -- o, ref
-- WHERE phone_name = 'iphone16pro'; -- o, ref
WHERE phone_price = 1900000; -- o, index

    