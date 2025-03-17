-- DDL
-- CREATE

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
-- 제약조건 CONSTRAINT
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
-- -------------------------------------------------
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
-- ------------------------------------------------------
-- UNIQUE CONSTRAINT
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
-- 원하지 않는 값이 들어가는 문제
-- ------------------------------------------------------------
-- CHECK CONSTRAINT
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
-- -----------------------------------------------------
-- PRIMART KEY
DROP TABLE IF EXISTS tbl_user;
CREATE TABLE IF NOT EXISTS tbl_user(
    user_no INT, -- PRIMARY KEY, -- 컬럼 레벨 방식
    user_id VARCHAR(255) NOT NULL UNIQUE, 
    -- 회원번호가 있기때문에 ID를 PRIMARY KEY로 하지 않는다.
    -- 하지만 회원번호 또한 NOT NULL의 UNIQUE 값을 가지기 때문에 이를 대체키 라고 한다.
    user_pwd VARCHAR(255) NOT NULL,
    user_name VARCHAR(255) NOT NULL,
    gender CHAR(3) CHECK(gender IN ('남', '여')),
    age INT,
    PRIMARY KEY(user_no), -- 테이블 레벨 방식
    CHECK(age > 19)
);
SHOW FULL COLUMNS FROM tbl_user;
SELECT * FROM information_schema.TABLE_CONSTRAINTS WHERE table_name = 'tbl_user';

INSERT INTO
    tbl_user
VALUES
    (1, 'user01', 'pass01', '홍길동', '남', 20),
    (2, 'user02', 'pass01', '김첨지', '여', 30);
    
SELECT * FROM tbl_user;

INSERT INTO tbl_user VALUES (null, 'user03', 'pass03', '최불암', '남', 20);
    -- 오류 : user_no NOT NULL 제약조건 위배
INSERT INTO tbl_user VALUES(2, 'user03', 'pass03', '최불암', '남', 20);
    -- 오류 : UNIQUE 제약조건 위배

-- 복합키
CREATE TABLE IF NOT EXISTS tbl_like(
    user_no INT,
    prod_id INT,
    like_dt DATETIME,
    PRIMARY KEY(user_no, prod_id)
);
SELECT * FROM information_schema.TABLE_CONSTRAINTS WHERE table_name = 'tbl_like';
SHOW FULL COLUMNS FROM tbl_like;

INSERT INTO
    tbl_like(user_no, prod_id)
VALUES
    (1, 10),
    (1, 20),
    (2, 10);

SELECT * FROM tbl_like;

INSERT INTO tbl_like(user_no, prod_id) VALUES(1,10);
-- ----------------------------------------------------------------------
-- AUTO_INCREMENT
DROP TABLE IF EXISTS tbl_user;
CREATE TABLE IF NOT EXISTS tbl_user(
    user_no INT AUTO_INCREMENT,
    user_id VARCHAR(255) NOT NULL UNIQUE, 
    user_pwd VARCHAR(255) NOT NULL,
    user_name VARCHAR(255) NOT NULL,
    gender CHAR(3) CHECK(gender IN ('남', '여')),
    age INT,
    PRIMARY KEY(user_no),
    CHECK(age > 19)
);
SELECT * FROM tbl_user;
INSERT INTO tbl_user
VALUES (NULL, 'user01', 'pass01', '홍길동', null, null);
-- null 로 해도 자동으로 증가된 번호 입력

INSERT INTO tbl_user
VALUES (NULL, 'user02', 'pass01', '김첨지', '여', null),
       (0, 'user03', 'pass01', '박술녀', null, 25);
       
INSERT INTO tbl_user (user_id, user_pwd, user_name)
VALUES ('user_04', 'pass04', '최준준');

SELECT last_insert_id(); -- 마지막으로 발생된 번호를 조회하는 함수

INSERT INTO tbl_user
VALUES (15, 'user15', 'pass15', '이순신', '남', 80);


INSERT INTO tbl_user
VALUES (null, 'user16', 'pass16', '광개토', '남', 80);

-- AUTO_INCREMENT 시작값 변경
ALTER TABLE tbl_user AUTO_INCREMENT = 1000;

INSERT INTO tbl_user
VALUES (null, 'user17', 'pass17', '신사임당', '여', 80);

-- ============================================================
-- FOREIGN KEY
DROP TABLE tbl_user;

