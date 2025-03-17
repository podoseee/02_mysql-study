
/*
    ## DDL ## 
    1. Data Definition Language 
    2. 데이터 정의어 
    3. 데이터베이스 내의 객체(Object)들을 만들고, 수정하고, 삭제하는 구문 
    4. 주로 DB관리자 및 설계자가 사용
    5. 종류
       1) 생성 : CREATE
       2) 변경 : ALTER
       3) 삭제 : DROP
*/

-- 특정 데이터베이스가 가지고 있는 테이블 정보 조회 
SELECT
    table_schema
  , table_name
  , create_time
  , update_time
  , table_comment
FROM
    information_schema.TABLES -- * information_schema : MySQL의 메타정보(테이블,컬럼,인덱스,제약조건 등)를 제공하는 시스템 데이터베이스
WHERE
    table_schema = 'menudb';

-- 테이블내의 컬럼 조회 
SELECT
    table_name
  , column_name
  , ordinal_position
  , column_type
  , column_comment
FROM
    information_schema.COLUMNS
WHERE
    table_schema = 'menudb';
    
-- root 계정에서 ddldb 데이터베이스 생성 후에 권한부여받고 진행할것
use ddldb;

/*
    ## CREATE ##
    1. 객체 생성을 위한 구문
    2. 테이블 생성 표현법
       CREATE TABLE [IF NOT EXISTS] 테이블명(   -- IF NOT EXISTS 설정시 기존에 존재하는 테이블이라도 에러가 발생 안됨
            컬럼명 데이터타입,
            ...
       )
    3. 테이블명 및 컬럼명 명명규칙
       1) 소문자 이용 권장 
       2) 가급적 숫자 사용 지양
       3) 각 단어를 밑줄(_)로 연결하는 snake case 방식 사용 
       4) 테이블명은 테이블임을 알리는 prefix나 suffix값 사용 권장 (ex. tbl_, _tbl)
       5) PK 컬럼명은 id 또는 테이블명_id 형식으로 작성 권장 
       6) 지나친 줄임말 지양 
       
       
    ## 주요 DATA TYPE ##
    1. 문자형
       1) CHAR(SIZE)
          - 고정형 문자타입 : 지정한 사이즈보다 짧은 데이터가 입력될 경우 나머지 공간을 공백으로 채워서 저장
          - 최대 255 BYTE까지 저장 가능 
          - 고정적인 크기의 일반 문자열을 저장할때 주로 사용 
            ex) 성별(M/F), 여부(Y/N) 등
       2) VARCHAR(SIZE)
          - 가변형 문자타입 : 지정한 사이즈보다 짧은 데이터가 입력될 경우 실제 입력된 데이터 길이만큼 저장공간 사용
          - 최대 65,535 BYTE까지 저장 가능 
          - 가변적인 크기의 일반 문자열을 저장할때 주로 사용
            ex) 아이디, 이메일계정 등
    2. 숫자형
       1) INT
          - 4바이트
          - 저장 범위 : -21억xxx ~ 21억xxx
       2) FLOAT
          - 4바이트
          - 소수점 아래 7자리까지 표현 가능
       3) DOUBLE
          - 8바이트
          - 소수점 아래 15자리까지 표현 가능 
       4) DECIMAL(전체자리수, 소수점이하자리수)
          - DECIMAL(7,1)에 1234.567 저장시 1234.6으로 저장됨 
    3. 날짜형
       1) DATE
          - 날짜 형식만 사용됨
          - 저장 범위 : 1001-01-01 ~ 9999-12-31
          - 'YYYY-MM-DD' 형식으로 사용됨 
       2) TIME
          - 시간 형식만 사용됨
          - 저장 범위 : -898:59:59.000000 ~ 838:59:59.000000
          - 'HH:MM:SS' 형식으로 사용됨
       3) DATETIME 
          - 날짜와 시간이 같이 사용됨 
          - 저장 범위 : 1001-01-01 00:00:00 ~ 9999-12-31 23:59:59
*/

CREATE TABLE IF NOT EXISTS tbl_product(
    id INT,
    name VARCHAR(30),
    create_at DATETIME
) ENGINE=INNODB;

DESC tbl_product;

