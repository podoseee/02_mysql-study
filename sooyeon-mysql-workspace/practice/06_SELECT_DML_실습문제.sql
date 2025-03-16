-- /* ## SELECT, DML 실습문제 - empdb ## */
-- use empdb;

-- -- 아래의 스크립트를 실행하여 db를 구축한 후 문제를 풀어주세요.

-- -- 테이블 삭제
-- -- ㅠ-DROP TABLE tbl_buy;
-- -- DROP TABLE tbl_product;
-- -- ㅠDROP TABLE tbl_user;

-- -- 사용자 테이블
-- CREATE TABLE tbl_user (
--     user_no      INT          NOT NULL AUTO_INCREMENT          -- 사용자번호(기본키)
--   , user_id      VARCHAR(20)  NOT NULL UNIQUE                  -- 사용자아이디
--   , user_name    VARCHAR(20)  NULL                             -- 사용자명
--   , user_year    INT          NULL                             -- 태어난년도
--   , user_addr    VARCHAR(100) NULL                             -- 주소
--   , user_mobile1 VARCHAR(3)   NULL                             -- 연락처1(010, 011 등)
--   , user_mobile2 VARCHAR(8)   NULL                             -- 연락처2(12345678, 11111111 등)
--   , user_regdate DATETIME     NULL                             -- 등록일
--   , CONSTRAINT pk_user PRIMARY KEY(user_no)
-- );

-- -- 제품 테이블
-- CREATE TABLE tbl_product (
--     prod_code     INT         NOT NULL AUTO_INCREMENT
--   , prod_name     VARCHAR(20) NULL
--   , prod_category VARCHAR(20) NULL
--   , prod_price    INT         NULL
--   , CONSTRAINT pk_product PRIMARY KEY(prod_code)
-- );

-- -- 구매 테이블
-- CREATE TABLE tbl_buy (
--     buy_no     INT NOT NULL AUTO_INCREMENT
--   , user_no    INT NULL
--   , prod_code  INT NULL
--   , buy_amount INT NULL
--   , CONSTRAINT pk_buy PRIMARY KEY(buy_no)
--   , CONSTRAINT fk_user_buy    FOREIGN KEY(user_no)   REFERENCES tbl_user(user_no)
--   , CONSTRAINT fk_product_buy FOREIGN KEY(prod_code) REFERENCES tbl_product(prod_code) ON DELETE SET NULL
-- );

-- -- 사용자 테이블 데이터
-- INSERT INTO tbl_user(user_id, user_name, user_year, user_addr, user_mobile1, user_mobile2, user_regdate) VALUES ('YJS', '유재석', 1972, '서울', '010', '11111111', '2008-08-08');
-- INSERT INTO tbl_user(user_id, user_name, user_year, user_addr, user_mobile1, user_mobile2, user_regdate) VALUES ('KHD', '강호동', 1970, '경북', '011', '22222222', '2007-07-07');
-- INSERT INTO tbl_user(user_id, user_name, user_year, user_addr, user_mobile1, user_mobile2, user_regdate) VALUES ('KKJ', '김국진', 1965, '서울', '010', '33333333', '2009-09-09');
-- INSERT INTO tbl_user(user_id, user_name, user_year, user_addr, user_mobile1, user_mobile2, user_regdate) VALUES ('KYM', '김용만', 1967, '서울', '010', '44444444', '2015-05-05');
-- INSERT INTO tbl_user(user_id, user_name, user_year, user_addr, user_mobile1, user_mobile2, user_regdate) VALUES ('KJD', '김제동', 1974, '경남', NULL, NULL, '2013-03-03');
-- INSERT INTO tbl_user(user_id, user_name, user_year, user_addr, user_mobile1, user_mobile2, user_regdate) VALUES ('NHS', '남희석', 1971, '충남', '010', '55555555', '2014-04-04');
-- INSERT INTO tbl_user(user_id, user_name, user_year, user_addr, user_mobile1, user_mobile2, user_regdate) VALUES ('SDY', '신동엽', 1971, '경기', NULL, NULL, '2008-10-10');
-- INSERT INTO tbl_user(user_id, user_name, user_year, user_addr, user_mobile1, user_mobile2, user_regdate) VALUES ('LHJ', '이휘재', 1972, '경기', '011', '66666666', '2006-04-04');
-- INSERT INTO tbl_user(user_id, user_name, user_year, user_addr, user_mobile1, user_mobile2, user_regdate) VALUES ('LKK', '이경규', 1960, '경남', '011', '77777777', '2004-12-12');
-- INSERT INTO tbl_user(user_id, user_name, user_year, user_addr, user_mobile1, user_mobile2, user_regdate) VALUES ('PSH', '박수홍', 1970, '서울', '010', '88888888', '2012-05-05');

