/*
    ## INDEX
    1. 색인객체
    2. sql 명령문의 처리 속도를 향상시키기 위한 객체로데이터를 빠르게 조회할 수 있는 포인터 제공
    3. 주로 where절 조건이나 JOIN 연산에 사용되는 컬럼을 가지고 생성함
    
        - 이진트리구조로만들어짐
        - KEY-VALUE형태로 생성됨
            key에는 인덱스로 지정된 컬럼값, value로는 행이 저장된 주소값저장됨
    
    - 장점
        1. 데이터 검색시 전체 테이블을 검색하는 대신 인덱스를 통해 검색하므로 속도가 향상됨
        2. 시스템에 걸리는 부하를 줄여 시스템 전체 성능을 향상시킬 수 있음
    - 단점
        1. 인덱스 생성을 위한 추가 저장공간이 필요함
        2. 인덱스를 생성시 시간이 걸림
        3. 데이터가 변경(INSERT, UPDATE, DELELTE)될 때 마다 인덱스도 갱신해야됨
            => 너무 많이 생성시 성능 저하
            
    
    ## index 적용 예시\
    1. 어떤 컬럼에 인덱스를 만들면 좋을까
        - 중복된 데이터값들이 없는 고유한 데이터값을 가지는 컬럼에 만드는게 가장 좋음
            => 선택도selectivity가 좋은 컬럼이라함 
                EX) 아이디, 주번, 이메일 - good
                    이름                 - not bad
                    성별/여부            - 우우~
    2. 효율적인 인덱스 사용예
        - WHERE절에 자주 사용되는 컬럼
        - 두개이상의 컬럼이 WHERE, JOIN조건으로 자주 사용되는 경우
        - 한번 입력된 데이터의 변경이 자주 일어나지 않은 경우
        - 한 테이블에 저장된 데이터 용량이 클 경우
    3. 비효율적인 인덱스 사용예
        - 중복값이 많은 컬럼
        - null이 많은 컬럼
        - 무분별하게 인덱스 생성시 오히려 성능저하
*/

-- 테이블 생성시 PK, FK같은 경우 해당 컬럼을 가지고 자동으로 인덱스가 생성됨
SHOW INDEX FROM tbl_menu;

/*
    ## 실행계획
    테이블 접근 방법, 조인 순서, 데이터 처리 반식 등등이 표현되어있음
    
    * TYPE 종류(성능우선순위)
    1. system : 0개 또는 하나의 ROW를 가진 테이블
    2. const : PREPARE KEY, UNIQUE의 모든 컬럼에 대해 equal 조건으로 검색 반드시 1건의 레코드만 반환
    3. ref : 조인의 순서와 인데스의 종류와 관계없이 equal조건으로 검색
    4. unique_subquery : IN(sub-query) 형태의 조건에서 반환 값에 중복 없음
    5. index_subquery : unique_subquery와 비슷하지만 반환 값에 중복 있음
    6. range : 인덱스를 하나의 값이 아니라 범위로 검색
    7. index : 인덱스를 처음부터 끝까지 읽는 인덱덱스 풀 스캔
    8. ALL : 풀스캔 성능 안 조 음
*/
EXPLAIN SELECT * FROM tbl_menu; -- ALL 풀스캔
EXPLAIN SELECT * FROM tbl_menu WHERE menu_name = '열무김치라떼'; -- ALL 풀스캔
EXPLAIN SELECT * FROM tbl_menu WHERE menu_code = 1; -- const(pk 컬럼+equa 조건으로 조회)
EXPLAIN SELECT * FROM tbl_menu WHERE category_code = 4; # ref(index로 등록되어있는 fk컬럼으로 equal조건으로 조회)

CREATE TABLE phone(
    phone_code INT PRIMARY KEY,     # pk는 인덱스로 지정됨
    phone_name VARCHAR(100), 
    phone_price DECIMAL(10, 2)
);

INSERT INTO 
    phone(phone_code,phone_name,phone_price)
VALUES
    (1,'galaxy24',1800000),
    (2,'iphone16pro',1900000),
    (3,'galaxy2fold3',1720000)
;

SELECT * FROM phone;

-- 인덱스 확인
SHOW INDEX FROM phone;

EXPLAIN
SELECT *
FROM phone
-- WHERE phone_name = 'iphone16pro'; # 고유값이 아니기 때문에 all
-- WHERE phone_price = 300000000000000000; # all
WHERE phone_code = 1; # const

-- 인덱스 생성
CREATE INDEX idx_phone_price
ON phone(phone_price);

SHOW INDEX FROM phone;

EXPLAIN SELECT * FROM phone WHERE phone_price = 1800000; # ref


-- 인덱스 생성한거 삭제 -> 다시 타입 ALL로 돌아옴
DROP INDEX idx_phone_price ON phone;

CREATE INDEX idx_phone_name
ON phone(phone_name);

EXPLAIN SELECT * FROM phone 
WHERE 
--    phone_name = 'rgreg'; #인덱스 설정해서 ref (equal만 ref)
--    phone_name <> 'iphone16pro'; # range
--    phone_name LIKE 'iphone%'; # range
--    phone_name LIKE '%iphone%'; # all - 앞에 %가 있으면 인덱스가 사용되지 않음
--    LEFT(phone_name,1) = 'i'; # all - 인덱스 컬럼에 변경(산술,함수)가 가해질경우
--    phone_name IS NULL; # ref
--    phone_name IS NOT NULL; # range
    phone_name = 16; # all - 인덱스 컬럼의 타입과 비교 데이터의 타입이 다른 경우
    
    

-- 복합인덱스
-- 두개 이상의 컬럼을 한번에 하나의 인덱스로 설정해서 생성가능
CREATE INDEX idx_phone_name_price
ON phone(phone_name,phone_price);

SHOW INDEX FROM phone;

EXPLAIN
SELECT *
FROM phone
WHERE
--    phone_name = 'iphone16pro' AND phone_price = 20912123; # ref 
--    phone_name = '43TT344'; # ref
    phone_price = 12093841234; # index
    