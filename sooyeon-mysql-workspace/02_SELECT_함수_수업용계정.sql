/*
    ## BUILT IN FUNCTION
    1. 내장 함수
    2. 전달된 가뵤들을 읽어들여 특정 작업 수행 수 결과값을 반환하는 함수
    
    호출(값 전달) -> 작업 수행 -> 결과값 반환
    
    - 단일행함수 : 각 행마다 반복적으로 작업을 수행하여 결과를 반환,N개의 값을 읽어들여 N개의 결과 반환
        1. 문자처리함수
        2. 숫자처리함수
        3. 날짜/시간 처리함수
        4. 기타함수
    - 그룹함수 : 여러행들이 그룹으로 형성되어 적용됨, 그룹당 1개의 결과 반환, N개의 가뵤을 읽어들여 1개의 결과 반환
*/

-- =============================================================================
-- 단일행함수, 문자처리함수

/*
    ## ASCII, CHAR
    1. ASCII(문자) : 해당 문자의 아스키 코드값을 반환
    2. CHAR(숫자) : 해당 아스키 코드 숫자의 문자값을 반환
*/

SELECT ASCII('A'), CHAR(65)

/*
    ## LENGTH, BIT_LENGTH, CHAR_LENGTH
    1. LENGTH(문자열) : 해당 문자열의 할당된 바이트크기 반환 - 길이 아님
    2. BIT_LENGTH(문자열) : 해당 문자열의 할당된 비트 크기 반환 (LENGTH 결과*8)
    3. CHAR_LENGTH(문자열) : 해당 문자열의 글자수 길이를 반환
    
    * utf8mb4 문자셋 기준
    - 한글 한글자당 - 3Byte (24Bit)
    - 그외 한글자단 - 1Byte (8Byte)
*/

SHOW VARIABLES LIKE 'character_set_database'; -- 데이터베이스의 문자셋 홧인

SELECT LENGTH('pie'), BIT_LENGTH('pie'),CHAR_LENGTH('pie');
SELECT LENGTH('파이'), BIT_LENGTH('파이'),CHAR_LENGTH('파이');

SELECT
    menu_name
    , CHAR_LENGTH(menu_name)
FROM
    tbl_menu
WHERE
    CHAR_LENGTH(menu_name) = 5 -- 메뉴명이 5개인 것만
;

/*
    ## CONCAT, CONCAT_WS
    1. CONCAT(문자열1, 문자열2, ...) : 해당 문자열들을 다 이어붙인 결과 반환
    2. CONCAT_WS(구분자, 문자열1, 문자열2, ...) : 구분자를 기준으로 이어 붙임
*/

SELECT 
    CONCAT('123','abc')
    ,CONCAT_WS(',','123','abc','456');

SELECT
    CONCAT_WS('-','2024','02','28');
    
    
/*
    ## ELT, FIELD, FIND_IN_SET
    - ELT(찾을위치, 문자열1, 문자열2, ...) : 나열된 문자열들 중 해당 위치의 문자열을 반환, 해당 위치에 문자열이 없으면 null반환
    - FIELD(찾을문자열, 문자열1, 문자열2, ...) : 나열된 문자열 중 해당 문자열의 위치를 반환, 해당 위치에 문자열이 없으면 0을 반환
    - FIND_IN_SET(찾을문자열, 문자열리스트) : 문자열리스트 중 해당 문자열의 위치를 반환, 없으면 0을 반환
                                    ㄴ 단, 문자열리스트는 반드시 콤마(,)로 나열된 문자열이여야함
*/

SELECT
    ELT(2,'사과','딸기','바나나')
    ,FIELD('바나나','딸기','바나나')
    ,FIND_IN_SET('사과','사과,딸기,바나나')
;


SELECT
    *
FROM
    tbl_menu
ORDER BY
    FIND_IN_SET(menu_code,'15,12') DESC -- menu_code값이 15일 경우 1, 12일 경우 2, 나머지는 0
--    FIELD(orderable_status, 'N','Y')
;

/*
    ## INSTR, LOCATE
    1. INSTR(기준문자열, 부분문자열) : 기준문자열에 해당 부분 문자열의 시작 위치를 찾아 반환 - 없으면 0 반환
    2. LOCATE(부분문자열, 기준문자열) : 기준문자열에 해당 부분무자열의 시작 위치를 찾아 반환 - 없으면 0 반환
*/

