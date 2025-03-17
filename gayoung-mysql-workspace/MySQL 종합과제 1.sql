/* 종합과제1(DDL, SELECT) - homeworkdb */
use homeworkdb;
-- homeworkdb 이름의 데이터베이스를 생성한 후 해당 데이터베이스에서 아래의 문제를 푸시오.
CREATE TABLE tbl_book(
    book_id INT PRIMARY KEY AUTO_INCREMENT,
    book_name VARCHAR(100),
    publisher VARCHAR(50) ,
    price INT 
    );

CREATE TABLE tbl_customer (
    cust_id INT PRIMARY KEY AUTO_INCREMENT ,
    cust_name VARCHAR(20) ,
    cust_addr VARCHAR(50),
    cust_tel VARCHAR(20) 
);

CREATE TABLE tbl_order (
    order_id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    cust_id INT, -- FK
    book_id INT, -- FK
    amount INT,
    ordered_at DATE,
    FOREIGN KEY (cust_id) REFERENCES tbl_customer(cust_id) ON DELETE SET NULL,
    FOREIGN KEY (book_id) REFERENCES tbl_book(book_id) ON DELETE CASCADE
);

DESC tbl_book;
DESC tbl_customer;
DESC tbl_order;

INSERT INTO 
    tbl_book
VALUES
    (1, '축구의 역사', '굿스포츠', 7000),
    (2, '축구 아는 여자', '나이스북', 13000),
    (3, '축구의 이해', '대한미디어', 22000),
    (4, '골프 바이블', '대한미디어', 35000),
    (5, '피겨 교본', '굿스포츠', 6000),
    (6, '역도 단계별 기술', '굿스포츠', 6000),
    (7, '야구의 추억', '이상미디어', 20000),
    (8, '야구를 부탁해', '이상미디어', 13000),
    (9, '올림픽 이야기', '삼성당', 7500),
    (10, '올림픽 챔피언', '나이스북', 13000);

INSERT INTO
    tbl_customer
VALUES
    (null, '박지성', '영국', '000-000-0000'),
    (null, '김연아', '대한민국', '111-111-1111'),
    (null, '장미란', '대한민국', '222-222-2222'),
    (null, '추신수', '미국', '333-333-3333'),
    (null, '박세리', '대한민국', NULL);

SELECT * FROM tbl_book;
SELECT * FROM tbl_customer;
DESC tbl_customer;
DROP TABLE tbl_customer;
DROP TABLE tbl_order;

SET FOREIGN_KEY_CHECKS = 0;
DELETE FROM tbl_customer;
SELECT * FROM tbl_customer;
ALTER TABLE tbl_customer AUTO_INCREMENT = 1000;

-- 6. 아래 데이터를 tbl_order 테이블에 INSERT 하시오.
INSERT INTO 
    tbl_order
VALUES
    (1, 1000, 1, 1, '2020-07-01'),
    (2, 1000, 3, 2, '2020-07-03'),
    (3, 1001, 5, 1, '2020-07-03'),
    (4, 1002, 6, 2, '2020-07-04'),
    (5, 1003, 7, 3, '2020-07-05'),
    (6, 1000, 2, 5, '2020-07-07'),
    (7, 1003, 8, 2, '2020-07-07'),
    (8, 1002, 10, 2, '2020-07-08'),
    (9, 1001, 10, 1, '2020-07-09'),
    (10, 1002, 6, 4, '2020-07-10');

SELECT * FROM tbl_book;
SELECT * FROM tbl_customer;
SELECT * FROM tbl_order;

-- 7. 책이름에 '올림픽'이 포함된 책 정보를 조회하시오.
SELECT
    book_id
  , book_name
  , publisher
  , price
FROM
    tbl_book
WHERE
    book_name LIKE '%올림픽%';
    
    
-- 8. 가격이 가장 비싼 책을 조회하시오.
SELECT
    book_id
  , book_name
  , publisher
  , price
FROM
    tbl_book
WHERE
    price = (SELECT MAX(price) FROM tbl_book);
    
    
SELECT * FROM tbl_order;
SELECT * FROM tbl_book;

-- 9. '2020-07-05'부터 '2020-07-09' 사이에 주문된 도서 정보를 조회하시오.
SELECT 
    order_id '주문번호'
  , book_id '책번호'
  , book_name '책이름'
FROM
    tbl_order LEFT JOIN tbl_book USING(book_id)
WHERE
    ordered_at BETWEEN '2020-07-05' AND '2020-07-09';
    
-- 10. 주문한 이력이 없는 고객의 이름을 조회하시오.
SELECT 
    cust_name '고객명'
FROM
    tbl_customer LEFT JOIN tbl_order USING(cust_id)
WHERE 
    order_id IS NULL;
    
