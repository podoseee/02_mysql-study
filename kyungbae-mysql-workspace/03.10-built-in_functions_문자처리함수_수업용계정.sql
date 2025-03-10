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