SELECT
    INSTR('사과딸기바나나','딸기')
    , LOCATE('딸기','사과딸기바나나')
;

/*
    ## FORMAT
    - FORMAT(숫자, 소수점자리수) : 1000단위마다 콤마 표시를 해주며 소수점 아래 자리수까지 표현
*/

SELECT
    FORMAT(123435345145.45255234234234,2); -- 123,435,345,145.45
    
SELECT
    menu_name
    , FORMAT(menu_price,0) -- 가격 포매팅 느낌
    ,CONCAT(FORMAT(menu_price,0),'원') -- 10,000원
FROM
    tbl_menu
;

/*
    ## INSERT
    INSERT(기준 문자열, 위치, 길이, 삽입할 문자열) : 기준 문자열의 해당 위치부터 해당 길이만큼을 지우고 삽입할 문자열을 너허 반환
*/

SELECT
    INSERT('내 이름은 아무개입니다.',7,3,'홍길동')
;

SELECT
    INSERT('메뉴 이름은 메뉴명입니다.',8,3,menu_name) -- 8번째 문자부터 **3글자('메뉴명')**를 menu_name 값으로 바꾼다
FROM
    tbl_menu
;

SELECT
    menu_name
    , INSERT(menu_name,INSTR(menu_name,'쥬스'),2,'JUICE')
FROM
    tbl_menu
WHERE
    menu_name LIKE '%쥬스%'
;

/*
    ## REPLACE
    REPLACE(기준문자열, 찾을문자열, 바꿀문자열) : 기준문자열로부터 특정문자열을 찾아 바꿀 문자열로 변경 후 반환
    찾을 문자열이 없으면 그냥 기존 문자열 반환함
*/

SELECT REPLACE('마이sql','마이','MY----');

SELECT
    menu_name
    ,REPLACE(menu_name,'쥬스','juice')
FROM  
    tbl_menu
;

/*
    ## LEFT, RIGHT
    1. LEFT(문자열, 길이) : 해당 문자열의 왼쪾 지점에서부터 해당 길이만큼의 문자열 반환
*/

SELECT
    LEFT('Hello World',4)
    , RIGHT('Hello World', 5);
  
  
/*
    ## UPPER, LOWER
    - UPPER(문자열) : 다 대문자
    - LOWER(문자열) : 다 소문자
*/

SELECT UPPER('Hello world');

/*
    ## LPAD, RPAD
    LPAD|RPAD(기준문자열, 길이, 채울문자열) : 기준문자열을 해당 길이만큼 왼쪽또는 오른쪽으로 늘린 루 빈곳을 채울 문자열로 채워 반환
*/

SELECT
    LPAD('왼쪽',6,'@') -- @@@@왼쪽
    ,RPAD('오른쪽',6,'@') -- 오른쪽@@@
;

SELECT
    RPAD('000506-2',14,'*');

SELECT
    menu_name
    , LPAD(menu_price, 5, ' ')
FROM
    tbl_menu
;

/*
    ## LTRIM, RTRIN, TRIM
    - LTRIM(문자열) : 해당 문자열의 왼쪽 공백 제거
    - RTRIM(문자열) :  ""           오른쪽
    - TRIM(문자열) :  ""             양쪽
    - TRIM(위에3개중하나 제거할문자 FROM 문자열) : 해당 문자열의 지정한 방향에 특정 문자열을 찾아 제거 후 반환
*/

SELECT
    LTRIM('  왼쪽')
    ,RTRIM('오른쪽    ')
    ,TRIM('     양쪽    ')
;

SELECT
    TRIM('@' FROM '@@@~~~@@@') -- ~~~
    ,TRIM(BOTH '@' FROM '@@@~~~@@@') -- ~~~
    ,TRIM(LEADING'@' FROM '@@@~~~@@@') -- ~~~@@@
    ,TRIM(TRAILING '@' FROM '@@@~~~@@@') -- @@@~~~
;

/*
    ## REPEAT
    REPEAT(문자열, 횟수) : 문자열을 횟수만큼 반복해 만들어 반환
*/

SELECT REPEAT('재미업다',5);

/*
    ## SPACE
    SPACE(길이) : 해당 길이만큼의 공백문자열을 반환
*/

SELECT CONCAT('이름 : ',SPACE(3));


