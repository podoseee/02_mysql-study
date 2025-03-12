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