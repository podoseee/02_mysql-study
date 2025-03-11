-- 단일행함수
-- 기타함수

-- NULL처리함수
SELECT
    IFNULL(NULL, 'Hello World')
    , IFNULL('ㅋㅋㅋ', 'Hello World');

SELECT
    category_name
    , IFNULL(ref_category_code, '없음')
FROM
    tbl_category;

SELECT
    ISNULL(NULL)
    , ISNULL('zzz');

SELECT
    COALESCE(NULL, NULL, '홍길동', NULL, '김첨지');

-- 삼항연산처리함수 IF
SELECT
    menu_name
    , IF(orderable_status = 'Y', '주문가능', '매진' ) AS '주문가능여부'
FROM
    tbl_menu;

SELECT
    category_name
    , IF(ISNULL(ref_category_code), '상위', '하위' ) AS '카테고리'
FROM
    tbl_category;


-- 단일행함수
-- 날짜/시간처리함수

-- NOW ~~
SELECT
    NOW()
    , SYSDATE()
    , LOCALTIME(), LOCALTIME
    , LOCALTIMESTAMP(), LOCALTIMESTAMP;

-- CURDATE, CURRENT_DATE
SELECT
    CURDATE()
    , CURRENT_DATE(), CURRENT_DATE;

-- CURTIME, CURRENT_TIME
SELECT
    CURTIME()
    , CURRENT_TIME(), CURRENT_TIME;

-- ADDDATE, SUBDATE
SELECT
    CURDATE()
    , ADDDATE(CURDATE(), 1)
    , SUBDATE(CURDATE(), 1);

SELECT
    ADDDATE('2024-12-31', INTERVAL 2 DAY)
    , ADDDATE('2024-12-31', INTERVAL 2 MONTH)
    , ADDDATE('2024-12-31', INTERVAL 2 YEAR);

-- ADDTIME, SUBTIME
SELECT
    ADDTIME('09:00:00', 10)
    , ADDTIME('09:00:00', '1:30')
    , ADDTIME('09:00:00', '1:30:15')
    , SUBTIME('09:00:00', '1:0');

-- DATEDIFF, TIME DIFF
SELECT
    DATEDIFF('2025-07-29', NOW())
    , TIMEDIFF('17:50:50', CURTIME());

-- YEAR, MONTH, DAY, HOUR, MINUTE, SECOND,MICROSECOND
SELECT
    YEAR(CURDATE())
    , MONTH(CURDATE())
    , DAY(CURDATE());

SELECT
    HOUR(CURTIME())
    , MINUTE(CURTIME())
    , SECOND(CURTIME())
    , MICROSECOND(CURTIME());

-- DATE, TIME
SELECT
    DATE(NOW())
    , TIME(NOW());

-- EXTRACT
SELECT
    EXTRACT(YEAR_MONTH FROM NOW())
    , EXTRACT(DAY_HOUR FROM NOW());

-- DAYOFWEEK, MONTHNAME, DAYOFYEAR
SELECT
    DAYOFWEEK(CURDATE())
    , DAYOFMONTH(CURDATE())
    , DAYOFYEAR(CURDATE())
    , MONTHNAME(CURDATE());

-- LAST_DAY(날짜)
SELECT
    LAST_DAY(CURDATE())
    , LAST_DAY("2024-02-10");

-- MAKEDATE, MAKETIME
SELECT
    MAKEDATE(2025, 32)
    , MAKETIME(14,45,03);

-- PERIOD_ADD, PERIOD_DIFF
SELECT
    PERIOD_ADD(202404, 5)
    , PERIOD_DIFF(202409, 202404);

-- DATE_FORMAT()
SELECT
    NOW()
    , DATE_FORMAT(NOW(), '%y-%m-%d')
    , DATE_FORMAT(NOW(), '%Y/%m/%d')
    , DATE_FORMAT(NOW(), '%H,%i,%s')
    , DATE_FORMAT(NOW(), '%h:%i-%s(%W, %a)')
;

SELECT @@lc_time_names; -- 현재 시간포맷을 채크하는 시스템포맷
SET @@lc_time_names = 'kr_KR';

-- BUILT IN FUNCTIONS

-- 단일행함수 - 문자처리함수

SELECT ASCII('A'), CHAR(65);

SHOW VARIABLES LIKE 'character_set_database'; -- 데이터베이스의 문자셋 확인

SELECT LENGTH('pie'), BIT_LENGTH('pie'), CHAR_LENGTH('pie');
SELECT LENGTH('파이'), BIT_LENGTH('파이'), CHAR_LENGTH('파이');

SELECT
    menu_name
--    , CHAR_LENGTH(menu_name)
FROM
    tbl_menu
WHERE
    CHAR_LENGTH(menu_name) = 5;

-- CONCAT, CONCAT_WS
SELECT
    CONCAT('호랑이','토끼','다람쥐')
    , CONCAT_WS(', ','호랑이','토끼','다람쥐');

SELECT
    CONCAT_WS('-' , '2024', '03', '10') AS 날짜;

-- ELT, FIELD, FIND_IN_SET
SELECT
    ELT(2, '사과', '딸기', '바나나')
    , FIELD('사과', '사과', '딸기', '바나나')
    , FIND_IN_SET('바나나', '사과,딸기,바나나');

-- ORDER BY절에서 특정 행을 끌어올리기 위한 용도로 사용 가능
SELECT
    *