DROP TABLE /*IF EXISTS*/ tbl_product;

/*
    ## COMMENT ##
    테이블 및 컬럼에 대한 설명을 부여할 수 있는 구문
    
    1) 테이블에 COMMENT 부여 : 테이블 생성문 뒤에 COMMENT [=] '설명' 작성
    2) 컬럼에 COMMENT 부여   : 컬럼 정의구문 뒤에 COMMENT '설명' 작성
*/
CREATE TABLE tbl_product(
    id INT COMMENT '아이디',
    name VARCHAR(30) COMMENT '상품명',
    create_at DATETIME COMMENT '등록일시'
) ENGINE=INNODB COMMENT='상품';

DESC tbl_product;

/*
    ## COMMENT 변경 ##
    1) 테이블의 COMMENT 변경 : ALTER TABLE 테이블명 COMMENT = '설명';
    2) 컬럼의 COMMENT 변경   : ALTER TABLE 테이블명 MODIFY 컬럼명 데이터타입 COMMENT '설명';
    
    COMMENT 삭제하고자 할 경우 빈문자열로 지정하면됨  
*/
ALTER TABLE tbl_product COMMENT='상품정보';
ALTER TABLE tbl_product MODIFY id INT COMMENT '상품아이디';

-- 컬럼에 대한 정보 조회 
SHOW FULL COLUMNS FROM tbl_product;

SELECT * FROM tbl_product;
INSERT INTO tbl_product(id) VALUES(1);

DROP TABLE IF EXISTS tbl_product;

/*
    ## DEFAULT ##
    컬럼에 null 대신 저장시킬 기본값 적용하는 구문 
    컬럼 정의 구문 뒤에 DEFAULT 값 으로 작성 
*/

CREATE TABLE IF NOT EXISTS tbl_product(
    id          INT         COMMENT '상품아이디',
    name        VARCHAR(30) DEFAULT '없음'   COMMENT '상품명',
    create_at   DATETIME    COMMENT '등록일' DEFAULT NOW()
) ENGINE=INNODB COMMENT='상품정보';

SHOW FULL COLUMNS FROM tbl_product;

SELECT * FROM tbl_product;

INSERT INTO tbl_product(id) VALUES(1);
INSERT INTO tbl_product VALUES(2, '아이폰', NOW());
INSERT INTO tbl_product VALUES(3, DEFAULT, '2025-01-23');

-- =============================================================

/*
    ## 제약조건 ##
    1. CONSTRAINT
    2. 유효한 형식의 데이터값만 유지하기 위해 특정 컬럼에 부여하는 제약
    3. 데이터 무결성 보장을 목적으로 함 
    4. 데이터 입력(삽입)/수정시 데이터에 문제가 없는지 자동으로 검사해서 오류를 발생시킴
    5. 종류
       1) NOT NULL
       2) UNIQUE
       3) CHECK
       4) PRIMARY KEY
       5) FOREIGN KEY
*/

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
) ENGINE=INNODB;

INSERT INTO tbl_user
VALUES (1, null, null, '홍길동', '남', null, null);
SELECT * FROM tbl_user;
-- null이 허용되서는 안되는 컬럼에 null이 허용되는 문제 발생

/*
    ## NOT NULL 제약조건 ##
    특정 컬럼에 반드시 값이 존재해야되는 경우 해당 컬럼에 부여하는 제약조건
    즉, NULL을 허용하지 않도록 제한을 두는거임
*/
DROP TABLE tbl_user;
CREATE TABLE IF NOT EXISTS tbl_user(
    user_no INT NOT NULL,
    user_id VARCHAR(255) NOT NULL,
    user_pwd VARCHAR(255) NOT NULL,
    user_name VARCHAR(255) NOT NULL,
    gender CHAR(3) NULL,
    phone VARCHAR(255),
    email VARCHAR(255)
) ENGINE=INNODB;

INSERT INTO tbl_user
VALUES (1, null, 'pass01', '홍길동', '남', '010-1234-1234', 'hong@gmail.com');
-- NOT NULL 제약조건 위배 오류 발생
-- [1048] Column 'user_id' cannot be null

INSERT INTO tbl_user
VALUES (1, 'user01', 'pass01', '홍길동', '남', '010-1234-1234', 'hong@gmail.com');

