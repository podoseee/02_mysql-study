/* ## SELECT, DML 실습문제 - empdb ## */
use empdb;

-- 아래의 스크립트를 실행하여 db를 구축한 후 문제를 풀어주세요.

-- 테이블 삭제
DROP TABLE tbl_buy;
DROP TABLE tbl_product;
DROP TABLE tbl_user;

-- 사용자 테이블
CREATE TABLE tbl_user (
    user_no      INT          NOT NULL AUTO_INCREMENT          -- 사용자번호(기본키)
  , user_id      VARCHAR(20)  NOT NULL UNIQUE                  -- 사용자아이디
  , user_name    VARCHAR(20)  NULL                             -- 사용자명
  , user_year    INT          NULL                             -- 태어난년도
  , user_addr    VARCHAR(100) NULL                             -- 주소
  , user_mobile1 VARCHAR(3)   NULL                             -- 연락처1(010, 011 등)
  , user_mobile2 VARCHAR(8)   NULL                             -- 연락처2(12345678, 11111111 등)
  , user_regdate DATETIME     NULL                             -- 등록일
  , CONSTRAINT pk_user PRIMARY KEY(user_no)
);

-- 제품 테이블
CREATE TABLE tbl_product (
    prod_code     INT         NOT NULL AUTO_INCREMENT
  , prod_name     VARCHAR(20) NULL
  , prod_category VARCHAR(20) NULL
  , prod_price    INT         NULL
  , CONSTRAINT pk_product PRIMARY KEY(prod_code)
);

-- 구매 테이블
CREATE TABLE tbl_buy (
    buy_no     INT NOT NULL AUTO_INCREMENT
  , user_no    INT NULL
  , prod_code  INT NULL
  , buy_amount INT NULL
  , CONSTRAINT pk_buy PRIMARY KEY(buy_no)
  , CONSTRAINT fk_user_buy    FOREIGN KEY(user_no)   REFERENCES tbl_user(user_no)
  , CONSTRAINT fk_product_buy FOREIGN KEY(prod_code) REFERENCES tbl_product(prod_code) ON DELETE SET NULL
);

-- 사용자 테이블 데이터
INSERT INTO tbl_user(user_id, user_name, user_year, user_addr, user_mobile1, user_mobile2, user_regdate) VALUES ('YJS', '유재석', 1972, '서울', '010', '11111111', '2008-08-08');
INSERT INTO tbl_user(user_id, user_name, user_year, user_addr, user_mobile1, user_mobile2, user_regdate) VALUES ('KHD', '강호동', 1970, '경북', '011', '22222222', '2007-07-07');
INSERT INTO tbl_user(user_id, user_name, user_year, user_addr, user_mobile1, user_mobile2, user_regdate) VALUES ('KKJ', '김국진', 1965, '서울', '010', '33333333', '2009-09-09');
INSERT INTO tbl_user(user_id, user_name, user_year, user_addr, user_mobile1, user_mobile2, user_regdate) VALUES ('KYM', '김용만', 1967, '서울', '010', '44444444', '2015-05-05');
INSERT INTO tbl_user(user_id, user_name, user_year, user_addr, user_mobile1, user_mobile2, user_regdate) VALUES ('KJD', '김제동', 1974, '경남', NULL, NULL, '2013-03-03');
INSERT INTO tbl_user(user_id, user_name, user_year, user_addr, user_mobile1, user_mobile2, user_regdate) VALUES ('NHS', '남희석', 1971, '충남', '010', '55555555', '2014-04-04');
INSERT INTO tbl_user(user_id, user_name, user_year, user_addr, user_mobile1, user_mobile2, user_regdate) VALUES ('SDY', '신동엽', 1971, '경기', NULL, NULL, '2008-10-10');
INSERT INTO tbl_user(user_id, user_name, user_year, user_addr, user_mobile1, user_mobile2, user_regdate) VALUES ('LHJ', '이휘재', 1972, '경기', '011', '66666666', '2006-04-04');
INSERT INTO tbl_user(user_id, user_name, user_year, user_addr, user_mobile1, user_mobile2, user_regdate) VALUES ('LKK', '이경규', 1960, '경남', '011', '77777777', '2004-12-12');
INSERT INTO tbl_user(user_id, user_name, user_year, user_addr, user_mobile1, user_mobile2, user_regdate) VALUES ('PSH', '박수홍', 1970, '서울', '010', '88888888', '2012-05-05');

