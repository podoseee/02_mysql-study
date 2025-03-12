/*
    ## BUILT IN FUNCTION ##
    1. 내장 함수
    2. 전달된 값들을 읽어들여 특정 작업 수행 후 결과값을 반환하는 함수
    3. 흐름
       호출(값 전달) -> 작업 수행 -> 결과값 반환
    4. API Dosc
       https://dev.mysql.com/doc/refman/8.0/en/built-in-function-reference.html
       https://www.w3schools.com/mysql/mysql_ref_functions.asp
    5. 종류
       1) 단일행함수 : 각 행마다 반복적으로 작업을 수행하여 결과를 반환 (즉, N개의 값을 읽어들여 N개의 결과 반환
          - 문자처리함수
          - 숫자처리함수
          - 날짜/시간처리함수
          - 기타함수
       2) 그룹함수   : 여러행들이 그룹으로 형성되어 적용됨. 그룹당 1개의 결과 반환 (즉, N개의 값을 읽어들여 1개의 결과 반환)
*/

-- ===========================
-- 단일행함수 - 문자처리함수
-- ===========================

/*
    ## ASCII, CHAR ##
    1. ASCII(문자) : 해당 문자의 아스키 코드값을 반환
    2. CHAR(숫자)  : 해당 아스키 코드 숫자의 문자값을 반환
*/

SELECT ASCII('A'), CHAR(65);

/*
    ## LENGTH, BIT_LEGNTH, CHAR_LENGTH ##
    1. LENGTH(문자열)     : 해당 문자열의 할당된 바이트 크기 반환
    2. BIT_LENGTH(문자열) : 해당 문자열의 할당된 비트 크기 (LENGTH결과*8)
    3. CHAR_LENGTH(문자열): 해당 문자열의 길이(글자수) 반환
    
    * utf8mb4 문자셋 기준
    - 한글 한글자당 - 3Byte (24Bit)
    - 그외 한글자당 - 1Byte (8Bit)
*/

SHOW VARIABLES LIKE 'character_set_database'; -- 데이터베이스의 문자셋 확인(utf8mb4)

SELECT LENGTH('pie') , BIT_LENGTH('pie') , CHAR_LENGTH('pie');
SELECT LENGTH('파이') , BIT_LENGTH('파이') , CHAR_LENGTH('파이');

SELECT
    menu_name
--  , CHAR_LENGTH(menu_name)
FROM
    tbl_menu
WHERE
    CHAR_LENGTH(menu_name) = 5; -- 메뉴명이 5글자인 메뉴만 조회
    
/*
    ## CONCAT, CONCAT_WS ##
    1. CONCAT(문자열1, 문자열2,..)            : 해당 문자열들을 다 이어붙인 결과 반환
    2. CONCAT_WS(구분자, 문자열1, 문자열2,..) : 해당 문자열들을 해당 구분자로 이어붙인 결과 반환
*/
SELECT
    CONCAT('호랑이', '기린', '캥거루')
  , CONCAT_WS(',' ,'호랑이', '기린' , '캥거루');
  
SELECT
    CONCAT_WS('-', '2024', '02', '28');
    
/*
    ## ELT, FIELD, FIND_IN_SET ##
    1. ELT(찾을위치, 문자열1, 문자열2, ..)    : 나열된 문자열들 중 해당 위치의 "문자열을" 반환 (없으면 NULL 반환)
    
    2. FIELD(찾을문자열, 문자열1, 문자열2,..) :        "           해당 문자열의 "위치"를 반환 (없으면 0 반환)
    3. FIND_IN_SET(찾을문자열, 문자열리스트)  :   문자열 리스트 중             "               (없으면  0반환)
                                    ㄴ 단, 문자열리스트는 반드시 ,로 나열된 문자열이여야됨
*/

SELECT
    ELT(2, '사과', '딸기', '바나나')             -- 딸기
  , FIELD('바나나', '사과', '딸기', '바나나')    -- 3
  , FIND_IN_SET('사과', '사과,딸기,바나나');     -- 
  
  -- ORDER BY 특정 행을 끌어올리기 위한 용도로 사용 가능