-- -- 제품 테이블 데이터
-- INSERT INTO tbl_product(prod_name, prod_category, prod_price) VALUES ('운동화', '신발', 30);
-- INSERT INTO tbl_product(prod_name, prod_category, prod_price) VALUES ('청바지', '의류', 50);
-- INSERT INTO tbl_product(prod_name, prod_category, prod_price) VALUES ('책', '잡화', 15);
-- INSERT INTO tbl_product(prod_name, prod_category, prod_price) VALUES ('노트북', '전자', 1000);
-- INSERT INTO tbl_product(prod_name, prod_category, prod_price) VALUES ('모니터', '전자', 200);
-- INSERT INTO tbl_product(prod_name, prod_category, prod_price) VALUES ('메모리', '전자', 80);
-- INSERT INTO tbl_product(prod_name, prod_category, prod_price) VALUES ('벨트', '잡화', 30);

-- -- 구매 테이블 데이터
-- INSERT INTO tbl_buy(user_no, prod_code, buy_amount) VALUES(2, 1, 2);
-- INSERT INTO tbl_buy(user_no, prod_code, buy_amount) VALUES(2, 4, 1);
-- INSERT INTO tbl_buy(user_no, prod_code, buy_amount) VALUES(4, 5, 1);
-- INSERT INTO tbl_buy(user_no, prod_code, buy_amount) VALUES(10, 5, 5);
-- INSERT INTO tbl_buy(user_no, prod_code, buy_amount) VALUES(2, 2, 3);
-- INSERT INTO tbl_buy(user_no, prod_code, buy_amount) VALUES(10, 6, 10);
-- INSERT INTO tbl_buy(user_no, prod_code, buy_amount) VALUES(5, 3, 5);
-- INSERT INTO tbl_buy(user_no, prod_code, buy_amount) VALUES(8, 3, 2);
-- INSERT INTO tbl_buy(user_no, prod_code, buy_amount) VALUES(8, 2, 1);
-- INSERT INTO tbl_buy(user_no, prod_code, buy_amount) VALUES(10, 1, 2);

-- COMMIT;








/****************************** 문 제 ****************************************/
-- 문제 풀기에 앞서 위의 스크립트 실행시 만들어진 테이블을 확인한 후 풀어주세요.
-- tbl_product(제품), tbl_user(사용자), tbl_buy(구매내역)
select * from tbl_product; 
select * from tbl_user;
select * from tbl_buy;



-- 1. 연락처1이 없는 사용자의 사용자번호, 아이디, 연락처1, 연락처2를 조회하시오.
/*
'5','KJD',NULL,NULL
'7','SDY',NULL,NULL

*/
select
	user_no
    ,user_id
    ,user_mobile1
    ,user_mobile2
from
	tbl_user
where
	user_mobile1 is null
;


-- 2. 연락처2가 '5'로 시작하는 사용자의 사용자번호, 아이디, 연락처1, 연락처2를 조회하시오.
# '6','NHS','010','55555555'

select
	user_no
    ,user_id
    ,user_mobile1
    ,user_mobile2
from
	tbl_user
where
	user_mobile2 like "5%"
;

-- 3. 2010년 이후에 가입한 사용자의 사용자번호, 아이디, 가입일을 조회하시오.
/*
'4','KYM','2015-05-05 00:00:00'
'5','KJD','2013-03-03 00:00:00'
'6','NHS','2014-04-04 00:00:00'
'10','PSH','2012-05-05 00:00:00'

*/
select
	user_no
    ,user_id
    ,user_regdate
from
	tbl_user
where
	year(user_regdate) >= 2010
