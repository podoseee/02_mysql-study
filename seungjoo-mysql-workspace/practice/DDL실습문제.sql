/* ## DDL 실습문제 - ddldb ## */
use ddldb;

-- 도서관리 프로그램을 위한 테이블을 구축하려고 한다. 
-- 아래의 요구사항에 맞춰 테이블 생성 및 샘플데이터를 추가하시오.

-- 1_1. 출판사 테이블 생성 
/*
    *  요구사항
    1. 테이블명 : tbl_publisher
    2. 컬럼 및 제약조건 
       1) 출판사번호 : pub_no, INT, 기본키, 자동순번
       2) 출판사명   : pub_name, VARCHAR(255), 필수
       3) 전화번호   : phone, VARCHAR(255)
    3. 컬럼마다 COMMENT 추가하기 
*/
CREATE TABLE IF NOT EXISTS tbl_publisher(
    pub_no INT AUTO_INCREMENT PRIMARY KEY COMMENT '출판사 번호',
    pub_name VARCHAR(255) NOT NULL COMMENT '출판사명',
    phone VARCHAR(255) COMMENT '전화번호'
    ) ENGINE = InnoDB;
-- 1_2. 출판사 테이블에 아래의 데이터 추가
/*
    pub_no  | pub_name  | phone
    =====================================
    1       | BR        | 02-1111-2222
    2       | 문학동네  | 02-3333-4444
    3       | 바람개비  | 02-1111-6666
    -------------------------------------
*/
INSERT INTO tbl_publisher VALUES(1, 'BR', '02-1111-2222');
INSERT INTO tbl_publisher VALUES(2, '문학동네', '02-3333-4444');
INSERT INTO tbl_publisher VALUES(3, '바람개비', '02-1111-6666');

-- 2_1. 도서 테이블 생성 
/*
    *  요구사항
    1. 테이블명 : tbl_book
    2. 컬럼 및 제약조건 
       1) 도서번호   : bk_no, INT, 기본키, 자동순번
       2) 도서명     : bk_title, VARCHAR(255), 필수
       3) 저자명     : bk_author, VARCHAR(255), 필수
       4) 도서가격   : bk_price, INT
       5) 출판사번호 : bk_pub_no, INT, 외래키(tbl_publisher 참조, 부모데이터 삭제시 자식데이터 삭제 옵션)
    3. 컬럼마다 COMMENT 추가하기 
*/
CREATE TABLE IF NOT EXISTS tbl_book (
    bk_no INT AUTO_INCREMENT PRIMARY KEY COMMENT '도서 번호',
    bk_title VARCHAR(255) NOT NULL COMMENT '도서명',
    bk_author VARCHAR(255) NOT NULL COMMENT '저자명',
    bk_price INT COMMENT '도서 가격',
    bk_pub_no INT COMMENT '출판사 번호 (tbl_publisher 참조)',
    CONSTRAINT fk_book_publisher FOREIGN KEY (bk_pub_no) 
        REFERENCES tbl_publisher (pub_no) ON DELETE CASCADE
) ENGINE=InnoDB COMMENT='도서 정보 테이블';



-- 2_2. 도서 테이블에 아래의 데이터 추가
/*
    bk_no | bk_title                 | bk_author    | bk_price | bk_pub_no
    ======================================================================
    1     | 칭찬은 고래도 춤추게한다.| 고래         | 10000    | 1
    2     | 자바의 정석              | 홍길동       | 20000    | 2
    3     | ORACLE 마스터하기        | 오라클       | 30000    | 2
    4     | 자바 완전 정복하기       | 제임스 고슬링| 15000    | 1
    5     | SQL문 익히기             | 선생님       | 15000    | 3
    ----------------------------------------------------------------------
*/
INSERT INTO tbl_book
VALUES(1,'칭찬은 고래도 춤추게한다.','고래', 10000,1);
INSERT INTO tbl_book VALUES(2,'자바의 정석', '홍길동', 20000, 2);
INSERT INTO tbl_book VALUES(3, 'ORACLE 마스터하기', '오라클', 30000, 3);
INSERT INTO tbl_book VALUES(4, '자바 완전 정복하기', '제임스 고슬링', 15000, 1);
INSERT INTO tbl_book VALUES(5,'SQL문 익히기', '선생님', 15000, 3);
select * from tbl_book;
-- 3_1. 회원 테이블 생성 
/*
    *  요구사항
    1. 테이블명 : tbl_member
    2. 컬럼 및 제약조건 
       1) 회원번호   : mem_no, INT, 기본키, 자동순번
       2) 아이디     : mem_id, VARCHAR(30), 필수, 중복불가
       3) 비밀번호   : mem_pwd, VARCHAR(30), 필수
       4) 회원명     : mem_name, VARCHAR(30), 필수
       5) 성별       : gender, CHAR(1), 'M'또는'F'만 허용
       6) 주소       : address, VARCHAR(255)
       7) 연락처     : phone, VARCHAR(30)
       8) 탈퇴여부   : status, CHAR(1), 'Y'또는'N'만 허용, 'N'기본값 
       9) 가입일시   : enroll_dt, DATETIME, 필수, NOW()기본값
    3. 컬럼마다 COMMENT 추가하기 
*/


