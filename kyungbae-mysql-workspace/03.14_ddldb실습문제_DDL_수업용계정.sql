/* ## DDL 실습문제 - ddldb ## */
use ddldb;

-- 도서관리 프로그램을 위한 테이블을 구축하려고 한다. 
-- 아래의 요구사항에 맞춰 테이블 생성 및 샘플데이터를 추가하시오.

-- 1_1. 출판사 테이블 생성 
CREATE TABLE tbl_publisher(
    pub_no INT PRIMARY KEY AUTO_INCREMENT COMMENT '출판사번호',
    pub_name VARCHAR(255) NOT NULL COMMENT '출판사명',
    phone VARCHAR(255) COMMENT '전화번호'
);
DESC tbl_publisher;
/*
    *  요구사항
    1. 테이블명 : tbl_publisher
    2. 컬럼 및 제약조건 
       1) 출판사번호 : pub_no, INT, 기본키, 자동순번
       2) 출판사명   : pub_name, VARCHAR(255), 필수
       3) 전화번호   : phone, VARCHAR(255)
    3. 컬럼마다 COMMENT 추가하기 
*/


-- 1_2. 출판사 테이블에 아래의 데이터 추가
INSERT tbl_publisher(pub_name, phone)
VALUES  ('BR', '02-1111-2222'),
        ('문학동네', '02-3333-4444'),
        ('바람개비', '02-1111-6666');
SELECT * FROM tbl_publisher;
/*
    pub_no  | pub_name  | phone
    =====================================
    1       | BR        | 02-1111-2222
    2       | 문학동네  | 02-3333-4444
    3       | 바람개비  | 02-1111-6666
    -------------------------------------
*/


-- 2_1. 도서 테이블 생성 
CREATE TABLE tbl_book(
    bk_no INT PRIMARY KEY AUTO_INCREMENT COMMENT '도서번호',
    bk_title VARCHAR(255) NOT NULL COMMENT '도서명',
    bk_author VARCHAR(255) NOT NULL COMMENT '저자명',
    bk_price INT COMMENT '도서가격',
    bk_pub_no INT COMMENT '출판사번호',
    FOREIGN KEY (bk_pub_no) REFERENCES tbl_publisher(pub_no)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);
DESC tbl_book;
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


-- 2_2. 도서 테이블에 아래의 데이터 추가
INSERT tbl_book(bk_title, bk_author, bk_price, bk_pub_no)
VALUES  ('칭찬은 고래도 춤추게한다.', '고래', 10000, 1),
        ('자바의 정석', '홍길동', 20000, 2),
        ('ORACLE 마스터하기', '오라클', 30000, 2),
        ('자바 완전 정복하기', '제임스 고슬링', 15000, 1),
        ('SQL문 익히기', '선생님', 15000, 3);
SELECT * FROM tbl_book;

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

DROP TABLE IF EXISTS tbl_member;
-- 3_1. 회원 테이블 생성 
CREATE TABLE tbl_member(
    mem_no INT PRIMARY KEY AUTO_INCREMENT COMMENT '회원번호',
    mem_id VARCHAR(30) NOT NULL UNIQUE COMMENT '아이디',
    mem_pwd VARCHAR(30) NOT NULL COMMENT '비밀번호',
    mem_name VARCHAR(30) NOT NULL COMMENT '회원명',
    gender CHAR(1) COMMENT '성별',
    address VARCHAR(255) COMMENT '주소',
    phone VARCHAR(30) COMMENT '연락처',
    status CHAR(1) DEFAULT 'N' COMMENT  '탈퇴여부',
    enroll_dt DATETIME DEFAULT NOW() NOT NULL COMMENT '가입일시',
    CHECK (gender IN('M', 'F')),
    CHECK (status IN('Y', 'N'))
);
DESC tbl_member;
RENAME TABLE tbl_menber TO tbl_member;
ALTER TABLE tbl_member MODIFY status CHAR(1) DEFAULT 'N';
ALTER TABLE tbl_member MODIFY enroll_dt DATETIME NOT NULL;
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


-- 3_2. 회원 테이블에 아래의 데이터 추가
INSERT tbl_member
VALUES (1000, 'user01', 'pass01', '홍길동', 'M', '서울시 강서구', '010-1111-2222', default, default);
UPDATE tbl_member SET phone = '010-1111-2222' WHERE mem_no = 1000;
SELECT * FROM tbl_member;
INSERT tbl_member
VALUES  (0, 'user02', 'pass02', '강보람', 'F', '서울시 강남구', '010-3333-4444', default, default),
        (0, 'user03', 'pass03', '신사임당', 'F', '서울시 양천구', '010-7621-9018', default, default),
        (0, 'user04', 'pass04', '백신아', 'F', '서울시 관악구', '010-4444-5555', default, default),
        (0, 'user05', 'pass05', '김말똥', 'M', '인천시 계양구', '010-6666-7777', default, default);
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