;



-- 4. 사용자번호와 연락처1, 연락처2를 연결하여 조회하시오. 연락처가 없는 경우 NULL 대신 'None'으로 조회하시오.
/*
'1','01011111111'
'2','01122222222'
'3','01033333333'
'4','01044444444'
'5','None'
'6','01055555555'
...
*/
select
	user_no
	,ifnull(concat(user_mobile1,user_mobile2),"None")
from
	tbl_user
;


-- 5. 지역별 사용자수를 조회하시오. 
/*
'서울','4'
'경북','1'
'경남','2'
'충남','1'
'경기','2'
*/
select
	user_addr
	,count(*)
from
	tbl_user
group by
	user_addr
;

-- 6. '서울', '경기'를 제외한 지역별 사용자수를 조회하시오.
/*
'경북','1'
'경남','2'
'충남','1'
*/
select
	user_addr
	,count(*)
 from
	tbl_user
group by
	user_addr
having
	user_addr not in ("서울","경기")  
;
  

-- 7. 구매내역이 없는 사용자를 조회하시오. (아이디순으로 오름차순정렬)
/*
'1','YJS','유재석','1972','서울','010','11111111','2008-08-08 00:00:00'
'3','KKJ','김국진','1965','서울','010','33333333','2009-09-09 00:00:00'
'6','NHS','남희석','1971','충남','010','55555555','2014-04-04 00:00:00'
'7','SDY','신동엽','1971','경기',NULL,NULL,'2008-10-10 00:00:00'
'9','LKK','이경규','1960','경남','011','77777777','2004-12-12 00:00:00'
*/

select
	u.user_no
    ,user_id
    ,user_name
    ,user_year
    ,user_addr
    ,user_mobile1
    ,user_mobile2
    ,user_regdate
from
	tbl_user u
		left join tbl_buy b on b.user_no = u.user_no
where
	b.buy_no is null
order by
	user_id
;


select
	*
from
	tbl_user u
where
	not exists (select buy_no from tbl_buy where u.user_no = user_no)
;
	


-- 8. 카테고리별 구매횟수를 조회하시오.
/*
'신발','2'
'의류','2'
'잡화','2'
'전자','4'
*/
select
	p.prod_category
    , count(*)
from
	tbl_product p
		join tbl_buy b on b.prod_code = p.prod_code
group by
	p.prod_category
;

-- 9. 아이디별 구매횟수를 조회하시오.
/*
'KHD','3'
'KJD','1'
'KYM','1'
'LHJ','2'
'PSH','3'
*/
select
	u.user_id
    ,count(*)
from
	tbl_user u
		join tbl_buy b on b.user_no = u.user_no
group by
	user_id
;

-- 10. 아이디별 구매횟수를 조회하시오. 
--    구매 이력이 없는 경우 구매횟수는 0으로 조회하고 아이디의 오름차순으로 조회하시오.
/*
'KHD','3'
'KJD','1'
'KKJ','0'
'KYM','1'
'LHJ','2'
'LKK','0'
...
*/
select
	u.user_id
	,coalesce(count(b.buy_no),0) 
from
	tbl_user u
		left join tbl_buy b on b.user_no = u.user_no
group by
	user_id
order by
	user_id
;


-- 11. 모든 제품의 제품명과 판매횟수를 조회하시오. 
--     판매 이력이 없는 제품은 0으로 조회하시오.
/*
'운동화','4'
'청바지','4'
'책','7'
'노트북','1'
'모니터','6'
'메모리','10'
*/
select
	prod_name
    ,sum(buy_amount)
from
	tbl_buy b
		join tbl_product p on p.prod_code = b.prod_code
group by 
	prod_name
;

-- 12. 카테고리가 '전자'인 제품을 구매한 고객의 구매내역을 조회하시오.
/*
'2','강호동','2','4','1'
'3','김용만','4','5','1'
'4','박수홍','10','5','5'
'6','박수홍','10','6','10'
*/
select
	b.buy_no
    ,user_name
    ,b.user_no
    ,b.prod_code
    ,b.buy_amount
from
	tbl_buy b
		-- join tbl_product p on p.prod_code = b.prod_code
        join tbl_user u on u.user_no = b.user_no
