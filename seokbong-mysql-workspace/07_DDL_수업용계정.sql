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
    *
FROM
    information_schema.TABLES -- * information_schema : MySQL의 메타정보(테이블, 컬럼, 인덱스, 제약조건 등)를 제공하는 시스템 데이터베이스
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
       CREATE TABLE [IF NOT EXISTS]테이블명(        -- IF NOT EXISTS 설정시 기존에 존재하는 테이블이라도 에러가 발생 안됨
            컬럼명 데이터타입,
            ...
       )
    3. 테이블명 및 컬럼명 명명규칙
       1) 소문자 이용 권장
       2) 가급적 숫자 사용 지양
       3) 각 단어를 밑줄(_)로 연결하는 snake case 방식 사용
       4) 테이블명은 테이블임을 알리는 prefix나 suffix값 사용 권장 (ex. tbl_, _tbl)
       5) PK 컬럼명은 id 또는 테아블명_id 형식으로 작성 권장
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
          - 저장범위 : 1001-01-01 ~ 9999-12-31
          - 'YYYY-MM-DD' 형식으로 사용됨
       2) TIME
          - 시간 형식만 사용됨
          - 저장 범위 : -898:59:59.00000 ~ 838:59:59.00000
          - 'HH:MM:SS' 형식으로 사용됨
       3) DATETIME
          - 날짜와 시간이 같이 사용됨
          - 저장 범위 : 1001-01-01 00:00:00 ~ 1999-12-31 23:59:59
    
*/

CREATE TABLE IF NOT EXISTS tbl_product(
    id INT,
    name VARCHAR(30),
    create_at DATETIME
) ENGINE=INNODB ;

DESC tbl_product;

DROP TABLE /*IF EXISTS*/ tbl_product;

/*
    ## COMMENT ##
    테이블 및 컬럼에 대한 설명을 부여할 수 있는 구문
    
    1) 테이블에 COMMENT 부여 : 테이블 생성문 뒤에 COMMENT [=] '설명' 작성
    2) 컬럼에 COMMENT 부여   : 컬럼 정의구문 뒤에 COMMENT '설명' 작성
*/
CREATE TABlE tbl_product(
    id INT COMMENT '아이디',
    name VARCHAR(30) COMMENT '상품',
    create_at DATETIME COMMENT '등록일시'
)ENGINE=INNODB COMMENT='상품';

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
    컬럼 정의 구문 뒤에 DEFAULT 값으로 작성
*/

CREATE TABLE IF NOT EXISTS tbl_product(
    id          INT         COMMENT '상품아이디',
    name        VARCHAR(30) DEFAULT '없음' COMMENT '상품명',
    create_at   DATETIME    COMMENT '등록일' DEFAULT NOW()
) ENGINE=INNODB COMMENT='상품정보';

SHOW FULL COLUMNS FROM tbl_product;

SELECT * FROM tbl_product;

INSERT INTO tbl_product(id) VALUES(1);
INSERT INTO tbl_product VALUES(2, '아이폰', NOW());
INSERT INTO tbl_product VALUES(3, DEFAULT, '2025-01-23');

-- ==========================================================

/*
    ## 제약조건 ##
    1. CONSTRAINT
    2. 유효한 형식의 데이터값만 유지하기 위해 특정 컬럼에 부여하는 제약
    3. 데이터 무결성 보장을 목적으로 함
    4. 데이터 입렵(삽입)/수정시 데이터에 문제가 없는지 자동으로 검사해서 오류를 발생시킴
    5. 종류
       1) NOT NULL
       2) UNIQUE
       3) CHECK
       4) PRIMARY KEY
       5) FORIEGN KEY
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
    gender CHAR(3),
    phone VARCHAR(255),
    email VARCHAR(255)
) ENGINE=INNODB;

INSERT INTO tbl_user
VALUES (1, null, 'pass01', '홍길동', '남', '010-1234-1234', 'hong@gmail.com');
-- NOT NULL 제약조건 위배 오류 발생
-- [1048] COolumn 'user_id' cannot be null
INSERT INTO tbl_user
VALUES (1, 'user01', 'pass01', '홍길동', '남', '010-1234-1234', 'hong@gmail.com');

SELECT* FROM tbl_user;

INSERT INTO tbl_user
VALUES (2,'user01', 'pass02', '김말똥', '여', '010-2222-3333', null);
-- 아이디가 중복되서는 안됨

/*
    ## UNIQUI 제약조건 ##
    특정 컬럼에 중복값을 허용하지 않을 경우 해당 컬럼에 부여하는 제약조건
    즉, 중복값을 허용하지 않도록 제한을 두는걸 의미
*/
DROP TABLE tbl_user;
CREATE TABLE IF NOT EXISTS tbl_user(
    user_no INT NOT NULL UNIQUE,        -- 컬럼레벨방식(컬럼정의하는 구문에 바로 작성하는 방법
    user_id VARCHAR(255) NOT NULL,
    user_pwd VARCHAR(255) NOT NULL,
    user_name VARCHAR(255) NOT NULL,
    gender CHAR(3),
    phone VARCHAR(255),
    email VARCHAR(255),
    UNIQUE(user_id) -- 테이블블레벨방식 ( 컬ㄹ럼정의하는 구문 맨 뒤에 제약조건을 따로 부여하는 방식)
) ENGINE=INNODB;

INSERT INTO tbl_user
VALUES (1,'user01', 'pass01','홍길동','남', '010-1234-1234' , 'hong@gmail.com');
INSERT INTO tbl_user
VALUES (2,'user01', 'pass02','이순신','남', '010-5511-2222' , 'lee@gmail.com');
-- UNIQUE 제약조건 위배 오류
-- [1062] Duplicate entry 'user01' for key 'tbl_user.user_id'

INSERT INTO tbl_user
VALUES (2,'user02', 'pass02','이순신','나', '010-5511-2222' , 'lee@gmail.com');
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
    user_id VARCHAR(30) NOT NULL UNIQUE,
    user_pwd VARCHAR(30) NOT NULL,
    user_name VARCHAR(30) NOT NULL,
    gender CHAR(3) CHECK(gender IN('남','여')), -- 컬럼레벨방식
    age INT,
    CHECK(age >= 19) -- 테이블레벨방식
);

INSERT INTO tbl_user
VALUES (1,'user01', 'pass01','홍길동','남', 20);

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
    제약조건이 위배되어서 오류발생시 => "제약조건명"이 출력됨
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
    user_id VARCHAR(30) NOT NULL UNIQUE,
    user_pwd VARCHAR(30) NOT NULL,
    user_name VARCHAR(30) NOT NULL,
    gender CHAR(3) CONSTRAINT user_gender_chk CHECK(gender IN('남','여')), -- 컬럼레벨방식
    age INT,
    CONSTRAINT user_age_chk CHECK(age >= 19) -- 테이블레벨방식
);

SELECT * FROM information_schema.TABLE_CONSTRAINTS WHERE TABLE_NAME='tbl_user';

INSERT INTO tbl_user
VALUES (1,'user01', 'pass01','홍길동','남', 20);

INSERT INTO tbl_user
VALUES (2, 'user02', 'pass02', '김말순', '어', 20);

INSERT INTO tbl_user
VALUES (2, 'user02', 'pass02', '김말순', '여', 15); -- 오류내용에 제약조건명을 통해 정확히 문제점 파악 가능

INSERT INTO tbl_user
VALUES (2, 'user02', 'pass02', '김말순', null,null);
-- check 제약조건이라 해도 기본적으로 NULL 허용

SELECT * FROM tbl_user;

COMMIT;