SELECT
    *
FROM
    tbl_menu
ORDER BY
--    FIND_IN_SET(menu_code, '15,12') DESC -- menu_code 값이 15일 경우 1, menu_code값이 12일 경우 2, 나머지 menu_code값은 0
    FIELD(orderable_status, 'N', 'Y') -- orderable_status값이 N일 경우 1, Y일 경우 2
;

/*
    ## INSTR, LOCATE ##
    1. INSTR(기준문자열, 부분문자열) : 기준문자열에 해당 부분문자열의 시작위치를 찾아 반환 (없으면 0 반환)
    2. LOCATE(부분문자열, 기준문자열): 기준문자열에 해당 부분문자열의 시작위치를 찾아 반환 (없으면 0 반환)
*/
SELECT
    INSTR('사과딸기바나나', '딸기')
  , LOCATE('딸기', '사과딸기바나나');
  
  /*
    ## FORMAT ##
    FORMAT(숫자, 소수점자리수) : 1000단위마다 콤마(,) 표시를 해주며 소수점 아래 자리수까지 표현(반올림)함
  */
SELECT
    FORMAT(1231123123.578923, 3);
    
SELECT
    menu_name
  , FORMAT(menu_price, 0)
  , CONCAT( FORMAT(menu_price, 0), '원' )
FROM
    tbl_menu;
    
/*
    ## INSERT ##
    INSERT(기준문자열, 위치, 길이, 삽입할문자열) : 기준문자열의 해당 위치부터 해당 길이만큼을 지우고 삽입할 문자열을 넣어 반환
*/
SELECT
    INSERT('내 이름은 아무개입니다.' ,7, 3, '홍길동');
    
SELECT
    INSERT('메뉴의 이름은 메뉴명입니다.', 9, 3, menu_name)
FROM
    tbl_menu;
    
-- 쥬스가 포함되어있는 메뉴의 이름을 JUICE로 변경해서 조회
SELECT
    menu_name
  , INSERT( menu_name, INSTR(menu_name, '쥬스'), 2, 'JUICE' )
FROM
    tbl_menu
WHERE
    menu_name LIKE '%쥬스%';
    
/*
    ## REPLACE ##
    REPLACE(기준문자열, 찾을문자열, 바꿀문자열) : 기준문자열로부터 특정문자열을 찾아 바꿀문자열로 변경후 반환
        ㄴ 찾을문자열이 존재하지 않을 경우 => 기준문자열 반환
*/
SELECT REPLACE('마이SQL', '마이', 'MY');

SELECT
    menu_name
  , REPLACE(menu_name, '쥬스', 'JUICE')
FROM
    tbl_menu;
    
/*
    ## LEFT, RIGHT ##
    1. LEFT(문자열, 길이)  : 해당 문자열의 왼쪽지점에서부터 해당 길이만큼의 문자열 반환
    2. RIGHT(문자열, 길이) :         "     오른쪽지점에서부터         "
*/
SELECT
    LEFT('Hello World', 4)
  , RIGHT('Hello World', 5);
  
/*
    ## UPPER, LOWER ##
    1. UPPER(문자열) : 해당 문자열을 다 대문자로 변경해서 반환
    2. LOWER(문자열) :     "            소문자로       "  
*/
SELECT
    LOWER('Hello World')
  , UPPER('Hello World');
  
/*
    ## LPAD, RPAD ##
    LPAD|RPAD(기준문자열, 길이, 채울문자열)
        : 기준문자열을 해당 길이만큼 왼쪽 또는 오른쪽으로 늘린 후 빈곳을 채울문자열로 채워 반환
*/
SELECT 
    LPAD('왼쪽', 6, '@')
  , RPAD('오른쪽', 6, '@');

SELECT
    RPAD('880918-2', 14, '*');
    
SELECT
    menu_name
  , LPAD(menu_price, 5 , ' ') AS "가격"
FROM
    tbl_menu;
    