-- 회원등급 케이블
CREATE TABLE tbl_user_grade(
    grade_id INT PRIMARY KEY,
    grade_name VARCHAR(255) NOT NULL
);
INSERT INTO tbl_user_grade
VALUES  (10, '일반회원'),
        (20, '우수회원'),
        (30, '특별회원');

SELECT * FROM tbl_user_grade;

CREATE TABLE IF NOT EXISTS tbl_user(
    user_no INT PRIMARY KEY AUTO_INCREMENT,
    user_id VARCHAR(255) NOT NULL UNIQUE, 
    user_pwd VARCHAR(255) NOT NULL,
    user_name VARCHAR(255) NOT NULL,
    grade_code INT, -- tbl_user_grade 테이블의 grade_id 컬럼값만 들어올 수 있게 허용
    FOREIGN KEY (grade_code) REFERENCES tbl_user_grade(grade_id)
);

INSERT INTO tbl_user
VALUES  (null, 'user01', 'pass01', '홍길동', 10),
        (null, 'user02', 'pass02', '김첨지', 20),
        (null, 'user03', 'pass03', '강찬밥', null);

SELECT * FROM tbl_user;

INSERT INTO tbl_user
VALUES  (null, 'user04', 'pass04', '방방이', 50);

-- * 부모테이블 데이터 수정 및 삭제
UPDATE tbl_user_grade --  등급번호 변경
SET grade_id = 100
WHERE grade_id = 10; 
-- 부모데이터를 자식 레코드에서 사용하고 있기 때문에 변경 불가 (오류)

DELETE FROM tbl_user_grade
WHERE grade_id = 20; 
-- 부모데이터를 자식쪽에서 사용하고 있기 때문에 삭제 불가 (오류)

-- 외래키 제약조건 부여시 별도의 옵션을 제시하지 않으면
-- 해당 부모값을 참조하고 있는 자식레코드 존재시 수정 및 삭제가 불가하도록 제한 옵션이 걸려있음

DROP TABLE tbl_user;

CREATE TABLE IF NOT EXISTS tbl_user(
    user_no INT PRIMARY KEY AUTO_INCREMENT,
    user_id VARCHAR(255) NOT NULL UNIQUE, 
    user_pwd VARCHAR(255) NOT NULL,
    user_name VARCHAR(255) NOT NULL,
    grade_code INT, -- tbl_user_grade 테이블의 grade_id 컬럼값만 들어올 수 있게 허용
    FOREIGN KEY (grade_code) 
        REFERENCES tbl_user_grade(grade_id)
        -- ON UPDATE SET NULL -- 부모값을 수정하면 자식값을 NULL로 변경
        -- ON DELETE SET NULL -- 부모값을 삭제하면 자식값을 NULL로 설정
        ON UPDATE CASCADE -- 부모값을 수정하면 자식값도 같이 수정
        ON DELETE CASCADE -- 부모값을 삭제하면 자식값도 같이 삭제
);

INSERT INTO tbl_user
VALUES  (null, 'user01', 'pass01', '홍길동', 10),
        (null, 'user02', 'pass02', '김첨지', 20),
        (null, 'user03', 'pass03', '강찬밥', null);
        
SELECT * FROM tbl_user;
SELECT * FROM tbl_user_grade;

UPDATE tbl_user_grade
SET grade_id = 100
WHERE grade_id = 10; 

DELETE FROM tbl_user_grade
WHERE grade_id = 20; 

-- =================================================
-- * 테이블 생성시 서브쿼리 작성 가능
use menudb;

-- 15000원 이상 메뉴들만 따로 존재하는 테이블
SELECT * FROM tbl_menu;

CREATE TABLE tbl_expensive_menu
AS
SELECT menu_code, menu_name, menu_price
FROM tbl_menu
WHERE menu_price >= 15000;

SELECT * FROM tbl_expensive_menu;
DESC tbl_expensive_menu;

CREATE TABLE tbl_menu_copy
AS
SELECT *
FROM tbl_menu
WHERE 1=0;

SELECT * FROM tbl_menu_copy;

CREATE TABLE tbl_menu_category
AS
SELECT menu_name, category_name
FROM tbl_menu m
JOIN tbl_category c ON c.category_code = m.category_code;

SELECT * FROM tbl_menu_category;







