/*
    ## INSTR, LOCATE ##
    1. INSTR(기준문자열, 부분문자열) : 기준문자열에 해당 부분문자열의 시작 위치를 찾아 반환(없으면 0 반환)
    2. LOCATE(부분문자열, 기준문자열): 기준문자열에 해당 부분문자열의 시작 위치를 찾아 반환 (없으면 0 반환)
*/

SELECT
    INSTR('사과딸기바나나', '딸기')
,   LOCATE('딸기', '사과딸기바나나');

/*
    ## FORMAT ##
    FORMAT(숫자, 소수점자리수) : 1000 단위마다 콤마(,) 표시를 해주며 소수점 아래 자리수까지 표현(반올림)함
*/
SELECT
    FORMAT(123123123123.571235, 3);
    
SELECT
    menu_name
,   FORMAT(menu_price, 0)
,   CONCAT( FORMAT(menu_price, 0), '원')
FROM
    tbl_menu;
    
/*
    ## INSERT ##
    INSERT(기준문자열, 위치, 길이, 삽입할문자열) : 기준문자열의 해당 위치부터 해당 길이만큼을 지우고 삽입할문자열을 넣어 반환
*/
SELECT
    INSERT("내 이름은 아무개입니다.", 7, 3, '홍길동');
    
/*
    ## LEFT, RIGHT
    1. LEFT(문자열, 길이) : 해당 문자열의 왼쪽지접에서부터 해당 길이만큼의 문자열 반환
    2. RIGHT(문자열, 길이) : "            오른쪽 지점에서부터                "
*/
SELECT
    LEFT("Hello world", 4)
,   RIGHT("Hello world", 5);

SELECT
    LPAD('왼쪽', 6, '@')
,   RPAD('오른쪽', 6, '@');


/*
    ## CURTIME, CURRENT_TIME ##
    현재 시간 정보를 "시:분:초" 형식으로 변환
*/
SELECT
    CURTIME()
,   CURRENT_TIME(), CURRENT_TIME;

/*
    ## ADDDATE, SUBDATE ##
    1. ADDDATE(날짜, 일수) : 해당 날짜로부터 해당 일수만큼 더한 날짜 반환
    2. SUBDATE(날짜, 일수) :                "                뺀 날짜 반환
    
    * 일수 대신에 "INTERVAL N 단위" 형식으로 작성 가능
    => 해당 단위의 N 날짜 만큼 더하거나 뺀 날짜 반환
*/
SELECT
    CURDATE()
,   ADDDATE(CURDATE(), 1)
,   SUBDATE(CURDATE(), 1);

SELECT
    ADDDATE('2024-12-31', INTERVAL 2 DAY)
,   ADDDATE('2024-12-31', INTERVAL 2 MONTH)
,   ADDDATE('2024-12-31', INTERVAL 2 YEAR);

/*
    ## EXTRACT ##
    EXTRACT(UNIT FROM 날짜및시간) : 날짜및시간 으로부터 UNIT 에 해다하는 값 추출해서 반환
    
    * UNIT 목록
    - YEAR_MONTH    :연월
    - 
*/
    
SELECT
    NOW()
,   DATE_FORMAT(NOW(), '%y-%m-%d')
,   DATE_FORMAT(NOW(), '%H-%i-%s')
,   DATE_FORMAT(NOW(), '%Y/%m/%d(%W, %a)')
,   DATE_FORMAT(NOW(), '%Y년 %m월 %d일')
;

SELECT @@lc_time_names;
SET @@lc_time_names = 'en_US'; -- ko_KR

-- =========================
-- 단일행함수 - 형변환함수
-- =========================

/*
    ## CAST, CONVERT ##
    CAST(값 AS 데이터형식)
    CONVERT(값, 데이터형식)
    
    * 주요 데이터형식
    1) 문자열로 : CHAR
    2) 날짜 및 시간으로 : DATE, TIME, DATETIME
    3) 숫자로 : SIGNED INTEGER, DOUBLE, DECIMAL
*/


-- =======================================================
-- 그룹함수
-- 하나 이상의 행을 그룹으로 묶은 후 그룹별 연산해서 반환
-- =======================================================

SELECT
    menu_price
FROM
    tbl_menu;




    
    
    
    
    
    
    
    
    
    
    
    
    
    
    