CREATE TABLE IF NOT EXISTS tbl_member (
    mem_no INT AUTO_INCREMENT PRIMARY KEY COMMENT '멤버 번호',
    mem_id VARCHAR(30) NOT NULL UNIQUE COMMENT '멤버 아이디',
    mem_pwd VARCHAR(30) NOT NULL COMMENT '멤버 비밀번호',
    mem_name VARCHAR(30) NOT NULL COMMENT '회원명',
    gender CHAR(1) COMMENT '성별' CHECK (gender IN ('F', 'M')),
    address VARCHAR(255) COMMENT '주소',
    phone VARCHAR(30) COMMENT '연락처',
    status CHAR(1) DEFAULT 'N' COMMENT '지위' CHECK (status IN ('Y', 'N')),
    enroll_dt DATETIME NOT NULL DEFAULT  NOW() COMMENT '가입일시'
    
) ENGINE=InnoDB;


    
    
    
    
-- 3_2. 회원 테이블에 아래의 데이터 추가
/*
    mem_no    | mem_id    | mem_pwd     | mem_name    | gender | address       | phone         | status | enroll_dt
    ===================================================================================================================
    1001      | user01    | pass01      | 홍길동      | M      | 서울시 강서구 | 010-1111-2222 | 기본값 | 기본값
    1002      | user02    | pass02      | 강보람      | F      | 서울시 강남구 | 010-3333-4444 | 기본값 | 기본값
    1003      | user03    | pass03      | 신사임당    | F      | 서울시 양천구 | 010-7621-9018 | 기본값 | 기본값
    1004      | user04    | pass04      | 백신아      | F      | 서울시 관악구 | 010-4444-5555 | 기본값 | 기본값
    1005      | user05    | pass05      | 김말똥      | M      | 인천시 계양구 | 010-6666-7777 | 기본값 | 기본값
    -------------------------------------------------------------------------------------------------------------------
*/
INSERT INTO tbl_member (mem_no, mem_id, mem_pwd, mem_name, gender, address, phone, status, enroll_dt)
VALUES
    (1001, 'user01', 'pass01', '홍길동', 'M', '서울시 강서구', '010-1111-2222', DEFAULT, DEFAULT),
    (1002, 'user02', 'pass02', '강보람', 'F', '서울시 강남구', '010-3333-4444', DEFAULT, DEFAULT),
    (1003, 'user03', 'pass03', '신사임당', 'F', '서울시 양천구', '010-7621-9018', DEFAULT, DEFAULT),
    (1004, 'user04', 'pass04', '백신아', 'F', '서울시 관악구', '010-4444-5555', DEFAULT, DEFAULT),
    (1005, 'user05', 'pass05', '김말똥', 'M', '인천시 계양구', '010-6666-7777', DEFAULT, DEFAULT);

select * from tbl_book;