FROM
    tbl_menu
ORDER BY
    -- FIND_IN_SET(menu_code, '15,12') DESC -- menu_code값이 15일 경우 1, 12일경우 2 반환
    FIELD(orderable_status, 'N', 'Y')
;

-- INSTR, LOCATE
SELECT
    INSTR('사과딸기바나나', '딸기')
    , LOCATE('딸기', '사과딸기바나나');

-- FORMAT
SELECT
    FORMAT(1234123124.1539491, 3);

SELECT
    menu_name
    , FORMAT(menu_price, 0)
    , CONCAT(FORMAT(menu_price,0), '원')
FROM
    tbl_menu;

-- INSERT
SELECT
    INSERT('내 이름은 아무개입니다.', 7, 3, '홍길동');

SELECT
    INSERT('메뉴의 이름은 메뉴명입니다.', 9, 3, menu_name)
FROM
    tbl_menu;

-- 쥬스가 포함되어있는 메뉴 이름을 juice로 변경해서 조회
SELECT
    menu_name
    , INSERT(menu_name, INSTR(menu_name, '쥬스'), 2, 'juice')
FROM
    tbl_menu
WHERE
    menu_name LIKE '%쥬스';

-- REPLACE
SELECT REPLACE('마이SQL', '마이', 'My');

SELECT 
    menu_name
    , REPLACE(menu_name, '쥬스', 'juice')
FROM
    tbl_menu;

-- LEFT, RIGHT
SELECT
    LEFT('Hello World', 5)
    , RIGHT('Hello World', 5);

-- LOWER, UPPER
SELECT
    LOWER('Hello World')
    , UPPER('Hello World');

-- LPAD, RPAD
SELECT
    LPAD('왼쪽', 6, '@')
    , RPAD('오른쪽', 6, '@');

SELECT
    RPAD('930202-1', 14, '*');

SELECT
    menu_name
    , LPAD(menu_price, 5, ' ')
FROM
    tbl_menu;

-- LTRIN, RTRIM, TRIM
SELECT
    LTRIM('    왼 쪽 ')
    , RTRIM(' 오른 쪽     ')
    , TRIM('    양 쪽    ');

SELECT
    TRIM('@' FROM '@@@MySQL@@@')
    , TRIM(BOTH'@' FROM '@@@MySQL@@@')
    , TRIM(LEADING'@' FROM '@@@MySQL@@@')
    , TRIM(TRAILING'@' FROM '@@@MySQL@@@');

-- REPEAT
SELECT 
    -- REPEAT('하이', 5)
SELECT
    CONCAT( '이름:', SPACE(3), ', 나이', SPACE(2));

-- REVERSE
SELECT
    REVERSE('strssed');

-- SUBSTRING, SUBSTRING_INDEX
SELECT
    SUBSTRING('안녕하세요 반갑습니다', 7, 2)
    , SUBSTRING('안녕하세요 반갑습니다', 7);

SELECT
    RPAD(SUBSTRING('990918-1234567', 1, 8), 14, '*');

SELECT
    SUBSTRING_INDEX('ssg.test@gmail.com', '@', 1)
    ,SUBSTRING_INDEX('ssg.test@gmail.com', '.', -2);
    
    -- 단일행함수
-- 숫자처리함수

-- ABS
SELECT
    ABS(1)
    , ABS(-1);

-- CEILING, FLOOR, TRUNCATE, ROUND
SELECT
    CEILING(123.456)
    , FLOOR(123.456)
    , FLOOR(-0.65);

SELECT
    TRUNCATE(123.456, 0)
    ,TRUNCATE(123.456, 1)
    ,TRUNCATE(123.456, 2)
    ,TRUNCATE(123.456, -1);

SELECT
    ROUND(123.456)
    , ROUND(123.456, 1);

-- MOD
SELECT
    75 % 10
    , 75 MOD 10
    , MOD (75,10);

-- POW, SQRT
SELECT
    POW(2,10)
    , SQRT(16);

-- RAND
SELECT
    RAND()
    , FLOOR(RAND() * 10 + 1);

-- SIGN
SELECT
    SIGN(10.1)
    , SIGN(0)
    , SIGN(-10.1);

-- 단일행함수
-- 형변환함수

-- CAST, CONVERT
-- 자동형변환 케이스
SELECT '1' + '2'; -- 문자를 숫자타입으로 형변환
SELECT CONCAT(menu_price, '원') FROM tbl_menu; -- 숫자를 문자타입으로 형변환
SELECT ADDDATE('2025-03-10', 1); -- DATE 타입으로 자동형변환
SELECT 3 > 'MAY'; -- 문자는 0으로 자동형변환
SELECT 3 > '6MAY';

-- 강제형변환
SELECT
    AVG(menu_price)
    , CAST(AVG(menu_price) AS SIGNED INTEGER)
    -- 정수형으로 변환하면서 자동으로 반올림
    , CONVERT(AVG(menu_price), SIGNED INTEGER)
FROM
    tbl_menu;

SELECT
    CAST( '2025%5%30'AS DATE)
    ,CAST( '2025/5/30'AS DATE)
    ,CAST( '2025$5$30'AS DATE)
    ,CAST( '20250330'AS DATE)
    ,CAST( '2025년03월30일'AS DATE); -- NULL로 조회
