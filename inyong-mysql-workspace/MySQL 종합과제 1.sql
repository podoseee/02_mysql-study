/* 종합과제1(DDL, SELECT) - homeworkdb */

-- homeworkdb 이름의 데이터베이스를 생성한 후 해당 데이터베이스에서 아래의 문제를 푸시오.
USE homeworkdb;

-- 1. tbl_book 테이블 생성
CREATE TABLE tbl_book (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    book_name VARCHAR(100) NOT NULL,
    publisher VARCHAR(50) NOT NULL,
    price INT NOT NULL
);

-- 2. tbl_customer 테이블 생성
CREATE TABLE tbl_customer (
    cust_id INT AUTO_INCREMENT PRIMARY KEY,
    cust_name VARCHAR(20) NOT NULL,
    cust_addr VARCHAR(50) NOT NULL,
    cust_tel VARCHAR(20)
);

-- 3. tbl_order 테이블 생성
CREATE TABLE tbl_order (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    cust_id INT,
    book_id INT,
    amount INT NOT NULL,
    ordered_at DATE NOT NULL,
    FOREIGN KEY (cust_id) REFERENCES tbl_customer(cust_id) ON DELETE SET NULL,
    FOREIGN KEY (book_id) REFERENCES tbl_book(book_id) ON DELETE CASCADE
);

-- 4. tbl_book 데이터 삽입
INSERT INTO tbl_book (book_id, book_name, publisher, price) 
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

-- 5. tbl_customer 데이터 삽입
INSERT INTO tbl_customer (cust_id, cust_name, cust_addr, cust_tel) 
VALUES
(1000, '박지성', '영국', '000-000-0000'),
(1001, '김연아', '대한민국', '111-111-1111'),
(1002, '장미란', '대한민국', '222-222-2222'),
(1003, '추신수', '미국', '333-333-3333'),
(1004, '박세리', '대한민국', NULL);

-- 6. tbl_order 데이터 삽입
INSERT INTO tbl_order (order_id, cust_id, book_id, amount, ordered_at) 
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

-- 7. 책이름에 '올림픽'이 포함된 책 정보를 조회하시오.
SELECT book_id, book_name, publisher, price 
FROM tbl_book 
WHERE book_name LIKE '%올림픽%';

-- 8. 가격이 가장 비싼 책을 조회하시오.
SELECT book_id, book_name, publisher, price 
FROM tbl_book 
ORDER BY price DESC 
LIMIT 1;

-- 9. '2020-07-05'부터 '2020-07-09' 사이에 주문된 도서 정보를 조회하시오.
SELECT o.order_id, b.book_id, b.book_name 
FROM tbl_order o
JOIN tbl_book b ON o.book_id = b.book_id
WHERE o.ordered_at BETWEEN '2020-07-05' AND '2020-07-09';

-- 10. 주문한 이력이 없는 고객의 이름을 조회하시오.
SELECT c.cust_name 
FROM tbl_customer c
LEFT JOIN tbl_order o ON c.cust_id = o.cust_id
WHERE o.order_id IS NULL;

-- 11. '2020-07-04'부터 '2020-07-07' 사이에 주문 받은 도서를 제외하고 나머지 모든 주문 정보를 조회하시오.
SELECT o.order_id AS 구매번호, c.cust_name AS 구매자, b.book_name AS 책이름, (b.price * o.amount) AS 총구매액, o.ordered_at AS 주문일자
FROM tbl_order o
JOIN tbl_customer c ON o.cust_id = c.cust_id
JOIN tbl_book b ON o.book_id = b.book_id
WHERE o.ordered_at NOT BETWEEN '2020-07-04' AND '2020-07-07';

-- 12. 가장 최근에 구매한 고객의 이름, 책이름, 주문일자를 조회하시오.
SELECT c.cust_name, b.book_name, o.ordered_at
FROM tbl_order o
JOIN tbl_customer c ON o.cust_id = c.cust_id
JOIN tbl_book b ON o.book_id = b.book_id
ORDER BY o.ordered_at DESC
LIMIT 1;

-- 13. 주문된 적이 없는 책의 주문번호, 책번호, 책이름을 조회하시오.
SELECT NULL AS 주문번호, b.book_id, b.book_name
FROM tbl_book b
LEFT JOIN tbl_order o ON b.book_id = o.book_id
WHERE o.order_id IS NULL;

-- 14. 모든 서적 중에서 가장 비싼 서적을 구매한 고객이름, 책이름, 가격을 조회하시오.
SELECT COALESCE(c.cust_name, 'NULL') AS 고객명, b.book_name, b.price AS 책가격
FROM tbl_book b
LEFT JOIN tbl_order o ON b.book_id = o.book_id
LEFT JOIN tbl_customer c ON o.cust_id = c.cust_id
WHERE b.price = (SELECT MAX(price) FROM tbl_book);

-- 15. '김연아'가 구매한 도서수를 조회하시오.
SELECT c.cust_name, COUNT(o.book_id) AS 구매도서수
FROM tbl_customer c
JOIN tbl_order o ON c.cust_id = o.cust_id
WHERE c.cust_name = '김연아';

-- 16. 출판사별로 판매된 책의 개수를 조회하시오.
SELECT b.publisher, COUNT(o.book_id) AS 판매된책수
FROM tbl_book b
LEFT JOIN tbl_order o ON b.book_id = o.book_id
GROUP BY b.publisher;

-- 17. '박지성'이 구매한 도서를 발간한 출판사(publisher) 개수를 조회하시오.
SELECT c.cust_name, COUNT(DISTINCT b.publisher) AS 출판사수
FROM tbl_customer c
JOIN tbl_order o ON c.cust_id = o.cust_id
JOIN tbl_book b ON o.book_id = b.book_id
WHERE c.cust_name = '박지성';

-- 18. 모든 구매 고객의 이름과 총구매액(price * amount)을 조회하시오. 구매 이력이 있는 고객만 조회하시오.
SELECT c.cust_name, SUM(b.price * o.amount) AS 총구매액
FROM tbl_customer c
JOIN tbl_order o ON c.cust_id = o.cust_id
JOIN tbl_book b ON o.book_id = b.book_id
GROUP BY c.cust_name;

-- 19. 모든 구매 고객의 이름과 총구매액(price * amount)과 구매횟수를 조회하시오. 구매 이력이 없는 고객은 총구매액과 구매횟수를 0으로 조회하고, 고객번호 오름차순으로 정렬하시오.
SELECT c.cust_name, 
       COALESCE(SUM(b.price * o.amount), 0) AS 총구매액, 
       COALESCE(COUNT(o.order_id), 0) AS 구매횟수
FROM tbl_customer c
LEFT JOIN tbl_order o ON c.cust_id = o.cust_id
LEFT JOIN tbl_book b ON o.book_id = b.book_id
GROUP BY c.cust_id
ORDER BY c.cust_id;

-- 20. 총구매액이 2~3위인 고객의 이름와 총구매액을 조회하시오.
SELECT c.cust_name, SUM(b.price * o.amount) AS 총구매액
FROM tbl_customer c
JOIN tbl_order o ON c.cust_id = o.cust_id
JOIN tbl_book b ON o.book_id = b.book_id
GROUP BY c.cust_name
ORDER BY 총구매액 DESC
LIMIT 2 OFFSET 1;
