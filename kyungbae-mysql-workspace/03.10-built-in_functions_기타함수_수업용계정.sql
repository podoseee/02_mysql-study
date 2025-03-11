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

-- 선택함수 CASE
-- 표현법 1
SELECT
    menu_name
    , menu_price
    , CASE
        WHEN menu_price < 5000 THEN 'CHEAP'
        WHEN menu_price <= 10000 THEN 'NORMAL'
        WHEN menu_price <= 20000 THEN 'EXPENSIVE'
        ELSE 'SUPER EXPENSIVE'
    END AS '가격LEVEL'
FROM
    tbl_menu;

-- 표현법2
SELECT
    menu_name
    , CASE orderable_status
        WHEN 'Y' THEN 'ORERABLE'
        WHEN 'N' THEN 'SOLD_OUT'
    END AS '주문가능여부'
FROM
    tbl_menu;