SELECT * FROM tbl_user;

INSERT INTO tbl_user
VALUES (2, 'user01', 'pass02', '김말똥', '여', '010-2222-3333', null);
-- 아이디가 중복되서는 안됨 

/*
    ## UNIQUE 제약조건 ##
    특정 컬럼에 중복값을 허용하지 않을 경우 해당 컬럼에 부여하는 제약조건 
    즉, 중복값을 허용하지 않도록 제한을 두는걸 의미
*/
DROP TABLE tbl_user;
CREATE TABLE IF NOT EXISTS tbl_user(
    user_no INT NOT NULL UNIQUE,        -- 컬럼레벨방식 (컬럼정의하는 구문에 바로 작성하는 방식)
    user_id VARCHAR(255) NOT NULL,
    user_pwd VARCHAR(255) NOT NULL,
    user_name VARCHAR(255) NOT NULL,
    gender CHAR(3),
    phone VARCHAR(255),
    email VARCHAR(255),
    UNIQUE(user_id) -- 테이블레벨방식 (컬럼정의하는 구문 맨 뒤에 제약조건을 따로 부여하는 방식)
) ENGINE=INNODB;

INSERT INTO tbl_user
VALUES (1, 'user01', 'pass01', '홍길동', '남', '010-1234-1234', 'hong@gmail.com');

INSERT INTO tbl_user
VALUES (2, 'user01', 'pass02', '이순신', '남', '010-5511-2222', 'lee@gmail.com');
-- UNIQUE 제약조건 위배 오류 
-- [1062] Duplicate entry 'user01' for key 'tbl_user.user_id'

INSERT INTO tbl_user
VALUES (2, 'user02', 'pass02', '이순신', '나', '010-5511-2222', 'lee@gmail.com');
-- 유효하지 않은 성별값이 들어갈 수 있는 문제 발생 

SELECT * FROM tbl_user;

/*
    ## CHECK ##
    특정 컬럼에 특정 조건에 해당하는 값만 허용하고 싶을 경우 해당 컬럼에 부여하는 제약조건
    즉, 내가 지정한 조건에 부합한 데이터만을 허용할 수 있도록 제한두는걸 의미함 
*/
DROP TABLE tbl_user;
CREATE TABLE IF NOT EXISTS tbl_user(
    user_no INT NOT NULL UNIQUE,
    user_id VARCHAR(255) NOT NULL UNIQUE, 
    user_pwd VARCHAR(255) NOT NULL,
    user_name VARCHAR(255) NOT NULL, 
    gender CHAR(3) CHECK(gender IN ('남', '여')), -- 컬럼레벨방식
    age INT,
    CHECK(age >= 19) -- 테이블레벨방식
);

INSERT INTO tbl_user
VALUES (1, 'user01', 'pass01', '홍길동', '남', 20);

INSERT INTO tbl_user
VALUES (2, 'user02', 'pass02', '김말순', '어', 20);
-- CHECK 제약조건 위배 오류 
-- [3819] Check constraint 'tbl_user_chk_1' is violated

INSERT INTO tbl_user
VALUES (2, 'user02', 'pass02', '김말순', '여', 15);
-- CHECK 제약조건 위배 오류 
-- [3819] Check constraint 'tbl_user_chk_2' is violated

SELECT * FROM information_schema.TABLE_CONSTRAINTS WHERE TABLE_NAME='tbl_user';

/*
    제약조건이 위배되어서 오류발생시 => "제약조건명" 이 출력됨 
    제약조건명을 내가 직접 지어주지 않을 경우 MySQL에서 임의로 부여해줌 
    => 오류내용으로 정확히 어떤 컬럼에 어떤 문제인지 파악이 어려울 수 있음 
    
    ## 제약조건명 ## 
    제약조건 부여시 지어주는 이름 
    제약조건명은 중복 불가 
    
    [표현법]
    CONSTRAINT 제약조건명 제약조건
*/
DROP TABLE tbl_user;