/*
    ## LTRIM, RTRIM, TRIM ##
    1. LTRIM(문자열) : 해당 문자열의 왼쪽 공백 제거하여 반환
    2. RTRIM(문자열) :        "      오른쪽       "
    3. TRIM(문자열)  :        "      양쪽         "
    4. TRIM([LEADING|TRAILING|BOTH] 제거할문자열 FROM 문자열) : 해당 문자열의 지정한 방향에 특정 문자열을 찾아 제거한 후 반환
*/
SELECT
    LTRIM('   왼 쪽 ')
  , RTRIM(' 오른 쪽   ')
  , TRIM('  양 쪽  ');
  
SELECT
    TRIM('@' FROM '@@@MYSQL@@@')
  , TRIM(BOTH '@' FROM '@@@MYSQL@@@')
  , TRIM(LEADING '@' FROM '@@@MYSQL@@@')
  , TRIM(TRAILING '@' FROM '@@@MYSQL@@@');
  
/*
    ## REPEAT ## 
    REPEAT(문자열, 횟수) : 문자열을 횟수마늠 반복해 만들어 반환
*/
SELECT REPEAT('재밌다!', 5);

/*
    ## SPACE ## 
    SPACE(길이) : 해당 길이만큼의 공백문자열을 반환
*/
SELECT
    CONCAT( '이름:', SPACE(3), ', 나이:', SPACE(2) );
    
/*
    ## REVERSE ##
    REVERSE(문자열) : 문자열의 순서를 거꾸로 뒤집어 반환
*/
SELECT REVERSE('stressed');

/*
    ## SUBSTRING, SUBSTRING_INDEX ##
    1. SUBSTRING(문자열, 시작위치[, 길이]) : 해당 문자열의 시작위치에서부터 해당 길이만큼을 반환 (SUBSTR로 대체가능)
    2. SUBSTRING_INDEX(문자열, 구분자, 구분자위치) : 해당 문자열의 구분자의 위치까지를 반환 
*/
SELECT
    SUBSTRING('안녕하세요 반갑습니다', 7, 2)
  , SUBSTRING('안녕하세요 반갑습니다', 7); -- 길이 생략시 끝까지를 의미
  
SELECT
    RPAD(SUBSTRING('880918-2348172', 1, 8), 14, '*');
    
SELECT
    SUBSTRING_INDEX('hong.test@gmail.com', '@', 1)
  , SUBSTRING_INDEX('hong.test@gmail.com', '.', 2)
  , SUBSTRING_INDEX('hong.test@gmail.com', '.', -2);
  
  
  -- ===============================
  -- 단일행함수 - 숫자처리함수
  -- ===============================
  
  /*
    ## ABS ##
    ABS(숫자) : 해당 숫자의 절대값 반환
  */
  SELECT
    ABS(1)
  , ABS(-1);
  
  /*
    ## CEILING, FLOOR, TRUNCATE, ROUND ##
    1. CEILING(숫자) : 해당 숫자의 올림값 반환
    2. FLOOR(숫자)   : 해당 숫자의 내림값(현재수보다 작은 최대정수) 반환
    3. TRUNCATE(숫자, 자리수) : 해당 숫자의 버림값 반환. 소수점이하 자리수는 필수
    4. ROUND(숫자[, 자리수])  : 해당 숫자의 반올림값 반환
  */
SELECT
    CEILING(123.456)
  , FLOOR(123.456)
  , FLOOR(-0.65);

SELECT
    TRUNCATE(123.456, 1)
  , TRUNCATE(123.456, 2)
  , TRUNCATE(123.456, 0)
  , TRUNCATE(123.456, -1);
  
SELECT
    ROUND(123.456)
  , ROUND(123.456, 1);
  
/*
    ## MOD ##
    MOD(숫자1, 숫자2) : 숫자1을 숫자2로 나눈 나머지 반환
*/
SELECT
    75 % 10
  , 75 MOD 10
  , MOD(75, 10);
  
/*
    ## POW, SQRT ##
    1. POW(숫자1, 숫자2) : 숫자1을 숫자2로 거듭제곱한 결과 반환
    2. SQRT(숫자)        : 숫자의 제곱근 값 반환
*/
SELECT
    POW(2, 10)
  , SQRT(16);
  
