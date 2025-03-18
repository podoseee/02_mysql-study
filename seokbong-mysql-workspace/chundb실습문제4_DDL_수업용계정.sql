/* ## DDL, DML 실습문제 - chundb ## */
use chundb;

-- 1. 계열 정보를 저장할 테이블을 생성하려고 한다. 아래의 요구사항을 참고하여 작성하시오.
/*
   *  요구사항
   1) 테이블명 : tb_category
   2) 컬럼
      ㄴ name, VARCHAR(10) 
      ㄴ user_yn, CHAR(1), 기본값'Y'
*/
CREATE TABLE tb_category(
    name VARCHAR(10),
    user_yn CHAR(1) DEFAULT 'Y'
);



-- 2. 과목 구분을 저장할 테이블을 만들려고 한다. 아래의 요구사항을 참고하여 작성하시오.
/*
   *  요구사항
   1) 테이블명 : tb_class_type
   2) 컬럼
      ㄴ no, VARCHAR(5), 기본키
      ㄴ name, VARCHAR(10)
*/
CREATE TABLE tb_class_type(
    no VARCHAR(5) PRIMARY KEY,
    name VARCHAR(10)
);
DESC tb_class_type;

-- 3. tb_category 테이블의 name 컬럼에 기본키 제약조건을 부여하시오. 
ALTER TABLE tb_category
    ADD PRIMARY KEY(name);
DESC tb_category;


-- 4. tb_class_type 테이블의 name 컬럼에 NULL이 허용되지 않도록 하시오.
ALTER TABLE tb_class_type
    MODIFY name VARCHAR(10) NOT NULL;
DESC tb_class_type;


-- 5.  tb_category, tb_class_type 테이블에 name 컬럼을 기존 타입은 유지하면서 
--     허용 가능 바이트사이즈를 20으로 변경하시오.
--     tb_class_type 테이블에 no 컬럼은 기존 타입은 유지하면서 크기는 10으로 변경하시오.
ALTER TABLE tb_category MODIFY name VARCHAR(20);
ALTER TABLE tb_class_type MODIFY name VARCHAR(20);
ALTER TABLE tb_class_type MODIFY no VARCHAR(10);


-- 6. tb_category, tb_class_type 테이블에 존재하는 no 컬럼과 name 컬럼의 컬럼명을 각 테이블 이름을 붙인 형태로 변경하시오. 
--    ex) category_name
ALTER TABLE tb_category
    RENAME COLUMN name TO category_name;
ALTER TABLE tb_class_type
    RENAME COLUMN name TO class_type_name,
    RENAME COLUMN no TO class_type_no;



-- 7. 아래의 데이터를 참고하여 tb_category 테이블에 데이터를 추가하시오. (정상수행시 트랜잭션 완료처리)
/*
   category_name | user_yn 
   ========================
   공학          | Y
   자연과학      | Y
   의학          | Y
   예체능        | Y
   인문사회      | Y
   ------------------------
*/
INSERT INTO 
    tb_category(category_name)
VALUES
    ('공학'),
    ('자연과학'),
    ('의학'),
    ('예체능'),
    ('인문사회');

SELECT * FROM tb_category;
    



-- 8. tb_department의 category 컬럼이 tb_category 테이블의 category_name 컬럼을 부모값으로 참조하도록 FOREIGN KEY 제약조건을 부여하시오. 
--    이때 제약조건명은 "fk_테이블명_컬럼명" 으로 지정하시오.  
ALTER TABLE tb_department
ADD CONSTRAINT fk_tb_department_category
FOREIGN KEY (category) REFERENCES tb_category(category_name);

DESC tb_department;

-- 9. 아래의 데이터를 참고하여 tb_class_type 테이블에 데이터를 추가하시오. (정상수행시 트랜잭션 완료처리)
/*
   class_type_no | class_type_name
   ================================
   01            | 전공필수
   02            | 전공선택
   03            | 교양필수
   04            | 교양선택
   05            | 논문지도
   --------------------------------
*/

INSERT INTO 
    tb_class_type
VALUES
    (1, '전공필수'),
    (2, '전공선택'),
    (3, '교양필수'),
    (4, '교양선택'),
    (5, '논문지도');
 SELECT * FROM tb_class_type;