CREATE TABLE IF NOT EXISTS tbl_user(
    user_no INT NOT NULL UNIQUE,
    user_id VARCHAR(255) NOT NULL UNIQUE, 
    user_pwd VARCHAR(255) NOT NULL,
    user_name VARCHAR(255) NOT NULL, 
    gender CHAR(3) CONSTRAINT user_gender_chk CHECK(gender IN ('남', '여')), -- 컬럼레벨방식
    age INT,
    CONSTRAINT user_age_chk CHECK(age >= 19) -- 테이블레벨방식
);

SELECT * FROM information_schema.TABLE_CONSTRAINTS WHERE TABLE_NAME='tbl_user';

INSERT INTO tbl_user
VALUES (1, 'user01', 'pass01', '홍길동', '남', 20);

INSERT INTO tbl_user
VALUES (2, 'user02', 'pass02', '김말순', '어', 20);

INSERT INTO tbl_user
VALUES (2, 'user02', 'pass02', '김말순', '여', 15); -- 오류내용에 제약조건명을 통해 정확히 문제점 파악 가능

INSERT INTO tbl_user
VALUES (2, 'user02', 'pass02', '김말순', null, null);
-- check 제약조건이라 해도 기본적으로 NULL 허용

SELECT * FROM tbl_user;

COMMIT;

/*
    ## PRIMARY KEY 제약조건 ## 
    각 행을 식별하기 위한 값을 보관할 컬럼에 부여하는 제약조건 
    테이블에 대한 식별자 역할을 수행함 
    NOT NULL + UNIQUE 를 의미
    한 테이블당 한 개만 설정 가능 
    
    ex) 회원번호, 학번, 사번, 부서코드, 예약번호, 주문번호, ..
*/
DROP TABLE IF EXISTS tbl_user;
CREATE TABLE IF NOT EXISTS tbl_user(
    user_no INT, -- PRIMARY KEY, -- 컬럼레벨방식
    user_id VARCHAR(255) NOT NULL UNIQUE,
    user_pwd VARCHAR(255) NOT NULL,
    user_name VARCHAR(255) NOT NULL,
    gender CHAR(3) CHECK(gender IN ('남', '여')),
    age INT, 
    PRIMARY KEY(user_no), -- 테이블레벨방식
    CHECK(age >= 19)
);

SHOW FULL COLUMNS FROM tbl_user;
SELECT * FROM information_schema.TABLE_CONSTRAINTS WHERE table_name = 'tbl_user';

INSERT INTO 
    tbl_user
VALUES
    (1, 'user01', 'pass01', '홍길동', '남', 20),
    (2, 'user02', 'pass01', '김말순', '여', 30);
    
SELECT * FROM tbl_user;

INSERT INTO
    tbl_user
VALUES
--    (null, 'user03', 'pass03', '김개똥', '남', 20); -- NOT NULL 제약조건 위배 오류 발생 
    (2, 'user03', 'pass03', '김개똥', '남', 20); -- UNIQUE 제약조건 위배 오류 발생

-- 복합키 설정 (여러 컬럼을 묶어서 하나의 PK로 설정)
CREATE TABLE tbl_like (
    user_no INT,
    pro_id INT,
    like_date DATETIME NOT NULL DEFAULT NOW(),
    PRIMARY KEY(user_no, pro_id)
);
SELECT * FROM information_schema.TABLE_CONSTRAINTS WHERE table_name = 'tbl_like';
SHOW FULL COLUMNS FROM tbl_like;

INSERT INTO
    tbl_like(user_no, pro_id)
VALUES
    (1, 10),
    (1, 20),
    (2, 10);
    
SELECT * FROM tbl_like;

INSERT INTO tbl_like(user_no, pro_id) VALUES(1, 10);

/*
    ## AUTO_INCREMENT ##
    INSERT시 PK컬럼에 자동으로 번호를 발생시켜 저장시킬수 있게 하는 구문 
    PK로 지정된 컬럼에만 부여가능한 옵션 
    
    INSERT시 NULL 또는 0을 지정하면 자동으로 다음 값이 할당됨 
    INSERT시 직접 값을 제시하면 그 이후부터는 제시한 값보다 큰 숫자부터 자동 증가
*/
DROP TABLE tbl_user;

