-- DDL

-- 특정 데이터베이스가 가지고 있는 테이블 정보 조회
SELECT
    table_schema
    , table_name
    , create_time
    , update_time
    , table_comment
FROM
    information_schema.TABLES
-- information_schema : MySQL의 메타정보를 제공하는 시스템 데이터베이스
WHERE
    table_schema = 'ddldb';

-- 테이블 내 컬럼 조회
SELECT
    table_name
    , column_name
    , ordinal_position 컬럼순번
    , is_nullable
    , column_type
    , column_comment
FROM
    information_schema.COLUMNS
WHERE
    table_schema = 'ddldb';

-- root 계정에서 ddldb 데이터베이스 생성 후에 권한 부여받고 진행
use ddldb;

-- CREATE
CREATE TABLE tbl_product(
    id INT,
    name VARCHAR(30),
    create_at DATETIME
) ENGINE=INNODB ;

DESC tbl_product;

DROP TABLE IF EXISTS tbl_product;

-- COMMENT
CREATE TABLE tbl_product(
    id INT COMMENT '아이디',
    name VARCHAR(30) COMMENT '상품명',
    create_at DATETIME COMMENT '등록일'
) ENGINE=INNODB COMMENT='상품' ;

-- COMMENT 변경
ALTER TABLE tbl_product COMMENT='상품정보';
ALTER TABLE tbl_product MODIFY id INT COMMENT '상품아이디';

-- 컬럼에 대한 정보 조회
SHOW FULL COLUMNS FROM tbl_product;

SELECT * FROM tbl_product;

DROP TABLE IF EXISTS tbl_product;

-- default
CREATE TABLE IF NOT EXISTS tbl_product(
    id INT COMMENT '상품아이디',
    name VARCHAR(30) DEFAULT '없음' COMMENT '상품명',
    create_at DATETIME COMMENT '등록일' DEFAULT NOW()
) ENGINE=INNODB COMMENT='상품정보';

SELECT * FROM tbl_product;
INSERT INTO tbl_product(id) VALUES(1);
INSERT INTO tbl_product VALUES(2, '아이폰', NOW());
INSERT INTO tbl_product() VALUES();
INSERT INTO tbl_product VALUES(3, DEFAULT, '2025-01-23');

-- ===========================================================
-- 제약조건
-- 제약조건 정보 조회
SELECT
    *
FROM
    information_schema.TABLE_CONSTRAINTS
WHERE
    constraint_schema = 'menudb'
AND table_name = 'tbl_menu';

CREATE TABLE IF NOT EXISTS tbl_user(
    user_no INT,
    user_id VARCHAR(255),
    user_pwd VARCHAR(255),
    user_name VARCHAR(255),
    gender CHAR(3),
    phone VARCHAR(255),
    email VARCHAR(255)
)ENGINE=INNODB;

INSERT INTO tbl_user
VALUES (1, null, null, '홍길동', '남', null, null);
SELECT * FROM tbl_user;

DROP TABLE IF EXISTS tbl_user;
-- NOT NULL CONSTRAINT
CREATE TABLE IF NOT EXISTS tbl_user(
    user_no INT NOT NULL,
    user_id VARCHAR(255) NOT NULL,
    user_pwd VARCHAR(255) NOT NULL,
    user_name VARCHAR(255) NOT NULL,
    gender CHAR(3),
    phone VARCHAR(255),
    email VARCHAR(255)
)ENGINE=INNODB;

INSERT INTO tbl_user
VALUES (1, NULL, 'pass01', '홍길동', '남', '010-1234-1234', 'hong@gmail.com');
-- NOT NULL 제약조건에 위배 오류 발생

INSERT INTO tbl_user
VALUES (1, 'user01', 'pass01', '홍길동', '남', '010-1234-1234', 'hong@gmail.com');

SELECT * FROM tbl_user;

INSERT INTO tbl_user
VALUES (2, 'user01', 'pass02', '김첨지', '여', '010-5678-5678', null);
-- id 중복문제

CREATE TABLE IF NOT EXISTS tbl_user(
    user_no INT NOT NULL UNIQUE, -- 컬럼레벨방식 (컬럼정의하는 구문에 바로 작성하는 방식)
    user_id VARCHAR(255) NOT NULL,
    user_pwd VARCHAR(255) NOT NULL,
    user_name VARCHAR(255) NOT NULL,
    gender CHAR(3),
    phone VARCHAR(255),
    email VARCHAR(255),
    UNIQUE(user_id) -- 테이블레벨방식 (컬럼정의하는 구문 맨 뒤에 제약조건을 따로 부여하는 방식)
)ENGINE=INNODB;


INSERT INTO tbl_user
VALUES (1, 'user01', 'pass01', '홍길동', '남', '010-1234-1234', 'hong@gmail.com');

INSERT INTO tbl_user
VALUES (2, 'user01', 'pass02', '김첨지', '여', '010-1212-3434', 'kim@gmail.com');
-- UNIQUE 제약조건 위배 오류

SELECT * FROM tbl_user;

INSERT INTO tbl_user
VALUES (2, 'user02', 'pass02', '김첨지', '나', '010-1212-3434', 'kim@gmail.com');

CREATE TABLE IF NOT EXISTS tbl_user(
    user_no INT NOT NULL UNIQUE, 
    user_id VARCHAR(255) NOT NULL UNIQUE,
    user_pwd VARCHAR(255) NOT NULL,
    user_name VARCHAR(255) NOT NULL,
    gender CHAR(3) CHECK(gender IN ('남', '여')), -- 컬럼레벨방식
    age INT,
    CHECK(age >= 19) -- 테이블레벨방식
)ENGINE=INNODB;

INSERT INTO tbl_user
VALUES (1, 'user01', 'pass01', '홍길동', '남', '20');

INSERT INTO tbl_user
VALUES (2, 'user02', 'pass02', '김첨지', '어', 20);
-- CHECK 제약조건 위배 오류
SELECT * FROM tbl_user;
INSERT INTO tbl_user
VALUES (2, 'user02', 'pass02', '김첨지', '여', 15);
-- CHECK 제약조건 위배 오류

SELECT * FROM information_schema.TABLE_CONSTRAINTS WHERE TABLE_NAME='tbl_user';

DROP TABLE tbl_user;

CREATE TABLE IF NOT EXISTS tbl_user(
    user_no INT NOT NULL UNIQUE, 
    user_id VARCHAR(255) NOT NULL UNIQUE,
    user_pwd VARCHAR(255) NOT NULL,
    user_name VARCHAR(255) NOT NULL,
    gender CHAR(3) CONSTRAINT user_gender_chk CHECK(gender IN ('남', '여')), -- 컬럼레벨방식
    age INT,
    CONSTRAINT user_age_chk CHECK(age >= 19) -- 테이블레벨방식
)ENGINE=INNODB;

INSERT INTO tbl_user
VALUES (1, 'user01', 'pass01', '홍길동', '남', '20');

INSERT INTO tbl_user
VALUES (2, 'user02', 'pass02', '김첨지', '어', 20);

INSERT INTO tbl_user
VALUES (2, 'user02', 'pass02', '김첨지', '여', 15);

SELECT * FROM tbl_user;

INSERT INTO tbl_user
VALUES (2, 'user02', 'pass02', '김첨지', null, null);

COMMIT;