/*
    ## REVERSE
    문자열의 순서를 거꾸로 뒤집어 반환
*/
SELECT REVERSE('abcde');

/*
    ## SUBSTRING, SUBSTRING_INDEX
    1. SUBSTRING(문자열, 시작위치[,길이]) : 해당 문자열의 시작 위치에서부터 해당 길이만큼 반환
    2. SUBSTRING_INDEX(문자열, 구분자, 구분자인덱스) : 해당 문자열의 구분자의 위치까지를 반환
*/

SELECT
    SUBSTRING('안녕하세요반갑습니다',6,5) -- 반갑습니다
    , SUBSTRING('안녕하세요반갑습니다',6)
;

SELECT
    SUBSTRING('0183847-2847592',1,8)
    , RPAD(SUBSTRING('0183847-2847592',1,8),14, '*') -- 민증 뒬자리를 제외한 범위부터 14글자로해서 *으로 변경한다.
;

SELECT
    SUBSTRING_INDEX('sukipi@sotogito.com','@',1) -- 첫번째 @까지의 앞의 문자열을 받겠다.
    , SUBSTRING_INDEX('sukipi.soo.@sotogito.com','.',3) -- sukipi.soo.@sotogito
    , SUBSTRING_INDEX('a.b.c.d.e','.',-2); -- d.e -> 뒤에서부터 점 + 뒤에꺼ANALYZE

-- =============================================================================================================================================================
-- 단일행함수, 숫자처리함수

/*
    ## ABS
    - ABS(숫자) : 해당 숫자의 절대값 반환
*/
SELECT
    ABS(-1)
;

/*
    - CEILING(숫자) : 해당 숫자의 올리값 반환
    - FLOOR(숫자) : 해당 숫자의 내림값(현재보다 작은 최대정수) 반환
    - TRUNCATE(숫자, 자리수) : 해당숫자의 버림값 반환, 소수점이라 자리수는 필수
    - ROUND(숫자[, 자리수]) : 반올림값
*/
SELECT
    CEILING(123.456)
    , FLOOR(123,456)
    , FLOOR(-0.65);
    
SELECT
    TRUNCATE(123.456, 1) -- 123.4
    ,TRUNCATE(123.456, 2) -- 123.45
;

/*
    MOD(숫자1, 숫자2) : 숫자1 % 숫자2
*/

SELECT
    75%10
    , 75 MOD 10
    , MOD(75,10)
;

/*
    - POW(숫자1, 숫자2) : 숫자1을 숫자2 거듭제곱한 결과 반환
    - SQRT(숫자) : 숫자의 제곱근 값 반환
*/
SELECT
    POW(2,10)
    ,SQRT(16);

/*
    RAND() : 0이상 1미만의 실수 난수 반환
*/
SELECT
    RAND()
    ,fLOOR(RAND() * 10 + 1)
;

/*
    SIGN : 해당 숫자가 양수면1, 음수면 -1, 0이면 0
*/
SELECT
    SIGN(10.1) -- 1
    , SIGN(0) -- 0
    , SIGN(-10) -- -1
;


-- ================================= 시간
/*
    NOW, SYSDATE, LOCALTIME LOCALTIMESTAMP
*/

SELECT
    NOW()
    , SYSDATE()
    ,LOCALTIME(), LOCALTIME
    ,LOCALTIMESTAMP(), LOCALTIMESTAMP
;

/*
    CURDATE, CURRENR_DATE
*/

SELECT
    CURDATE()
    ,CURRENR_DATE(), CURRENR_DATE
;

/*
    시:분:초 정보
    CURTIME, CURRENT_TIME
*/
SELECT
    CURTIME()
    ,CURRENT_TIME(), CURRENT_TIME
;

/*
    ## ADDDATE, SUBDATE
    1. ADDDATE(날짜, 더할일수) : 해당 날짜로부터 일수를 더함
    2. SUBDATE(날짜, 뺼날짜) : 해당 날짜로부터 해당 일수만큼 뺀 날짜 반환
    
    일수 대신에 [INTERVAL N 단위]형식으로도 작성 가능
        => 해당 단위의 N날짜만큼 더하거나 뺸 날짜 반환
*/
SELECT
    CURDATE()
    , ADDDATE(CURDATE(),1)
    , SUBDATE(CURDATE(),1)
;

