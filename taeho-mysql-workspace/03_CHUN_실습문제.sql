use chundb;

-- 1. 학생이름과 주소지를 표시하시오. 단, 출력 헤더는 "학생 이름", "주소지"로 하고, 정렬은 이름으로 오름차순 표시하도록 한다.
select * from tb_class;
select * from tb_class_professor;
select * from tb_department;
select * from tb_grade;
select * from tb_professor;
select * from tb_student;

SELECT
student_name AS '학생 이름'
,student_address AS '주소지'
FROM tb_student
ORDER BY student_name;

-- 2. 휴학중인 학생들의 이름과 주민번호를 나이가 적은 순서로 화면에 출력하시오.
SELECT
student_name
, student_ssn
FROM tb_student
WHERE absence_yn = 'Y'
ORDER BY STR_TO_DATE(
                    CONCAT( 
                    IF(SUBSTRING(student_ssn, 8, 1) IN ('1', '2'), '19', '20'),
                    SUBSTRING(student_ssn, 1, 6)), '%Y%m%d') 
DESC;

-- 3. 주소지가 강원도나 경기도인 학생들 중 2020년대 학번을 가진 학생들의 
--    이름과 학번, 주소를 이름의 오름차순으로 화면에 출력하시오. 
--    단, 출력헤더에는 "학생이름","학번", "거주지 주소" 가 출력되도록 한다.
SELECT
 student_name AS '학생이름'
 , student_no AS '학번'
 , student_address AS '거주지 주소'
FROM tb_student
WHERE (student_address LIKE '강원%' OR student_address LIKE '경기%')
AND SUBSTRING_INDEX(entrance_date,'-',1) >= 2020
ORDER BY student_name;

-- 4. 현재 법학과 교수 중 가장 나이가 많은 사람부터 이름을 확인할 수 있는 SQL 문장을 작성하시오.
-- (법학과의 '학과 코드'는 학과 테이블을 조회해서 찾아 내도록 하자)
SELECT 
p.professor_name
, p.professor_ssn FROM tb_professor p
JOIN tb_department d ON p.department_no = d.department_no
WHERE p.department_no = '005'
ORDER BY p.professor_ssn;

-- 5. 2022년 2학기에 'C3118100' 과목을 수강한 학생들의 학점을 조회하려고 한다. 
--    학점이 높은 학생부터 표시하고, 학점이 같으면 학번이 낮은 학생부터 표시하는 구문을 작성해보시오.
select * from tb_class;
select * from tb_class_professor;
select * from tb_department;
select * from tb_grade;
select * from tb_professor;
select * from tb_student;

SELECT
student_no
, `point`
FROM tb_grade
WHERE term_no = 202202
AND class_no = 'C3118100'
ORDER BY `point` DESC;


select * from tb_student;
select * from tb_department;
-- 6. 학생 번호, 학생 이름, 학과 이름을 학생 이름으로 오름차순 정렬하여 출력하는 SQL 문을 작성하시오.
SELECT 
s.student_no
, s.student_name
, d.department_name
FROM tb_student s
JOIN tb_department d ON s.department_no = d.department_no
ORDER BY s.student_name;

-- 7. 춘 기술대학교의 과목 이름과 과목의 학과 이름을 출력하는 SQL 문장을 작성하시오.
select * from tb_class;

SELECT
c.class_name
, d.department_name
FROM tb_class c
JOIN tb_department d ON c.department_no = d.department_no
ORDER BY d.department_name;

-- 8. 과목별 교수 이름을 찾으려고 한다. 과목 이름과 교수 이름을 출력하는 SQL 문을 작성하시오.
select * from tb_class_professor;
select * from tb_professor;
select * from tb_class;

SELECT 
c.class_name
, p.professor_name
FROM tb_professor p
JOIN tb_class_professor cp ON cp.professor_no = p.professor_no
JOIN tb_class c ON c.class_no = cp.class_no
ORDER BY professor_name;

-- 9. 8 번의 결과 중 ‘인문사회’ 계열에 속한 과목의 교수 이름을 찾으려고 한다. 
--    이에 해당하는 과목 이름과 교수 이름을 출력하는 SQL 문을 작성하시오.
SELECT 
c.class_name
, p.professor_name
FROM tb_professor p
JOIN tb_class_professor cp ON cp.professor_no = p.professor_no
JOIN tb_class c ON c.class_no = cp.class_no
WHERE p.department_no BETWEEN 001 AND 021
ORDER BY professor_name;

-- 10. ‘음악학과’ 학생들의 평점을 구하려고 한다. 음악학과 학생들의 "학번", "학생 이름", "전체 평점"을 출력하는 SQL 문장을 작성하시오. 
--     (단, 평점은 소수점 1 자리까지만 반올림하여 표시한다.)
select * from tb_student;
select * from tb_class;
select * from tb_department;
select * from tb_grade;

SELECT
s.student_no AS '학번'
, s.student_name AS '학생 이름'
, ROUND(AVG(g.point),1) AS '학점'
FROM tb_student s
JOIN tb_department d ON s.department_no = d.department_no
JOIN tb_grade g ON s.student_no = g.student_no
WHERE d.department_name = '음악학과'
GROUP BY g.student_no
ORDER BY 학점 DESC;

-- 11. 학번이 `A313047` 인 학생이 학교에 나오고 있지 않다. 
--     지도 교수에게 내용을 전달하기 위한 학과 이름, 학생 이름과 지도 교수 이름이 필요하다. 
--     이때 사용할 SQL 문을 작성하시오. 
--     단, 출력헤더는 ‚’학과이름‛, ‚학생이름‛, ‚지도교수이름‛으로 출력되도록 한다.

select * from tb_student where student_no = 'A313047';
select * from tb_professor where professor_no = 'P034';
select * from tb_department;

