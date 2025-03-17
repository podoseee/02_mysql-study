use chundb;

-- 1. 계열 정보를 저장할 테이블을 생성하려고 한다. 아래의 요구사항을 참고하여 작성하시오.

CREATE TABLE tb_category(
    name VARCHAR(10),
    user_yn CHAR(1) DEFAULT 'Y'
);

-- 2. 과목 구분을 저장할 테이블을 만들려고 한다. 아래의 요구사항을 참고하여 작성하시오.
CREATE TABLE tb_class_type(
    no VARCHAR(5) PRIMARY KEY,
    name VARCHAR(10) NOT NULL
);
-- 3. tb_category 테이블의 name 컬럼에 기본키 제약조건을 부여하시오. 
ALTER TABLE tb_category
ADD PRIMARY KEY(name);


-- 4. tb_class_type 테이블의 name 컬럼에 NULL이 허용되지 않도록 하시오.
ALTER TABLE tb_class_type
MODIFY name VARCHAR(10) NOT NULL;

-- 5.  tb_category, tb_class_type 테이블에 name 컬럼을 기존 타입은 유지하면서 
--     허용 가능 바이트사이즈를 20으로 변경하시오.
--     tb_class_type 테이블에 no 컬럼은 기존 타입은 유지하면서 크기는 10으로 변경하시오.
ALTER TABLE tb_class_type
MODIFY name VARCHAR(20),
MODIFY no VARCHAR(10);

DESC tb_class_type;

-- 6. tb_category, tb_class_type 테이블에 존재하는 no 컬럼과 name 컬럼의 컬럼명을 
-- 각 테이블 이름을 붙인 형태로 변경하시오. 
ALTER TABLE tb_category
RENAME COLUMN name TO tb_category_name;
    
ALTER TABLE tb_class_type
RENAME COLUMN name TO tb_class_type_name,
RENAME COLUMN no TO tb_class_type_no;


-- 7. 아래의 데이터를 참고하여 tb_category 테이블에 데이터를 추가하시오. (정상수행시 트랜잭션 완료처리)
SELECT * FROM tb_category;

INSERT INTO tb_category
VALUES
    ('공학', 'Y'),
    ('자연과학', 'Y'),
    ('의학', 'Y'),
    ('예체능', 'Y'),
    ('인문사회', 'Y');
COMMIT;
    
-- 8. tb_department의 category 컬럼이 tb_category 테이블의 category_name 컬럼을 부모값으로 참조하도록 FOREIGN KEY 제약조건을 부여하시오. 
--    이때 제약조건명은 "fk_테이블명_컬럼명" 으로 지정하시오.  

SELECT * FROM tb_department;
SELECT * FROM tb_category;
DESC tb_department;

ALTER TABLE tb_department
ADD CONSTRAINT fk_department_category FOREIGN KEY(category) REFERENCES tb_category(tb_category_name);

SELECT *  FROM information_schema.TABLE_CONSTRAINTS WHERE table_name = 'tb_department';


-- 9. 아래의 데이터를 참고하여 tb_class_type 테이블에 데이터를 추가하시오. (정상수행시 트랜잭션 완료처리)
SELECT * FROM tb_class_type;
DESC tb_class_type;

INSERT INTO tb_class_type
VALUES
    ('01', '전공필수'),
    ('02', '전공선택'),
    ('03', '교양필수'),
    ('04', '교양선택'),
    ('05', '논문지도');

COMMIT;

-- 10. 춘 기술대학교 학생들의 정보가 포함되어 있는 학생일반정보테이블을 생성하고자 한다. 
-- 아래의 요구사항을 참고하여 작성하시오.

CREATE TABLE tb_학생일반정보테이블
AS
SELECT 
     student_no AS 학번
   , student_name AS 학생이름
   , student_address AS 주소 
FROM 
    tb_student
    ;


-- 11. 국어국문학과 학생들의 정보만이 포함되어 있는 학과정보 테이블을 만들고자 한다. 
-- 아래의 요구사항을 참고하여 작성하시오.
SAVEPOINT S1;

CREATE TABLE tb_국어국문학과
AS
SELECT 
     student_no AS 학번
   , student_name AS 학생이름
   , CASE 
        WHEN SUBSTRING(student_ssn,1,2) LIKE '9%' THEN CONCAT('19', SUBSTRING(student_ssn,1,2))
        WHEN SUBSTRING(student_ssn,1,2) LIKE '0%' THEN CONCAT('20', SUBSTRING(student_ssn,1,2))
     END
   AS 출생년도
   , PROFESSOR_NAME AS 교수이름
FROM 
    tb_student S
    JOIN tb_professor ON COACH_PROFESSOR_NO = PROFESSOR_NO
WHERE
    S.DEPARTMENT_NO = (SELECT D.DEPARTMENT_NO
                       FROM tb_department D
                     WHERE 
                        DEPARTMENT_NAME = '국어국문학과')
    ;
    
    