SELECT
    ADDDATE('2024-12-31', INTERVAL 2 DAY) -- 2025-01-02
    , ADDDATE('2024-12-31', INTERVAL 2 MONTH) -- 2025-02-28
    , ADDDATE('2024-12-31', INTERVAL 2 YEAR) -- 2026-12-31
;

/*
    - ADDTIME(날짜 및 시간, 시간) : 해당 날짜 및 시간을 기주능로 특정 시간만큼 더한 시간을 반환ALTER
    - SUBTIME(날짜 및 시간, 시간) :                        ""                   뺀 시간을 반환
*/
SELECT
    ADDTIME('09:00:00',10) # 09:00:10
   , ADDTIME('09:00:00','1:30') # 1시간 30분 더하기 10:30:00
   , ADDTIME('09:00:00','1:10:5')
;
    
/*
    - DATEDIFF(날짜1, 날짜2) : 날짜1 - 날짜2의 일수 반환
    - TIMEDIFF(날짜및시간1, 날짜및시간2) : 뺸 결과
*/

SELECT
    DATEDIFF('2025-07-29',NOW())
    ,TIMEDIFF('17:50:50','14:22:00')
;

/*
    YEAR, MONTH, DAY, HOUR, MINUTE, SECOND, MICROSECOND
    특정 시간 및 날짜 값 추출해서 반환
*/
SELECT
    YEAR(CURDATE())
    , MONTH(CURDATE())
    , day(CURDATE())
;

SELECT
    HOUR(CURTIME())
    ,MINUTE(CURTIME())
    ,SECOND(CURTIME())
    ,MICROSECOND(CURTIME())
;

/*
    - DATE(날짜및시간) : 연-월-일만 추출
    - TIME(날짜및시간) : 시:분:초만 추출
*/
SELECT
    DATE(NOW())
    ,TIME(NOW())
;

/*  
    EXTRACT(UNIT FROM 날짜및 시간) : 날짜 및 시간으로부터 UNIT에 해당하는 값 추출해서 반환
    
    - UNIT 목록
    1. YEAR_MONTH : 연월
    2. YEAR : 연도
    3. MONTH : 월
    4. DAY : 일
    5. DAY_HOUR, HOUR : 시
    7. HOUR_MINUTE : 분
    8. MINUTE : 분
    9. SECOND : 초
    10. MICROSECOND : 마이크로초
*/
SELECT EXTRACT(DAY FROM NOW());

/*
    - DAYOFWEEK(날짜) : 요일 반환(1일요일 ~ 7토요일)
    - DAYOFMONTH(날짜) : 해당 월을 기준으로 몇 일 흘렀는지 반환
    - DAYOFYEAR(날짜) : 해당 년도를 기준으로 몇 일이 흘렀는지 반환
    - MONTHNAME(날짜) : 달의 이름 반환
*/

SELECT
    DAYOFWEEK(CURDATE())
    , DAYOFMONTH(CURDATE())
    , DAYOFYEAR(CURDATE())
    ,MONTHNAME(CURDATE())
;

-- lAST_DAY(날짜) : 해당 달의 마지막 날짜를 구해서 반환
SELECT
    LAST_DAY(CURDATE())
;

-- MAKEDATE(연도, 정수) : 해당 연도의 정수만큼 지난 날짜 구해서 반환
SELECT MAKEDATE(2025,32);

SELECT MAKETIME(14,25,01);

SELECT PERIOD_ADD(202404,5), PERIOD_ADD('202409','202405');

SELECT 
    NOW()
    , DATE_FORMAT(NOW(), '%Y-%M-%D')
    , DATE_FORMAT(NOW(), '%y-%m-%d')
    , DATE_FORMAT(NOW(), '%H-%I:%S')
;

SELECT @@lc_time_names;
SET @@lc_time_names = 'en_US';

-- ===================================================================================================================================
-- 단일행함수 - 형변환함수

/*
    ## CAST, CONVERT
    CAST(값 AS 데이터형식)
    CONVER(값, 데이터형식)
    
    * 주요 데이터 형식
    1) 문자열로 : CHAR
    2) 날짜 및 시간으로 : DATE, TIME, DATETIME
    3) 숫자로 : SIGNED INTEGER, DOUBLE, DECIMAL
*/