-- 제품 테이블 데이터
INSERT INTO tbl_product(prod_name, prod_category, prod_price) VALUES ('운동화', '신발', 30);
INSERT INTO tbl_product(prod_name, prod_category, prod_price) VALUES ('청바지', '의류', 50);
INSERT INTO tbl_product(prod_name, prod_category, prod_price) VALUES ('책', '잡화', 15);
INSERT INTO tbl_product(prod_name, prod_category, prod_price) VALUES ('노트북', '전자', 1000);
INSERT INTO tbl_product(prod_name, prod_category, prod_price) VALUES ('모니터', '전자', 200);
INSERT INTO tbl_product(prod_name, prod_category, prod_price) VALUES ('메모리', '전자', 80);
INSERT INTO tbl_product(prod_name, prod_category, prod_price) VALUES ('벨트', '잡화', 30);

-- 구매 테이블 데이터
INSERT INTO tbl_buy(user_no, prod_code, buy_amount) VALUES(2, 1, 2);
INSERT INTO tbl_buy(user_no, prod_code, buy_amount) VALUES(2, 4, 1);
INSERT INTO tbl_buy(user_no, prod_code, buy_amount) VALUES(4, 5, 1);
INSERT INTO tbl_buy(user_no, prod_code, buy_amount) VALUES(10, 5, 5);
INSERT INTO tbl_buy(user_no, prod_code, buy_amount) VALUES(2, 2, 3);
INSERT INTO tbl_buy(user_no, prod_code, buy_amount) VALUES(10, 6, 10);
INSERT INTO tbl_buy(user_no, prod_code, buy_amount) VALUES(5, 3, 5);
INSERT INTO tbl_buy(user_no, prod_code, buy_amount) VALUES(8, 3, 2);
INSERT INTO tbl_buy(user_no, prod_code, buy_amount) VALUES(8, 2, 1);
INSERT INTO tbl_buy(user_no, prod_code, buy_amount) VALUES(10, 1, 2);

COMMIT;


/****************************** 문 제 ****************************************/
-- 문제 풀기에 앞서 위의 스크립트 실행시 만들어진 테이블을 확인한 후 풀어주세요.
-- tbl_product(제품), tbl_user(사용자), tbl_buy(구매내역)

-- 1. 연락처1이 없는 사용자의 사용자번호, 아이디, 연락처1, 연락처2를 조회하시오.


-- 2. 연락처2가 '5'로 시작하는 사용자의 사용자번호, 아이디, 연락처1, 연락처2를 조회하시오.


-- 3. 2010년 이후에 가입한 사용자의 사용자번호, 아이디, 가입일을 조회하시오.


-- 4. 사용자번호와 연락처1, 연락처2를 연결하여 조회하시오. 연락처가 없는 경우 NULL 대신 'None'으로 조회하시오.


-- 5. 지역별 사용자수를 조회하시오. 


-- 6. '서울', '경기'를 제외한 지역별 사용자수를 조회하시오.
  

-- 7. 구매내역이 없는 사용자를 조회하시오. (아이디순으로 오름차순정렬)


-- 8. 카테고리별 구매횟수를 조회하시오.


-- 9. 아이디별 구매횟수를 조회하시오.


-- 10. 아이디별 구매횟수를 조회하시오. 
--    구매 이력이 없는 경우 구매횟수는 0으로 조회하고 아이디의 오름차순으로 조회하시오.


-- 11. 모든 제품의 제품명과 판매횟수를 조회하시오. 
--     판매 이력이 없는 제품은 0으로 조회하시오.


-- 12. 카테고리가 '전자'인 제품을 구매한 고객의 구매내역을 조회하시오.


-- 13. 제품을 구매한 이력이 있는 고객의 아이디, 고객명, 구매횟수, 총구매액을 조회하시오.


-- 14. 구매횟수가 2회 이상인 고객명과 구매횟수를 조회하시오.


-- 15. 어떤 고객이 어떤 제품을 구매했는지 조회하시오. 
--     구매 이력이 없는 고객도 조회하고 아이디로 오름차순 정렬하시오.


-- 16. 제품 테이블에서 제품명이 '책'인 제품의 카테고리를 '서적'으로 수정하시오.


-- 17. 연락처1이 '011'인 사용자의 연락처1을 모두 '010'으로 수정하시오.


-- 18. 구매번호가 가장 큰 구매내역을 삭제하시오.


-- 19. 제품코드가 1인 제품을 삭제하시오. 
--     삭제 이후 제품번호가 1인 제품의 구매내역이 어떻게 변하는지 확인해볼것


-- 20. 사용자번호가 5인 사용자를 삭제하시오. 
--     사용자번호가 5인 사용자의 구매 내역을 먼저 삭제한 뒤 진행하시오.