-- 4_1. 대여 이력 테이블 생성 
/*
    *  요구사항
    1. 테이블명 : tbl_rent
    2. 컬럼 및 제약조건 
       1) 대여이력번호 : rent_no, INT, 기본키, 자동순번
       2) 대여회원번호 : rent_mem_no, INT, 외래키(tbl_member 참조, 부모데이터 삭제시 자식데이터 null로 변경옵션)
       3) 대여도서번호 : rent_bk_no, INT,  외래키(tbl_book 참조, 부모데이터 삭제시 자식데이터 null로 변경옵션)
       4) 대여일시     : rent_dt, DATETIME, 필수, NOW()기본값
    3. 컬럼마다 COMMENT 추가하기 
*/
CREATE TABLE IF NOT EXISTS tbl_rent (
    rent_no INT PRIMARY KEY AUTO_INCREMENT COMMENT '대여이력번호',
    rent_mem_no INT  COMMENT '대여회원번호',
    rent_bk_no INT  COMMENT '대여도서번호',
    rent_dt DATETIME NOT NULL DEFAULT NOW() COMMENT '대여일시',
    CONSTRAINT fk_rent_member FOREIGN KEY (rent_mem_no) 
        REFERENCES tbl_member (mem_no) ON DELETE SET NULL,
    CONSTRAINT fk_rent_book FOREIGN KEY (rent_bk_no) 
        REFERENCES tbl_book (bk_no) ON DELETE SET NULL
) ENGINE=InnoDB;
    
    
    
    


-- 4_2. 회원 테이블에 아래의 데이터 추가
/*
    rent_no | rent_mem_no | rent_bk_no   | rent_dt
    =================================================
    1       | 1001        | 2            | 기본값
    2       | 1001        | 3            | 기본값
    3       | 1002        | 1            | 기본값
    4       | 1002        | 2            | 기본값
    5       | 1001        | 5            | 기본값
*/
INSERT INTO tbl_rent (rent_no, rent_mem_no, rent_bk_no, rent_dt)
VALUES
    (1, 1001, 2, DEFAULT),
    (2, 1001, 3, DEFAULT),
    (3, 1002, 1, DEFAULT),
    (4, 1002, 2, DEFAULT),
    (5, 1001, 5, DEFAULT);


-- 5. 커밋하시오. 
COMMIT;


-- 6. 전체 도서의 도서번호, 도서명, 저자명, 가격, 출판사명, 출판사전화번호를 조회하는 쿼리문을 작성하시오.

SELECT * FROM tbl_publisher;
SELECT bk_no, bk_title, bk_author, bk_price,pub_name, phone
FROM tbl_book INNER JOIN tbl_publisher
ON  bk_pub_no = pub_no;

select * from tbl_rent;
select * from tbl_member;
select * from tbl_book;

-- 7. 전체 대여목록의 회원명, 도서명, 대여일을 조회하는 쿼리문을 작성하시오.
select mem_name, bk_title, rent_dt
from tbl_member JOIN tbl_rent
on rent_mem_no = mem_no
JOIN tbl_book
ON rent_bk_no = bk_no;

-- 8. 2번 도서를 대여한 회원의 회원명, 아이디, 대여일, 반납예정일을 조회하는 쿼리문을 작성하시오.
SELECT 
    m.mem_name AS 회원명,
    m.mem_id AS 아이디,
    enroll_dt,
    r.rent_dt AS 반납예정일
FROM tbl_rent r
JOIN tbl_member m ON r.rent_mem_no = m.mem_no
WHERE r.rent_bk_no = 2;


-- 9. 회원번호가 1001인 회원이 대여한 도서의 도서명, 출판사명, 대여일, 반납예정일을 조회하는 쿼리문을 작성하시오. 
SELECT 
    b.bk_title AS 도서명,
    p.pub_name AS 출판사명,
    enroll_dt AS 대여일,
    r.rent_dt AS 반납예정일
FROM tbl_rent r
JOIN tbl_member m ON r.rent_mem_no = m.mem_no
JOIN tbl_book b ON r.rent_bk_no = b.bk_no
JOIN tbl_publisher p ON b.bk_pub_no = p.pub_no
WHERE r.rent_mem_no = 1001;

select * from tbl_book;
select * from tbl_member;
select * from tbl_rent;
select * from tbl_publisher;

-- 10. 전체 도서의 도서번호, 도서명, 대여건수를 조회하는 쿼리문을 작성하시오.
SELECT 
    b.bk_no AS 도서번호,
    b.bk_title AS 도서명,
    COUNT(r.rent_no) AS 대여건수
FROM tbl_book b
LEFT JOIN tbl_rent r ON b.bk_no = r.rent_bk_no
GROUP BY b.bk_no, b.bk_title;