where
	-- prod_category = "전자"
    "전자" = (select prod_category from tbl_product where prod_code = b.prod_code)
;


-- 13. 제품을 구매한 이력이 있는 고객의 아이디, 고객명, 구매횟수, 총구매액을 조회하시오.
/*
'KHD','강호동','6','1210'
'PSH','박수홍','17','1860'
'LHJ','이휘재','3','80'
'KJD','김제동','5','75'
'KYM','김용만','1','200'
*/
select
	user_id
    ,user_name
    ,sum(buy_amount)
    ,sum(buy_amount * prod_price)
from
	tbl_buy b
		join tbl_user u on u.user_no = b.user_no
        join tbl_product p on p.prod_code = b.prod_code
group by
	user_id, user_name
;

-- 14. 구매횟수가 2회 이상인 고객명과 구매횟수를 조회하시오.
/*
'강호동','6'
'박수홍','17'
'김제동','5'
'이휘재','3'
*/
select
	user_name
	,sum(buy_amount) as 구매횟수
from
	tbl_buy b
		join tbl_user u on u.user_no = b.user_no
group by
	user_name
having 
	구매횟수 >= 2
;

-- 15. 어떤 고객이 어떤 제품을 구매했는지 조회하시오. 
--     구매 이력이 없는 고객도 조회하고 아이디로 오름차순 정렬하시오.
/*
'2','KHD','강호동','1970','경북','01122222222','2007-07-07 00:00:00','1','운동화','신발','30'
'2','KHD','강호동','1970','경북','01122222222','2007-07-07 00:00:00','4','노트북','전자','1000'
'2','KHD','강호동','1970','경북','01122222222','2007-07-07 00:00:00','2','청바지','의류','50'
'5','KJD','김제동','1974','경남',NULL,'2013-03-03 00:00:00','3','책','잡화','15'
'3','KKJ','김국진','1965','서울','01033333333','2009-09-09 00:00:00',NULL,NULL,NULL,NULL
'4','KYM','김용만','1967','서울','01044444444','2015-05-05 00:00:00','5','모니터','전자','200'
*/
select
	u.user_no
    ,user_id
    ,user_name
    ,user_year
    ,user_addr
    ,concat(user_mobile1,user_mobile2)
    ,user_regdate
    ,p.prod_code
    ,prod_name
    ,prod_category
    ,prod_price
from
	tbl_buy b
		right join tbl_user u on u.user_no = b.user_no # 구매내역이 없는 고객도출력하기 위해서는 tbl_user행을 기존으로 출력해야함.
        left join tbl_product p on p.prod_code = b.prod_code
order by
	user_id
;













SHOW VARIABLES LIKE 'autocommit';
SET autocommit = OFF;
commit;



-- 16. 제품 테이블에서 제품명이 '책'인 제품의 카테고리를 '서적'으로 수정하시오.
update
	tbl_product
set
	prod_category = "서적"
where
	prod_name = "책"
;

commit;
-- 17. 연락처1이 '011'인 사용자의 연락처1을 모두 '010'으로 수정하시오.
update
	tbl_user
set 
	user_mobile1 = "010"
where
	user_mobile1 = "011"
;


commit;
-- 18. 구매번호가 가장 큰 구매내역을 삭제하시오.	
delete
from
	tbl_buy
order by
	buy_no desc
limit 1;



commit;
-- 19. 제품코드가 1인 제품을 삭제하시오. 
--     삭제 이후 제품번호가 1인 제품의 구매내역이 어떻게 변하는지 확인해볼것 : null이 된다.RESTRICT면 안됨(부모테이블에서 참조되고 행의 삭제 불가)
delete
from
	tbl_product
where
	prod_code = 1
;


commit; 
-- 20. 사용자번호가 5인 사용자를 삭제하시오. 
--     사용자번호가 5인 사용자의 구매 내역을 먼저 삭제한 뒤 진행하시오.
select * from tbl_product; 
select * from tbl_user;
select * from tbl_buy;
SHOW CREATE TABLE tbl_buy;


delete
from
	tbl_buy
where
	user_no = 5;
    
commit;

delete
from
	tbl_user
where
	user_no = 5;
    
commit;