/*
    ## RAND ##
    RAND() : 0이상 1미만의 난수 반환
*/
SELECT
    RAND()
  , FLOOR(RAND() * 10 + 1);
  
/*
    ## SIGN ##
    SIGN(숫자) : 해당 숫자가 양수면 1, 음수면 -1, 0이면 0 반환
*/
SELECT
    SIGN(10.1)
  , SIGN(0)
  , SIGN(-10.1);

-- ===============================
-- 단일행함수 - 날짜/시간처리함수
-- ==============================
  
  /*
    ## NOW, SYSDATE, LOCALTIME, LOCALTIMESTAMP ##
    현재 날짜 및 시간 정보를 "연-월-일 시:분:초" 형식으로 반환
  */
SELECT
    NOW()
  , SYSDATE()
  , LOCALTIME(),LOCALTIME
  , LOCALTIMESTAMP(), LOCALTIMESTAMP;
  
/*
    ## CURDATE, CURRENT_DATE ##
    현재 날짜 정보를 "연-월-일" 형식으로 반환
*/
SELECT
    CURDATE()
  , CURRENT_DATE(), CURRENT_DATE;
  
/*
    ## CURTIME, CURRENT_TIME ##
    현재 시간 정보를 "시:분:초" 형식으로 반환
*/
SELECT
    CURTIME()
  , CURRENT_TIME(), CURRENT_TIME;
  
/*
    ## ADDDATE, SUBDATE ##
    1. ADDDATE(날짜, 일수) : 해당 날짜로부터 해당 일 수만큼 더한 날짜 반환
    2. SUBDATE(날짜, 일수) :            "                     뺀 날짜 반환
    
    * 일수 대신에 "INTERVAL N 단위" 형식으로 작성 가능
      => 해당 단위의 N 날짜 만큼 더하거나 뺀 날짜 반환
*/
SELECT
    CURDATE()
  , ADDDATE(CURDATE(), 1)
  , SUBDATE(CURDATE(), 1);
  
SELECT
    ADDDATE('2024-12-31', INTERVAL 2 DAY)
  , ADDDATE('2024-12-31', INTERVAL 2 MONTH)
  , ADDDATE('2024-12-31', INTERVAL 2 YEAR)
  , ADDDATE('2024-12-31', INTERVAL -2 YEAR);
  
/*
    ## ADDTIMe, SUBTIME ##
    1. ADDTIME(날짜및시간, 시간) : 해당 날짜 및 시간을 기준으로 특정 시간만큼 더한 시간을 반환
    2. SUBTIME(날짜및시간, 시간) :                     "                        뺀 시간을 반환
*/
SELECT
    ADDTIME('09:00:00', 10)
  , ADDTIME('09:00:00', '1:30')
  , ADDTIME('09:00:00', '1:30:15')
  , ADDTIME('09:00:00', '0:30:15')
  , SUBTIME('09:00:00', '1:0');
  
/*
    ## DATEDIFF, TiMEDIFF ##
    DATEDIFF(날짜1, 날짜2) : 날짜1 - 날짜2의 일수 반환
    TIMEDIFF(날짜및시간1, 날짜및시간2) : 시간1 - 시간2의 결과 반환
*/
SELECT
    DATEDIFF('2025-07-29', NOW())
  , TIMEDIFF('17:50:00', '14:22:00');
  
/*
    ## YEAR, MONTH, DAY, HOUR, SECOND, MICROSECOND ##
    날짜 및 시간에서 연, 월, 일, 시, 분, 초, 밀리초를 추출해서 반환
*/

SELECT
    YEAR(CURDATE())
  , MONTH(CURDATE())
  , DAY(CURDATE());
  
SELECT
    HOUR(CURTIME())
  , MINUTE(CURTIME())
  , SECOND(CURTIME())
  , MICROSECOND(CURTIME());
  