-- 11. '2020-07-04'부터 '2020-07-07' 사이에 주문 받은 도서를 제외하고 나머지 모든 주문 정보를 조회하시오.    
SELECT * FROM tbl_order;
SELECT * FROM tbl_book;

SELECT
    order_id '구매번호'
  , cust_name '구매자'
  , book_name '책이름'
  , price * amount '총구매액'
  , ordered_at '주문일자'
FROM 
    tbl_order
    JOIN tbl_customer USING(cust_id)
    JOIN tbl_book USING(book_id)
WHERE
    ordered_at NOT BETWEEN '2020-07-04' AND '2020-07-07';
    
SELECT * FROM tbl_order;
-- 12. 가장 최근에 구매한 고객의 이름, 책이름, 주문일자를 조회하시오.
SELECT
    cust_name '고객명'
  , book_name '책이름'
  , ordered_at '주문일자'
FROM 
    tbl_order
    JOIN tbl_customer USING(cust_id)
    JOIN tbl_book USING(book_id)
ORDER BY 
    ordered_at DESC
LIMIT 1;


SELECT * FROM tbl_order;
SELECT * FROM tbl_book;
-- 13. 주문된 적이 없는 책의 주문번호, 책번호, 책이름을 조회하시오.
SELECT
    order_id '주문번호'
  , book_id '책번호'
  , book_name '책이름'
FROM 
    tbl_book
    LEFT JOIN tbl_order USING(book_id)
WHERE 
    order_id IS NULL;
    
    
SELECT * FROM tbl_book; -- 책이름 가격
SELECT * FROM tbl_customer; -- 사람이름
SELECT * FROM tbl_order; --
-- 14. 모든 서적 중에서 가장 비싼 서적을 구매한 고객이름, 책이름, 가격을 조회하시오.
SELECT 
    cust_name 고객명
  , book_name 책이름
  , price 가격
FROM 
    tbl_customer
    RIGHT JOIN tbl_order USING(cust_id)
    Right JOIN tbl_book USING(book_id)
WHERE
    price = (SELECT MAX(price) from tbl_book);
    

-- 15. '김연아'가 구매한 도서수를 조회하시오.
SELECT 
    cust_name '고객명'
  , sum(amount) '구매도서수'
FROM
    tbl_order
    join tbl_customer USING(cust_id)
WHERE cust_id = (SELECT
                    cust_id
                  FROM 
                    tbl_customer
                  WHERE 
                    cust_name = '김연아')
GROUP BY cust_name;


SELECT * FROM tbl_order; -- AMOUNT
SELECT * FROM tbl_book; -- PUBLISHER

-- 16. 출판사별로 판매된 책의 개수를 조회하시오.
SELECT 
    publisher 출판사
  , sum(amount) 판매된책수
FROM tbl_order
        RIGHT JOIN tbl_book USING(book_id)
GROUP BY
    publisher;


SELECT * FROM tbl_order;
-- 17. '박지성'이 구매한 도서를 발간한 출판사(publisher) 개수를 조회하시오.
SELECT 
   cust_name 고객명
 , count(publisher) 출판사수
FROM
    tbl_book
    JOIN tbl_order USING(book_id)
    JOIN tbl_customer USING(cust_id)
GROUP BY 
    cust_name
HAVING 
    cust_name = '박지성';
    
    
SELECT * FROM tbl_customer;    
SELECT * FROM tbl_order;  -- amount
SELECT * FROM tbl_book;  -- price
   
-- 18. 모든 구매 고객의 이름과 총구매액(price * amount)을 조회하시오. 구매 이력이 있는 고객만 조회하시오.
SELECT 
   cust_name 고객명
 , SUM(amount*price) 총구매액
FROM 
    tbl_customer LEFT JOIN tbl_order USING(cust_id)
    JOIN tbl_book USING(book_id)
GROUP BY cust_name;

-- 19. 모든 구매 고객의 이름과 총구매액(price * amount)과 구매횟수를 조회하시오. 구매 이력이 없는 고객은 총구매액과 구매횟수를 0으로 조회하고, 고객번호 오름차순으로 정렬하시오.
SELECT 
    cust_name 고객명
 , IFNULL(SUM(amount*price), 0) 총구매액
 , COUNT(order_id) 구매횟수
FROM
    tbl_customer 
    LEFT JOIN tbl_order USING(cust_id)
    LEFT JOIN tbl_book USING(book_id)
  
GROUP BY cust_id;

-- 20. 총구매액이 2~3위인 고객의 이름와 총구매액을 조회하시오.

SELECT 
    cust_name 고객명
 , IFNULL(SUM(amount*price), 0) 총구매액
FROM
    tbl_customer 
    LEFT JOIN tbl_order USING(cust_id)
    LEFT JOIN tbl_book USING(book_id)
  
GROUP BY cust_id
ORDER BY 총구매액 DESC
LIMIT 2 OFFSET 1; -- 조회할 데이터 개수 / 건너뛸 데이터 개수 

