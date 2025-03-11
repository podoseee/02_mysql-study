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