/*
    ## DATE, TIME ##
    DATE(날짜및시간) : 연-월-일만 추출
    TIME(날짜및시간) : 시:분:초만 추출
*/
SELECT
    DATE(NOW())
  , TIME(NOW());
  
/*
    ## EXTRACT ##
    EXTRACT(UNIT FROM 날짜및시간) : 날짜및시간으로부터 UNIT에 해당 하는 값 추출해서 반환
    
    * UNIT 목록
    - YEAR_MONTH        : 연월
    - YEAR              : 연도
    - MONTH             : 월
    - DAY               : 일
    - DAY_HOUR, HOUR    : 시
    - HOUR_MINUTE       : 분
    - MINUTE            : 분
    - SECOND            : 초
    - MICROSECOND       : 마이크로초
*/

SELECT EXTRACT(YEAR FROM NOW());

/*
    ## DAYOFWEEK, MONTHNAME, DAYOFYEAR ##
    DAYOFWEEK(날짜) : 요일 반환 (1이 일요일 ~ 7이 토요일)
    DAYOFMONTH(날짜): 해당 월을 기준으로 몇일 흘렀는지 반환
    DAYOFYEAR(날짜) : 해당 년도를 기준으로 몇일 흘렀는지 반환
    MONTHNAME(날짜) : 달의 이름 반환
*/
SELECT
    DAYOFWEEK(CURDATE())
  , DAYOFMONTH(CURDATE())
  , DAYOFYEAR(CURDATE())
  , MONTHNAME(CURDATE());
  
-- LAST_DAY(날짜) : 해당 달의 마지막 날짜를 구해서 반환
SELECT
    LAST_DAY(CURDATE())
  , LAST_DAY('20240210');
  
-- MAKEDATE(연도, 정수) : 해당 연도의 정수만큼 지난 날짜 구해서 반환
SELECT MAKEDATE(2025, 32);

-- MAKETIME(시,분,초) : 시, 분, 초를 이용해서 '시:분:초'의 TIME 형식을 구해서 반환
SELECT MAKETIME(14, 45, 03);

-- PERIOD_ADD(연월, 개월수) : 연월에서 개월수 이후의 연월을 구해서 반환
-- PERIOD_DIFF(연월1, 연월2): 연월1 - 연월2의 개월수 반환
SELECT PERIOD_ADD(202404,5), PERIOD_DIFF('202409', '202404');

-- DATE FORMAT(날짜및시간, 형식)
-- https://www.w3schools.com/mysql/func_mysql_date_format.asp
SELECT
    NOW()
  , DATE_FORMAT(NOW(), '%y-%m-%d')
  , DATE_FORMAT(NOW(), '%H-%i-%s') -- %h(12시간)
  , DATE_FORMAT(NOW(), '%Y/%m/%d(%W,%a)')
  , DATE_FORMAT(NOW(), '%Y년 %m월 %d일')
;

SELECT @@lc_time_names;
SET @@lc_time_names ='en_US'; -- lo_KR

-- ===============================
-- 단일행함수 - 형변환함수
-- ===============================

/*
    ## CAST, CONVERT ##
    CAST(값 AS 데이터형식)
    CONVERT(값, 데이터형식)
    
    * 주요 데이터형식
    1) 문자열로 : CHAR
    2) 날짜 및 시간으로 : DATE, TIME, DATETIME
    3) 숫자로 : SIGNED INTEGER, DOUBLE, DECIMAL
*/

-- 자동 형변환 케이스
SELECT '1' + '2';
SELECT CONCAT(menu_price, '원') FROM tbl_menu;
SELECT ADDDATE('2024-06-01', 1);
SELECT 3 > 'MAY'; -- 문자는 0으로 간주 => 3>1 => 1(TRUE)
SELECT 3 > '6MAY'; -- 6MAY = 6 => 3>6 => 0(FALSE)

-- 강제 형변환
SELECT
    AVG(menu_price)
  , CAST( AVG(menu_price) AS SIGNED INTEGER )
  , CONVERT( AVG(menu_price), SIGNED INTEGER ) 
FROM
    tbl_menu;
    
