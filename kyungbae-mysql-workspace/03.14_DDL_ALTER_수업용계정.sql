-- DDL
-- ALTER
USE ddldb;

-- 컬럼 추가
DESC tbl_user;
SELECT * FROM tbl_user;

ALTER TABLE tbl_user ADD email VARCHAR(255);
-- 기존에 존재하는 행에는 NULL 로 들어가진다.

ALTER TABLE tbl_user ADD phone VARCHAR(20) UNIQUE AFTER user_name;
ALTER TABLE tbl_user 
ADD age INT CHECK(age >=19) DEFAULT 19 COMMENT '나이' AFTER phone;

-- 컬럼 변경
DESC tbl_user;
SELECT * FROM tbl_user;

ALTER TABLE tbl_user MODIFY phone INT; 
-- UNIQUE 제약조건 유지
-- 기존에 데이터가 없어서 자료형 변경 가능

ALTER TABLE tbl_user MODIFY user_no VARCHAR(255);
-- PK 제약조건 유지
-- 기존 데이터가 문자형으로 허용할만한 데이터이므로 변경됨

ALTER TABLE tbl_user MODIFY user_name VARCHAR(300);
-- NOT NULL 해제됨
-- 사이즈 변경 가능 

ALTER TABLE tbl_user MODIFY user_name VARCHAR(255) NOT NULL;
-- NOT NULL을 써야 유지됨
-- 사이즈가 기존에 존재하는 데이터 사이즈 범위 내에서만 줄일 수 있음

ALTER TABLE tbl_user MODIFY user_id VARCHAR(5);
-- 오류 : 기존 데이터가 허용하는 범위가 아님

ALTER TABLE tbl_user MODIFY user_id AFTER user_pwd;
-- 오류 : syntax error : 자료형 미작성 (자료형 작성 필수)

ALTER TABLE tbl_user MODIFY user_id VARCHAR(255) NOT NULL AFTER user_pwd;
-- 성공적

ALTER TABLE tbl_user
    MODIFY phone VARCHAR(255) DEFAULT '010-',
    MODIFY email VARCHAR(255) COMMENT '이메일';
-- ---------------------------------------------------
-- 컬럼명 변경
ALTER TABLE tbl_user
    RENAME COLUMN user_no TO no,
    RENAME COLUMN user_id TO id,
    RENAME COLUMN user_pwd TO pwd;

DESC tbl_user;
SELECT * FROM tbl_user;

-- 컬럼 삭제
ALTER TABLE tbl_user
    DROP COLUMN phone,
    DROP COLUMN email;

SELECT * FROM information_schema.TABLE_CONSTRAINTS WHERE table_name = 'tbl_user';

ALTER TABLE tbl_user
    ADD PRIMARY KEY(no),
    ADD CONSTRAINT user_id_uq UNIQUE(id),
    ADD CONSTRAINT user_name_chk CHECK (CHAR_LENGTH(user_name) >= 2),
    ADD CONSTRAINT user_grade_fk FOREIGN KEY(grade_code) REFERENCES tbl_user_grade(grade_id);

ALTER TABLE tbl_user
    MODIFY id VARCHAR(255) NOT NULL,
    MODIFY pwd VARCHAR(255) NOT NULL;

-- 제약조건 삭제
ALTER TABLE tbl_user
    DROP PRIMARY KEY,
    DROP CONSTRAINT user_id_uq,
    DROP CONSTRAINT user_name_chk,
    MODIFY id VARCHAR(255) NULL;

-- 테이블명 변경
ALTER TABLE tbl_user RENAME TO user_tbl;















