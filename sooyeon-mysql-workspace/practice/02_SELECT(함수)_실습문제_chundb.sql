/* ## SELECT(함수) 실습문제 - chundb ## */
use chundb;

-- 1. "국어국문학과" 에 다니는 여학생 중 현재 휴학중인 여학생을 찾아달라는 요청이 들어왔다. 
--    누구인가? (국문학과의 '학과코드'는 학과 테이블(tb_department)을 조회해서 찾아 내도록 하자)
/*
    student_name
    --------------
    한수현
    --------------
    
    1개의 행 조회
*/
SELECT
    STUDENT_NAME
FROM
    tb_student s
    JOIN tb_department d ON d.DEPARTMENT_NO = s.DEPARTMENT_NO
WHERE
    d.DEPARTMENT_NAME = '국어국문학과'
AND ABSENCE_YN = 'Y'
AND SUBSTRING(STUDENT_SSN,8,1) IN (2,4)
;
    


-- 2. 영어영문학과(학과코드 '002') 학생들의 학번과 이름, 입학년도를 입학년도가 빠른순으로 표시하는 SQL 문장을 작성하시오.
--    (단, 헤더는 "학번", "이름", "입학년도" 가 표시되도록 한다.)
/*
    학번      | 이름    | 입학년도
    ------------------------------------
    A9973003  | 김용근	| 2016-03-01
    A473015	  | 배용원	| 2021-03-01
    A517105	  | 이신열	| 2022-03-01
    ------------------------------------
    
    3개의 행 조회
*/
SELECT
    STUDENT_NAME
    ,STUDENT_NO
    ,DATE_FORMAT(ENTRANCE_DATE,"%Y-%m-%d")
FROM
    tb_student
WHERE
    DEPARTMENT_NO = '002'
ORDER BY
    ENTRANCE_DATE
;


-- 3. 춘 기술대학교의 교수 중 이름이 세 글자가 아닌 교수가 한 명 있다고 한다.
--    그 교수의 이름과 주민번호를 화면에 출력하는 sql 문장을 작성해 보자.
/*
    professor_name  | professor_ssn
    ---------------------------------
    강혁	        | 601004-1100528
    박강아름	    | 681201-2134896
    ---------------------------------
    
    2개의 행 조회
*/
SELECT
    PROFESSOR_NAME
    ,PROFESSOR_SSN
FROM
    tb_professor
WHERE
    CHAR_LENGTH(PROFESSOR_NAME) != 3;
;


    
-- 4. 교수들의 이름 중 성을 제외한 이름만 출력하는 sql 문장을 작성하시오. 
--    단, 출력 헤더는’이름’ 이 찍히도록 한다. (성이 2 자인 경우는 교수는 없다고 가정하시오)
/*
    이름
    ------
    진영
    윤필
    원하
    옥현
    경숙
    영주
    수현
    ...
    민정
    해원
    혁호
    ------
    
    114개의 행 조회
*/
SELECT
    SUBSTRING(PROFESSOR_NAME,2)
FROM
    tb_professor
WHERE
    CHAR_LENGTH(PROFESSOR_NAME) >= 3
;


-- 5. 학번이 A517178 인 한아름 학생의 학점 총 평점을 구하는 sql 문을 작성하시오.
--    단, 이때 출력 화면의 헤더는 "평점" 이라고 찍히게 하고, 점수는 반올림하여 소수점 이하 한자리까지만 표시한다.
/*
    평점
    -----
    3.6
    -----
*/
SELECT * FROM tb_grade;
SELECT
    FORMAT(AVG(POINT),1)
FROM
    tb_grade
WHERE
    STUDENT_NO = 'A517178'
;
    

    
-- 6. 지도 교수를 배정받지 못한 학생의 수는 몇 명 정도 되는지 알아내는 sql 문을 작성하시오.
/*
    COUNT(*)
    ---------
    9
    ---------
*/
SELECT
    COUNT(*)
FROM
    tb_student
WHERE
    COACH_PROFESSOR_NO IS NULL
;

    
-- 7. 학과별 학생수를 구하여 "학과번호", "학생수(명)" 의 형태로 헤더를 만들어 결과값이 출력되도록 하시오.
/*
    학과번호 | 학생수(명)
    ----------------------
    001	     | 14
    002	     | 3
    003	     | 8
    004	     | 12
    005	     | 10
    006	     | 5
    007	     | 8
        ...
    060	     | 16
    061	     | 7
    062	     | 8
    -----------------------
    62개의 행 조회
*/
SELECT * FROM tb_class; -- DEPARTMENT_NO
SELECT * FROM tb_department; -- DEPARTMENT_NO
-- COUNT(DEPARTMENT_NO)
SELECT * FROM tb_student; -- DEPARTMENT_NO 를 듣고있는데 휴학이아닌


SELECT
    d.DEPARTMENT_NO
    , COUNT(*)
    ,ABSENCE_YN
FROM
    tb_department d
    JOIN tb_class c ON c.DEPARTMENT_NO = d.DEPARTMENT_NO
    JOIN tb_student s ON s.DEPARTMENT_NO = c.DEPARTMENT_NO