SELECT
    CAST( '2024%5%30' AS DATE )
  , CAST( '2024/5/30' AS DATE )
  , CAST( '2024$5$30' AS DATE )
  , CAST( '2024년5월30일' AS DATE ); -- null로 조회

-- ===============================
-- 단일행함수 - 기타함수
-- ===============================

/*
    ## NULL 처리 함수 ##
    IFNULL(값, NULL일때 대체값) : 값이 NULL일 경우 대체값 반환, NULL이 아닐경우 기존값 반환
    ISNULL(값) : 값이 NULL일 경우 1(True) 반환
    COALESCE(값1, 값2, ..) : 나열된 값들 중 NULL이 아닌 첫번째 값을 반환
*/
SELECT
    IFNULL(NULL, 'Hello World')
  , IFNULL('ㅋㅋㅋ' , 'Hello world');
  
SELECT
    category_name
  , IFNULL(ref_category_code, '없음')
FROM
    tbl_category;
    
SELECT
    ISNULL(NULL)
  , ISNULL('zzz');
  
SELECT
    coalesce(NULL, NULL, '홍길동', NULL, '김말똥');
    
/*
    ## 삼항연산처리함수 IF ##
    IF(조건, 참일경우반환값, 거짓일경우반환값)
*/
SELECT
    menu_name
  , IF(orderable_status = 'Y', '주문가능', '주문불가능') AS "주문가능여부"
FROM
    tbl_menu;
    
SELECT
    category_name
  , IF(ISNULL(ref_category_code) , '상위카테고리', '하위카테고리') AS "분류"
FROM
    tbl_category;
    
    




use menudb;

SELECT
    menu_name
  , menu_price
  , CASE
        WHEN menu_price < 5000 THEN '싼거'
        WHEN menu_price <= 10000 THEN '적당한거'
        WHEN menu_price <= 20000 THEN '좀 비싼거'
        ELSE '겁나 비싼거'
    END AS "가격레벨"
FROM
    tbl_menu;
    
SELECT
    menu_name
  , CASE orderable_status
        WHEN 'Y' THEN '주문가능'
        ELSE '주문불가'
    END AS "주문가능여부"
FROM
    tbl_menu;
    
    
-- =======================================================
-- 그룹함수
-- 하나 이상의 행을 그룹으로 묶은 후 그룹별 연산해서 반환
-- =======================================================
    
SELECT
    menu_price
FROM
    tbl_menu;
    
-- SUM(숫자타입) : 컬럼값들의 총 합을 구해서  (NULL은 연산에서 제외됨)
-- 전체 메뉴 가격의 총 합
SELECT
    SUM(menu_price)
FROM
    tbl_menu;

-- AVG(숫자타입) : 컬럼 값들의 평균을 구해서 반환 (SUM과 COUNT를 가지고 연산 내부적 진행)
SELECT
    FLOOR(AVG(menu_price))
FROM
    tbl_menu;
    
-- 카테고리번호가 10번인 메뉴의 평균가격
SELECT
    CAST( AVG(menu_price) AS SIGNED INTEGER )
FROM
    tbl_menu
WHERE 
    category_code = 10;
    
-- COUNT(*|ANY타입) : 해당 데이터의 총 개수 반환
SELECT 
    COUNT(*)    -- 조회되는 전체행을 다 카운팅함
  , COUNT(ref_category_code)    -- 제시된 컬럼의 값이 존재하는 것만 카운팅함 (즉, NULL은 제외)
  , COUNT(DISTINCT ref_category_code)   -- 제시된 컬럼값들 중 중복제거해서 카운팅함
FROM
    tbl_category;
    
-- MAX(ANY타입) : 그룹 내의 최대값을 구해서 반환
-- MIN(ANY타입) : 그룹 내의 최소값을 구해서 반환
SELECT
    MAX(menu_price)
  , MIN(menu_price)
  , MAX(menu_name)
  , MIN(menu_name)
  -- 날짜 및 시간 => 최대값(최근 날짜) / 최소값(옛날 날짜)
FROM
    tbl_menu;
    

    
    



        
  