CREATE TABLE IF NOT EXISTS tbl_user(
    user_no INT AUTO_INCREMENT, 
    user_id VARCHAR(255) NOT NULL UNIQUE,
    user_pwd VARCHAR(255) NOT NULL,
    user_name VARCHAR(255) NOT NULL,
    gender CHAR(3) CHECK(gender IN ('남', '여')),
    age INT, 
    PRIMARY KEY(user_no), 
    CHECK(age >= 19)
);

INSERT INTO tbl_user
VALUES(null, 'user01', 'pass01', '홍길동', null, null); -- null로 해도 자동으로 증가된 번호

SELECT * FROM tbl_user;

INSERT INTO
    tbl_user
VALUES
    (null, 'user02', 'pass02', '김말똥', '여', null),
    (0, 'user03', 'pass03', '김말순', null, 25);

INSERT INTO
    tbl_user(user_id, user_pwd, user_name)
VALUES
    ('user04', 'pass04', '홍길녀');

SELECT last_insert_id(); -- 마지막으로 발생된 번호 조회하는 함수 

INSERT INTO
    tbl_user
VALUES
    (15, 'user15', 'pass15', '이순신', '남', 80); -- 15
    
SELECT * FROM tbl_user;

INSERT INTO
    tbl_user
VALUES
    (null, 'user16', 'pass16', '광개토', '남', 80); -- 15부터 순차적으로 (16)

-- AUTO_INCREMENT 시작값 변경
ALTER TABLE tbl_user AUTO_INCREMENT = 1000;

INSERT INTO
    tbl_user
VALUES
    (null, 'user17', 'pass17', '신사임당', '여', 80);

/*
    PRIMARY KEY (PK, 기본키)
    FOREIGN KEY (FK, 외래키)

    ## FOREIGN KEY 제약조건 ## 
    참조(reference)된 다른 테이블에서 제공하는 값만 저장 가능한 컬럼에 부여하는 제약조건
*/
DROP TABLE tbl_user;

-- 회원 등급 테이블
CREATE TABLE tbl_user_grade(
    grade_id INT PRIMARY KEY,
    grade_name VARCHAR(255) NOT NULL
);
INSERT INTO 
    tbl_user_grade
VALUES
    (10, '일반회원'),
    (20, '우수회원'),
    (30, '특별회원');

SELECT * FROM tbl_user_grade;

CREATE TABLE tbl_user(
    user_no INT PRIMARY KEY AUTO_INCREMENT,
    user_id VARCHAR(255) NOT NULL UNIQUE,
    user_pwd VARCHAR(255) NOT NULL,
    user_name VARCHAR(255) NOT NULL,
    grade_code INT, -- 오로지 tbl_user_grade 테이블의 grade_id 컬럼값만 들어올 수 있게 허용
    FOREIGN KEY(grade_code) REFERENCES tbl_user_grade(grade_id)
);

INSERT INTO
    tbl_user
VALUES
    (null, 'user01', 'pass01', '홍길동', 10),
    (null, 'user02', 'pass02', '김말순', 20),
    (null, 'user03', 'pass03', '강개똥', null); -- FK 컬럼에 기본적으로 NULL 허용

SELECT * FROM tbl_user;

INSERT INTO tbl_user VALUES(null, 'user04', 'pass04', '강개순', 50);

-- tbl_user_grade (부모) 1
-- tbl_user       (자식) N

-- * 부모테이블(tbl_user_grade) 데이터 수정 및 삭제 
UPDATE tbl_user_grade -- 등급번호 10=>100
SET grade_id = 100
WHERE grade_id = 10; -- 10(부모데이터)를 자식 레코드에서 사용하고있기때문에 수정불가

DELETE 
FROM tbl_user_grade
WHERE grade_id = 20; -- 20(부모데이터)를 자식쪽에서 사용하고 있기때문에 삭제 불가

-- 외래키 제약조건 부여시 별도의 옵션을 제시하지 않으면
-- 해당 부모값을 참조하고 있는 자식레코드 존재시 수정 및 삭제가 불가하도록 제한 옵션이 걸려있음 

DROP TABLE tbl_user;

