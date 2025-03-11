/* ## SELECT(Basic) 실습문제 - chundb ## */
use chundb;

-- 아래의 select문들을 실행하여 각 테이블에 어떤 컬럼과 어떤 데이터가 담겨있는지 파악하고 진행하시오.
SELECT * FROM tb_department;      -- 학과
SELECT * FROM tb_student;         -- 학생
SELECT * FROM tb_professor;       -- 교수
SELECT * FROM tb_class;           -- 과목
SELECT * FROM tb_class_professor; -- 과목별교수 
SELECT * FROM tb_grade;           -- 성적

-- 1. 춘 기술대학교의 학과 이름과 계열을 표시하시오. 단, 출력 헤더는 "학과 명", "계열"으로 표시하도록 한다.
SELECT 
    DEPARTMENT_NAME '학과 명'
  , CATEGORY 계열
FROM 
    tb_department;

-- 2. 학생이름과 주소지를 표시하시오. 단, 출력 헤더는 "학생 이름", "주소지"로 하고, 
--    정렬은 이름으로 오름차순 표시하도록 한다.

SELECT
    STUDENT_NAME AS "학생 이름"
  , STUDENT_ADDRESS AS 주소지
FROM tb_student
ORDER BY STUDENT_NAME;

-- 3. 학과의 학과 정원을 다음과 같은 형태로 화면에 출력한다.