SELECT
d.department_name AS '학과이름'
, s.student_name AS '학생이름'
, p.professor_name AS '지도교수이름'
FROM tb_student s
JOIN tb_department d ON s.department_no = d.department_no
JOIN tb_professor p ON s.coach_professor_no = p.professor_no
WHERE student_no = 'A313047';

-- 12. 2022년도에 '인간관계론' 과목을 수강한 학생을 찾아 학생이름과 수강학기를 표시하는 SQL 문장을 작성하시오
select * from tb_grade;
select * from tb_class where class_name = '인간관계론';
select * from tb_student where student_name = '최지현';
select * from tb_student where student_name = '정상욱';


SELECT 
s.student_name AS '학생이름',
g.term_no AS '수강학기'
FROM tb_student s
JOIN tb_grade g ON s.student_no = g.student_no
JOIN tb_class c ON g.class_no = c.class_no
WHERE g.term_no BETWEEN 202201 AND 202203
AND c.cltb_classass_name = '인간관계론';

-- 13. 예체능 계열 과목 중 과목 담당교수를 한명도 배정받지 못한 과목을 찾아 그 과목 이름과 학과 이름을 출력하는 SQL 문장을 작성하시오.
SELECT 
c.class_name AS '과목 이름'
,d.department_name AS '학과 이름'
FROM tb_class c
JOIN tb_department d ON c.department_no = d.department_no
LEFT JOIN tb_class_professor cp ON c.class_no = cp.class_no
WHERE d.category = '예체능'
AND cp.professor_no IS NULL;

-- 14. 춘 기술대학교 서반아어학과 학생들의 지도교수를 게시하고자 한다. 
--     학생이름과 지도교수 이름을 찾고 만일 지도 교수가 없는 학생일 경우 "지도교수 미지정”으로 표시하도록 하는 SQL 문을 작성하시오.
--     단, 출력헤더는 “학생이름”, “지도교수”로 표시하며 고학번 학생이 먼저 표시되도록 한다.
select * from tb_student;
select * from tb_department;

SELECT 
s.student_name AS '학생이름'
, IFNULL(p.professor_name, '지도교수 미지정') AS '지도교수'
FROM tb_student s
JOIN tb_department d ON s.department_no = d.department_no
LEFT JOIN tb_professor p ON s.coach_professor_no = p.professor_no
WHERE d.department_name = '서반아어학과'
ORDER BY s.student_no ASC;


-- 15. 휴학생이 아닌 학생 중 평점이 4.0 이상인 학생을 찾아 그 학생의 학번, 이름, 학과 이름, 평점을 출력하는 SQL 문을 작성하시오.
--     평점순으로 내림차순 정렬하여 조회하시오.
SELECT 
s.student_no AS '학번'
, s.student_name AS '이름'
, d.department_name AS '학과 이름'
, ROUND(AVG(g.point),2) AS '평점'
FROM tb_student s
JOIN tb_department d ON s.department_no = d.department_no
JOIN tb_grade g ON s.student_no = g.student_no
WHERE s.absence_yn = 'N'
GROUP BY s.student_no, s.student_name, d.department_name
HAVING AVG(g.point) >= 4.0
ORDER BY AVG(g.point) DESC;


-- 16. 환경조경학과 전공과목들의 과목 별 평점을 파악할 수 있는 SQL 문을 작성하시오.
select * from tb_class;
select * from tb_class where department_no = 034;
select * from tb_department where department_name = '환경조경학과';
select * from tb_student;
select * from tb_student where department_no = 034;
select * from tb_grade;

SELECT 
    c.class_no
    ,c.class_name
    , AVG(g.point) AS '평점'
FROM tb_class c
JOIN tb_grade g ON c.class_no = g.class_no
WHERE c.department_no = '034'
AND c.class_type IN ('전공필수', '전공선택')
GROUP BY c.class_no, c.class_name
ORDER BY c.class_no ASC;

-- 17. 춘 기술대학교에 다니고 있는 최경희 학생과 같은과 학생들의 이름과 주소를 출력하는 SQL 문을 작성하시오. (이름 오름차순)
SELECT 
student_name
, student_address
FROM tb_student
WHERE department_no = '038'
-- AND student_name != '최경희';
ORDER BY student_name;

-- 18. 국어국문학과에서 총 평점이 가장 높은 학생의 이름과 학번을 표시하는 SQL 문을 작성하시오.
select * from tb_department;
select * from tb_student where department_no = 001;
select * from tb_grade;

SELECT
s.student_no
, s.student_name
-- , AVG(g.point)
FROM tb_student s
LEFT JOIN tb_grade g ON g.student_no = s.student_no
WHERE s.department_no = '001'
GROUP BY s.student_no
ORDER BY AVG(g.point) DESC
LIMIT 1;

-- 19. 춘 기술대학교의 "환경조경학과"가 속한 같은 계열 학과들의 학과 별 전공과목 평점을 파악하기 위한 적절한 SQL 문을 찾아내시오.
--     단, 출력헤더는 "계열 학과명", "전공평점"으로 표시되도록 하고, 평점은 소수점 한 자리까지만 반올림하여 표시되도록 한다.
select * from tb_department where department_name = '환경조경학과';
select * from tb_class;
select * from tb_grade;

SELECT
     d.department_name AS '계열 학과명'
 , ROUND(AVG(g.point), 1) AS '전공평점'
FROM tb_department d
JOIN tb_class c ON c.department_no = d.department_no
JOIN tb_grade g ON g.class_no = c.class_no
WHERE d.category = '자연과학'
AND c. department_no between 022 AND 041
AND c.class_type IN('전공필수', '전공선택')
GROUP BY d.department_no
ORDER BY d.department_name ASC;

use chundb;