CREATE TABLE tbl_user(
    user_no INT PRIMARY KEY AUTO_INCREMENT,
    user_id VARCHAR(255) NOT NULL UNIQUE,
    user_pwd VARCHAR(255) NOT NULL,
    user_name VARCHAR(255) NOT NULL,
    grade_code INT, 
    FOREIGN KEY(grade_code) 
        REFERENCES tbl_user_grade(grade_id)
         --   ON UPDATE SET NULL => 부모데이터 update시 해당 자식값은 NULL로 변경
         --   ON DELETE SET NULL => 부모데이터 delete시 해당 자식값은 NULL로 변경
         ON UPDATE CASCADE -- => 부모데이터 update시 해당 자식값도 같이 update
         ON DELETE CASCADE -- => 부모데이터 delete시 해당 자식값도 같이 delete
);

INSERT INTO
    tbl_user
VALUES
    (null, 'user01', 'pass01', '홍길동', 10),
    (null, 'user02', 'pass02', '김말순', 20),
    (null, 'user03', 'pass03', '강개똥', null); -- FK 컬럼에 기본적으로 NULL 허용

SELECT * FROM tbl_user;

UPDATE tbl_user_grade
SET grade_id = 100
WHERE grade_id = 10;

SELECT * FROM tbl_user_grade;

DELETE FROM tbl_user_grade
WHERE grade_id = 20;

-- ==================================================================
-- * 테이블생성시 서브쿼리 작성 가능 
use menudb;

-- 비싼 메뉴(15000원이상)들만 따로 존재하는 테이블 
CREATE TABLE tbl_expensive_menu
AS
SELECT menu_code, menu_name, menu_price
FROM tbl_menu
WHERE menu_price >= 15000;

DESC tbl_expensive_menu;

SELECT * FROM tbl_expensive_menu;

CREATE TABLE tbl_menu_copy
AS
SELECT * 
FROM tbl_menu
WHERE 1=0; -- 데이터 없이 구조만 복사하고 싶을때 

SELECT * FROM tbl_menu_copy;

CREATE TABLE tbl_menu_category
AS
SELECT menu_name, category_name
FROM tbl_menu m
JOIN tbl_category c ON c.category_code = m.category_code;

SELECT * FROM tbl_menu_category;

-- ===========================================================

/*
    ## ALTER ##
    1. 객체 구조 변경을 위한 구문
    2. 구조에 대한 내용을 추가/변경/수정/삭제 하는걸 진행함 (데이터가 아님)
    3. 테이블 변경 표현법
       ALTER TABLE 테이블명 변경내용
    4. 변경내용
       1) 컬럼 추가|수정|삭제
       2) 제약조건 추가|삭제
       3) 테이블명 변경
*/
use ddldb;
/*
    ## 컬럼 추가 ##
    ADD 컬럼명 데이터타입 [제약조건] [DEFAULT] [COMMENT] [AFTER 기존컬럼]
*/
DESC tbl_user;
SELECT * FROM tbl_user;

ALTER TABLE tbl_user ADD email VARCHAR(255); -- 데이터로는 NULL이 들어감 
ALTER TABLE tbl_user ADD phone VARCHAR(20) UNIQUE AFTER user_name;

ALTER TABLE tbl_user
    ADD age INT CHECK(age>=19) DEFAULT 19 COMMENT '나이' AFTER phone; -- 데이터로는 DEFALUT값이 들어감
    
/*
    ## 컬럼 변경 ##
    MODIFY 컬럼명   자료형   [DEFAULT]   [COMMENT]   [AFTER 기존컬럼]
                 자료형변경  기본값변경  설명변경       순서변경
*/
DESC tbl_user;
SELECT * FROM tbl_user;

ALTER TABLE tbl_user MODIFY phone INT;            -- o(데이터가 없기때문에 문자형=>숫자형), UNIQUE 유지됨
ALTER TABLE tbl_user MODIFY user_no VARCHAR(255); -- o(데이터가 있어도 문자형으로 허용할만한 데이터이므로), PK유지됨
ALTER TABLE tbl_user MODIFY user_id VARCHAR(300); -- o, NOT NULL 해제됨 
ALTER TABLE tbl_user MODIFY user_id VARCHAR(300) NOT NULL; -- o, NOT NULL 써야만 유지됨 
ALTER TABLE tbl_user MODIFY user_id VARCHAR(5); -- x(기존 데이터들이 허용할만한 범위가 아니라)