-- 10. 춘 기술대학교 학생들의 정보가 포함되어 있는 학생일반정보테이블을 생성하고자 한다. 아래의 요구사항을 참고하여 작성하시오.
/*
    *  요구사항 
    1) 테이블명 : tb_학생일반정보
    2) 컬럼
       ㄴ 학번, tb_student 테이블의 student_no 타입 참조
       ㄴ 학생이름, tb_student 테이블의 student_name 타입 참조
       ㄴ 주소, tb_student 테이블의 student_address 타입 참조 
    3) 데이터
       tb_student 테이블에 존재하는 학번, 학생이름, 주소 데이터가 INSERT 될 수 있도록
 
    HINT. 테이블 생성시 서브쿼리를 활용해보세요.
*/
CREATE TABLE tb_학생일반정보
AS
SELECT student_no, student_name, student_address
FROM tb_student;

DESC tb_학생일반정보;
SELECT * FROM tb_학생일반정보;



      
-- 11. 국어국문학과 학생들의 정보만이 포함되어 있는 학과정보 테이블을 만들고자 한다. 아래의 요구사항을 참고하여 작성하시오.
/*
    *  요구사항
    1) 테이블명 : tb_국어국문학과
    2) 컬럼
       ㄴ 학번, tb_student 테이블의 student_no 타입 참조
       ㄴ 학생이름, tb_student 테이블의 student_name 타입 참조
       ㄴ 출생년도, tb_student 테이블의 student_ssn을 통해 년도 만을 추출한 값의 타입 참조
       ㄴ 교수이름, tb_professor 테이블의 professor_name 타입 참조
    3) 데이터
       국어 국문학과 학생들의 
       tb_student, tb_professor 테이블에 존재하는 학번, 학생이름, 출생년도(4자리리), 교수이름 데이터가 INSERT 될 수 있도록
   
     HINT. 테이블 생성시 서브쿼리를 활용해보세요.
*/
DROP TABLE tb_국어국문학과;
CREATE TABLE tb_국어국문학과
AS
SELECT 
    student_no
  , student_name
  , CASE WHEN SUBSTRING(student_ssn,1,1) = 0  THEN  CONCAT(20,SUBSTRING(student_ssn,1,2) )
         ELSE CONCAT(19,SUBSTRING(student_ssn,1,2) )
         END AS 출생년도
  , professor_name
FROM 
    tb_student s
        JOIN tb_department d ON d.department_no = s.department_no
        JOIN tb_professor p ON p.department_no = d.department_no
WHERE
    department_name = '국어국문학과';
    
SELECT * FROM tb_국어국문학과; 


    
-- 12. 현 학과들의 정원을 10% 증가시키게 되었다. 이에 사용할 SQL문을 작성하시오. 
--     단, 반올림을 사용하여 소수점 자릿수는 생기지 않도록 한다. 
UPDATE 
    tb_department
SET 
    capacity = ROUND(capacity * 1.1,0);
SELECT * FROM tb_department;


   
-- 13. 학번 A413042 인 박건우 학생의 주소가 "서울시 종로구 숭인동 181-21"로 변경되었다고 한다.
--     주소지를 정정하기 위해 사용할 SQL문을 작성하시오.
UPDATE 
    tb_student
SET 
    student_address = '서울시 종로구 숭인동 181-21'
WHERE
    student_no = 'A413042';



-- 14. 주민등록번호 보호법에 따라 학생정보 테이블에서 주민번호 뒷자리를 저장하지 않기로 결정하였다. 
--     이 내용을 반영할 적절한 SQL문을 작성하시오.
UPDATE  
    tb_student
SET
    student_ssn = SUBSTRING(student_ssn , 1, 6);



   
-- 15. 의학과 김명훈 학생은 2022년 1학기에 자신이 수강한 "피부생리학" 점수가 잘못되었다는 것을 발견하고는 정정요청하였다.
--     담당 교수의 확인 결과 해당 과목의 학점을 3.5로 변경하기로 결정되었다. 이 내용을 반영할 적절한 SQL문을 작성하시오.
ROLLBACK;
 
UPDATE
    tb_grade
SET
    point = 3.5
WHERE
    STUDENT_NO = (SELECT student_no
                    FROM tb_student
                   WHERE student_name = '김명훈'
                   AND department_no = (SELECT department_no
                                          FROM tb_department
                                         WHERE department_name = '의학과' 
                                        )
                 )
AND class_no = (SELECT class_no
                  FROM tb_class
                 WHERE class_name = '피부생리학');


        
                
-- 16. 성적 테이블에서 휴학생들의 성적 항목을 제거하시오.
DELETE
FROM
    tb_grade
WHERE
    student_no IN (SELECT student_no
                    FROM tb_student
                    WHERE ABSENCE_YN = 'Y');



-- 17. 위의 변경 또는 삭제된 내용들을 확정짓기 위한 커밋을 진행하시오.
COMMIT;