-- 4_1. 대여 이력 테이블 생성 
CREATE TABLE tbl_rent(
    rent_no INT PRIMARY KEY AUTO_INCREMENT COMMENT '대여이력번호',
    rent_mem_no INT COMMENT '대여회원번호',
    rent_bk_no INT COMMENT '대여도서번호',
    rent_dt DATETIME NOT NULL DEFAULT NOW() COMMENT '대여일시',
    FOREIGN KEY (rent_mem_no) REFERENCES tbl_member(mem_no)
    ON DELETE SET NULL,
    FOREIGN KEY (rent_bk_no) REFERENCES tbl_book(bk_no)
    ON DELETE SET NULL
);
DESC tbl_rent;
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


-- 4_2. 회원 테이블에 아래의 데이터 추가
INSERT tbl_rent
VALUES  (1, 1001, 2, default),
        (0, 1001, 3, default),
        (0, 1002, 1, default),
        (0, 1002, 2, default),
        (0, 1001, 5, default);
SELECT * FROM tbl_rent;
/*
    rent_no | rent_mem_no | rent_bk_no   | rent_dt
    =================================================
    1       | 1001        | 2            | 기본값
    2       | 1001        | 3            | 기본값
    3       | 1002        | 1            | 기본값
    4       | 1002        | 2            | 기본값
    5       | 1001        | 5            | 기본값
*/


-- 5. 커밋하시오. 
COMMIT;

-- 6. 전체 도서의 도서번호, 도서명, 저자명, 가격, 출판사명, 출판사전화번호를 조회하는 쿼리문을 작성하시오.
SELECT * FROM tbl_book;
SELECT * FROM tbl_publisher;
SELECT * FROM tbl_rent;
SELECT * FROM tbl_member;
SELECT
    bk_no 도서번호
    , bk_title 도서명
    , bk_author 저자명
    , bk_price 가격
    , p.pub_name 출판사명
    , p.phone 출판사전화번호
FROM
    tbl_book
    JOIN tbl_publisher p ON pub_no = bk_pub_no;

-- 7. 전체 대여목록의 회원명, 도서명, 대여일을 조회하는 쿼리문을 작성하시오.
SELECT
    mem_name 회원명
    , bk_title 도서명
    , DATE_FORMAT(rent_dt, '%y/%m/%d') 대여일
FROM
    tbl_rent
    JOIN tbl_member ON mem_no = rent_mem_no
    JOIN tbl_book ON bk_no = rent_bk_no
;

-- 8. 2번 도서를 대여한 회원의 회원명, 아이디, 대여일, 반납예정일을 조회하는 쿼리문을 작성하시오.
-- 반납 예정일 -> 대여일로부터 7일 후
SELECT
    mem_name 회원명
    , mem_id 아이디
    , DATE_FORMAT(rent_dt, '%y/%m/%d') 대여일
    , DATE_FORMAT(ADDDATE(rent_dt, 7), '%y/%m/%d' ) 반납예정일
FROM
    tbl_member
    JOIN tbl_rent ON mem_no = rent_mem_no
WHERE
    rent_bk_no = '2'
;

-- 9. 회원번호가 1001인 회원이 대여한 도서의 도서명, 출판사명, 대여일, 반납예정일을 조회하는 쿼리문을 작성하시오. 
SELECT
    bk_title 도서명
    , pub_name 출판사명
    , DATE_FORMAT(rent_dt, '%y/%m/%d') 대여일
    , DATE_FORMAT(ADDDATE(rent_dt, 7), '%y/%m/%d' ) 반납예정일
FROM
    tbl_member
    JOIN tbl_rent ON mem_no = rent_mem_no
    JOIN tbl_book ON bk_no = rent_bk_no
    JOIN tbl_publisher ON pub_no = bk_pub_no
WHERE
    mem_no = '1001';

-- 10. 전체 도서의 도서번호, 도서명, 대여건수를 조회하는 쿼리문을 작성하시오.
SELECT
    bk_no
    , bk_title
    , COUNT(rent_bk_no)
FROM
    tbl_rent
    JOIN tbl_book ON bk_no = rent_bk_no
GROUP BY 
    bk_no;