ALTER TABLE tbl_user
--    MODIFY user_id AFTER user_pwd; -- 타입 미작성시 문법 오류
    MODIFY user_id VARCHAR(50) NOT NULL AFTER user_pwd;

ALTER TABLE tbl_user
    MODIFY phone VARCHAR(255) DEFAULT '010-',
    MODIFY email VARCHAR(255) COMMENT '이메일';
    
DESC tbl_user;

/*
    ## 컬럼명 변경 ## 
    RENAME COLUMN 기존컬럼명 TO 새컬럼명
*/
ALTER TABLE tbl_user
    RENAME COLUMN user_no TO no,
    RENAME COLUMN user_id TO id,
    RENAME COLUMN user_pwd TO pwd;

/*
    ## 컬럼 삭제 ##
    DROP COLUMN 컬럼명
*/
ALTER TABLE tbl_user
    DROP COLUMN phone,
    DROP COLUMN email;

ALTER TABLE tbl_like
    DROP COLUMN user_no,
    DROP COLUMN pro_id,
    DROP COLUMN like_date; -- 테이블의 모든 컬럼을 지울 순 없음 
    
/*
    ## 제약조건 추가 ##
    ADD [CONSTRAINT 제약조건명] 제약조건(컬럼명)
    MODIFY 컬럼명 자료형 NOT NULL (NOT NULL 제약조건 부여)
*/
SELECT * FROM information_schema.TABLE_CONSTRAINTS WHERE table_name = 'tbl_user';
DESC tbl_user;

ALTER TABLE tbl_user
    ADD PRIMARY KEY(no),
    ADD CONSTRAINT user_id_uq UNIQUE(id),
    ADD CONSTRAINT user_name_chk CHECK( CHAR_LENGTH(user_name) >= 2 ),
    ADD CONSTRAINT user_grade_fk FOREIGN KEY(grade_code) REFERENCES tbl_user_grade(grade_id);

DESC tbl_user;

ALTER TABLE tbl_user
    MODIFY id VARCHAR(50) NOT NULL,
    MODIFY pwd VARCHAR(255) NOT NULL;

/*
    ## 제약조건 삭제 ##
    DROP CONSTRAINT 제약조건명 
    DROP PRIMARY KEY (PK 제약조건 삭제)
    MODIFY 컬럼명 자료형 NULL (NOT NULL 삭제)
*/
ALTER TABLE tbl_user
    DROP PRIMARY KEY,
    DROP CONSTRAINT user_id_uq,
    DROP CONSTRAINT user_name_chk,
    MODIFY id VARCHAR(255) NULL;

/*
    ## 테이블명 변경 ##
    RENAME TO 새테이블명
*/
ALTER TABLE tbl_user RENAME TO user_tbl; -- RENAME TABLE tbl_user TO user_tbl;

-- ======================================================================

/*
    ## DROP ##
    1. 객체를 삭제하기 위한 구문
    2. 표현법
       DROP TABLE [IF EXISTS] 테이블명[, 테이블명,..]
*/
DROP TABLE IF EXISTS tbl_product;

DROP TABLE IF EXISTS tbl_user_grade; -- 참조되는 부모테이블같은 경우 삭제 제한됨 (자식 테이블 삭제 선행)

-- 외래키 제약조건을 잠시 비활성화 또는 삭제한 후 테이블 삭제하면 가능
SET FOREIGN_KEY_CHECKS = 0;

SET FOREIGN_KEY_CHECKS = 1;

/*
    ## TRUNCATE ## 
    테이블 내의 데이터만 삭제하는 구문
    즉, 테이블의 구조는 남기고 모든 행만 삭제하는 명령어 
    
    * DELETE VS TRUNCATE
    - DELETE는 조건제시 가능     => 일부행만 삭제도 가능 
      TRUNCATE는 조건제시 불가능 => 전체행만 삭제 가능 
      
    - DELETE는 삭제시 내부적으로 로그를 남기므로 ROLLBACK이 가능하나 속도가 느림 
      TRUNCATE는 삭제시 내부적으로 로그를 남기지 않아 속도는 빠르나 ROLLBACK이 안됨 
*/
TRUNCATE TABLE user_tbl;

SELECT * FROM user_tbl;

ROLLBACK;