-- 자동 형변환 케이스
SELECT '1' + '2';
SELECT CONCAT(menu_price, '원') FROM tbl_menu;
SELECT ADDDATE('2024-06-01', 1);
SELECT 3 > 'MAY';

-- 강제 형변환
SELECT
    AVG(menu_price) # 평균값 계산
    , CAST(AVG(menu_price) AS SIGNED INTEGER) # 평균값 정수형
    , CONVERT(AVG(menu_price), SIGNED INTEGER) AS 평균값 # 평균값 정수형
FROM
    tbl_menu
;


SELECT
    CAST('2024%5%30' AS DATE)
    ,CAST('2024/5/30' AS DATE)
    ,CAST('2024$5$30' AS DATE)
    ,CAST('2024년5월30일' AS DATE); # NULL로 조회
;

/*
    ## NULL 처리 함수
    IFNULL(값, NULL일때 대체값) : 값이 NULL일 경우 대체값 반환, NULL이 아닐경우 기존값 반환
    ISNULL(값) : 값이 NULL일 경우 1TURN 반환
    COALESCE(값1, 값2, ...) : 나열된 값들 중 NULL이 아닌 첫번재 값을 반환
*/
SELECT
    IFNULL(NULL, 'HELLO SOTOGITO')
    , IFNULL('ZZZ','HELLO SUKIPI')
;

SELECT
    category_name
    , IFNULL(ref_category_code,'없음')
FROM
    tbl_category;
SELECT
    ISNULL(NULL)
    ,ISNULL('ZZZ')
;

SELECT
    COALESCE(NULL, NULL, '홍길동', NULL, '김말똥'); # NULL이 아닌 값 발견하면 바로 반환 - 홍길동

-- 삼항연산자

SELECT
    menu_name
    ,IF(orderable_status = 'Y', '주문가능','주문불가능') AS "주문가능여부"
FROM    
    tbl_menu
;

SELECT
    category_name
    ,IF(ISNULL(ref_category_code),'상위 카테고리','하위 카테고리') AS "분류"
FROM
    tbl_category;


/*
    ## 선택함수
    특정 경우에 따라 성택을 할 수 있는 기능 제공ALTER
    
    - 표현법1
    CASE WHEN 조건1 THEN 결과1
         WHEN 조건2 THEN 결과2
         ...
         [ELSE 결과 N]
    END
    
    - 표현법2
    CASE 비교대상
        WHEN 값1 THEN 결과1
        WHEN 값2 THEN 결과2
        ...
        [ELSE 결과N]
    END
*/

SELECT
    menu_name
    ,menu_price
    , CASE
        WHEN menu_price < 5000 THEN '싼거'
        WHEN menu_price <= 10000 THEN '적당'
        WHEN menu_price <= 20000 THEN '비싼'
        ELSE '비비쌈싸맜맜ㅁ'
    END AS "가격레벨"
FROM
    tbl_menu
;

SELECT
    menu_name
    ,CASE orderable_status
        WHEN 'Y' THEN '주문가능'
        WHEN 'N' THEN '주문불가능'
    END AS "주문가능여부"
FROM
    tbl_menu
;

-- =============================================================================================================
/*
    그 룹 함 수
    하나 이상의 랭을 그룹으로 묶은 후 그룹별 연산해서 반환
*/

-- SUM(숫자타입) : 컬럼의 총 합을 반환(null은 연산에서 제외)
SELECT
    SUM(menu_price) # 228500
FROM
    tbl_menu
;

SELECT
    FORMAT(AVG(menu_price),2)
FROM
    tbl_menu
;

-- 카테고리 10번인 메뉴의 평균가격
SELECT
    CAST(AVG(menu_price) AS SIGNED INTEGER)
FROM
    tbl_menu
WHERE
    menu_code = 10
;

-- COUNT() : 해당 데이터의 총 개수를 반환
SELECT
    COUNT(*) # 12
    ,COUNT(ref_category_code) # NULL은 해당되지 않음 # 9
    , COUNT(DISTINCT ref_category_code) #3 #중복을 제거해서 출력하겠다.
FROM
    tbl_category
;

-- MAX() : 그룹 내의 최대값을 구해서 반환
-- MIN() : 그룹 내의 최소값을 구해서 반환
SELECT
    MAX(menu_price) # 35000
    , MIN(menu_price) # 2000
    , MAX(menu_name)
FROM
    tbl_menu
;


















