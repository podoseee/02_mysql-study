-- 그룹함수

SELECT
    menu_price
FROM
    tbl_menu;
    
-- SUM(숫자타입)
-- 전체 메뉴 가격의 총 합
SELECT
    SUM(menu_price)
FROM
    tbl_menu;

-- AVG(숫자타입)
SELECT
    ROUND(AVG(menu_price))
FROM
    tbl_menu;

-- 카테고리 번호가 10번인 메뉴의 평균 가격
SELECT
--    ROUND(AVG(menu_price))
    CAST(AVG(menu_price) AS SIGNED INTEGER)
FROM
    tbl_menu
WHERE
    category_code = 10;

-- COUNT(*|모든타입)
SELECT
    COUNT(*) -- 전체 행을 모두 카운팅
    , COUNT(ref_category_code) -- 존재하는 데이터만 카운팅
    , COUNT(DISTINCT ref_category_code)
FROM
    tbl_category;

-- MAX(모든타입) : 최대값 반환
-- MIN(모든타입) : 최소값 반환
SELECT
    MAX(menu_price)
    , MIN(menu_price)
    , MAX(menu_name)
    , MIN(menu_name)
    -- 날짜및시간 => 최대값(최근날짜) / 최소값(옛날날짜)
FROM
    tbl_menu;