WHERE
    s.ABSENCE_YN = 'Y'
GROUP BY
    d.DEPARTMENT_NO
;
    

-- 8. 학과 별 휴학생 수를 파악하고자 한다. 학과 번호와 휴학생 수를 표시하는 sql 문장을 작성하시오.
/*
    학과코드명 | 휴학생 수
    ------------------------
    001	       | 2
    002	       | 0
    003	       | 1
    004	       | 1
    005	       | 0
    006	       | 3
    007	       | 1
    008	       | 2
    009	       | 2
        ...
    060	       | 1
    061	       | 2
    062	       | 2    
    ------------------------
    
    62개의 행 조회
*/
SELECT
    DEPARTMENT_NO
                                        #    , COUNT(ABSENCE_YN) # 모두가 결석일 경우는 출력되지 않음
    ,  COALESCE(SUM(CASE WHEN ABSENCE_YN = 'Y' THEN 1 ELSE 0 END), 0) #만약에 Y일경우 1을 더하고 아니면 0을더함 근데 NULL이면 그냥 0
FROM 
    tb_student
GROUP BY
    DEPARTMENT_NO
;


    
-- 9. 춘 대학교에 다니는 동명이인(同名異人) 학생들의 이름을 찾고자 한다. 어떤 sql 문장을 사용하면 가능하겠는가?
/*
    동일이름 | 동명인 수
    --------------------
    김경민	 | 2
    김명철	 | 2
    김명훈	 | 2
    김보람	 | 3
    김윤정	 | 2
        ...
    이현성	 | 2
    조기현	 | 2
    최효정	 | 2
    --------------------
    
    20개의 행 조회
*/
SELECT                                  # 4
    STUDENT_NAME
    , COUNT(*) "동명인 수"
FROM                                    # 1
    tb_student
GROUP BY                                # 2
    STUDENT_NAME
HAVING                                  # 3
    COUNT(*) >= 2 # HAVING은 별칭에서 안됨
ORDER BY                                # 4            
    STUDENT_NAME
;
# tb_student에서 GROUP by로 묶은 다음HAVING으로 거르고SELECT에서 출렧하는데 ORDER순서로


-- 10. 학번이 A112113 인 김고운 학생의 년도 별 평점을 구하는 sql 문을 작성하시오. 
--    단, 이때 출력 화면의 헤더는 "년도", "년도 별 평점" 이라고 찍히게 하고, 점수는 반올림하여 소수점 이하 한자리까지만 표시한다.
/*
    년도  | 년도 별 평점
    --------------------
    2018  |	2.8
    2019  |	2.3
    2020  |	4.0
    2021  |	3.5
    --------------------
*/
SELECT * FROM tb_grade;

SELECT                          # 4. 년도 출력, 점수의 평균값
    LEFT(TERM_NO, 4) AS "년도"
  , FORMAT(AVG(POINT), 1) AS "년도 별 평점" 
FROM                            # 1. tb_grade를 사용함
    tb_grade
WHERE                           # 2. STUDENT_NO이 'A112113'인 행을 앚음
    STUDENT_NO = 'A112113'
AND STUDENT_NO = (SELECT STUDENT_NO FROM tb_student WHERE STUDENT_NAME = '김고운') -- 없어도되긴함
GROUP BY 
    LEFT(TERM_NO, 4) # 3. 찾은 행의 년도를 기준으로 묶어 그룹핑함
ORDER BY
    "년도"                  
;





    
-- 11. 학번이 A112113 인 김고운 학생의 년도, 학기 별 평점과 년도 별 누적 평점 , 총평점을 구하는 sql 문을 작성하시오.
--     (단, 평점은 소수점 1 자리까지만 반올림하여 표시한다.) - Hint. ROLLUP
/*
    년도  | 학기 | 평점
    --------------------
    2018  | 01   | 2.5
    2018  | 02   | 3.0
    2018  |      | 2.8
    2019  | 01   | 2.0
    2019  | 02   | 2.5
    2019  |      | 2.3
    2020  | 01   | 3.5
    2020  | 02   | 4.5
    2020  | 03   | 4.0
    2020  |      | 4.0
    2021  | 01   | 4.0
    2021  | 02   | 3.0
    2021  |      | 3.5
          |      | 3.2  
    --------------------

    14개의 행 조회
*/
SELECT
    LEFT(TERM_NO, 4) AS 년도
     ,RIGHT(TERM_NO, 2) AS 학기 # 데이터 분석 용도로 사용할 경우는 NULL출력이 더 선호됨
--    , COALESCE(ANY_VALUE(RIGHT(TERM_NO, 2)),"") AS 학기 # 가독성이 중요할 경우 null을 다른 값으로 변경해서 출력
    , AVG(POINT)                    # 집계함수를 사용하기 위해서는 GROUP BY를 사용해야함
FROM 
    tb_grade
WHERE
    STUDENT_NO = 'A112113' 
GROUP BY 
    LEFT(TERM_NO, 4), RIGHT(TERM_NO, 2)
WITH ROLLUP
;
    
