-- 현재 선택된 database의 모든 테이블들 조회
show tables;

-- 특정 테이블의 구조 확인 (컬럼, 컬럼타입, null허용여부, key, 등)
DESC tbl_menu;

SELECT * FROM tbl_category; -- 12행(12rows)
SELECT * FROM tbl_menu;
SELECT * FROM tbl_order;
SELECT * FROM tbl_order_menu;
SELECT * FROM tbl_payment;
SELECT * FROM tbl_payment_order;

-- 단일 컬럼(열) 데이터 조회
SELECT menu_name FROM tbl_menu;

-- 여러 컬럼 조회
SELECT
    menu_code
    , menu_name
    , menu_price
FROM
    tbl_menu
;

-- 모든 컬럼(*) 조회 (실무에서 * 사용 금지)
SELECT
    *
FROM
    tbl_menu;

SELECT
    menu_code
    , menu_name
    , menu_price
    , category_code
    , orderable_status
FROM
    tbl_menu;

-- 부가세 포함 계산
SELECT
    menu_name
    , menu_price
    , menu_price + (menu_price * 0.1)
    , menu_price + cast((menu_price * 0.1) as signed integer)
FROM
    tbl_menu;

-- 컬럼 별칭
SELECT
    menu_name 메뉴이름
    , menu_price '메뉴 가격'
    , menu_price * 0.1 AS "메뉴 부가세"
    , menu_price * 1.1 AS `메뉴 부가세포함 가격`
FROM
    tbl_menu;

-- 리터럴
SELECT
    menu_name AS 메뉴이름
    , menu_price * 1.1 AS "부가세포함 가격"
    , '원' AS "단위"
FROM
    tbl_menu;

-- 문자열 연결 CONCAT
SELECT
    CONCAT('홍', '길', '동');


SELECT
    menu_name
    , CONCAT(menu_price, "원")
FROM
    tbl_menu;

-- DISTINCT
SELECT
    DISTINCT category_code
FROM
    tbl_menu;

SELECT
    DISTINCT menu_price
FROM
    tbl_menu;

SELECT
    DISTINCT category_code
--    , DISTINCT orderable_status
    , orderable_status
FROM
    tbl_menu;

-- ------------------------------------------------

-- 주문 불가능한 메뉴 조회
SELECT
    menu_name
    , menu_price
    , orderable_status
FROM
    tbl_menu
WHERE
    -- orderable_status = 'N'
    -- orderable_status = 'n' -- MySQL 은 기본적으로 대소문자 구분없이 비교
    -- BINARY orderable_status = 'N'
    -- orderable_status != 'Y'
    orderable_status <> 'Y'
;

-- 13000원 이상 메뉴 조회 (메뉴명, 가격, 주문가능여부)
SELECT
    menu_name
    , menu_price
    , orderable_status
FROM
    tbl_menu
WHERE
    -- orderable_status = 'Y'
    menu_price >= "13000"
    AND orderable_status = 'Y'
;
 

SELECT
    1 AND 1         -- TRUE
    , 2 && 2        -- TRUE
    , -1 AND 1      -- TRUE
    , 1 && 'abc'    -- FALSE
    , 1 AND NULL    -- NULL short curcit
    , NULL && NULL  -- NULL
    , 0 AND NULL;   -- FALSE short curcit

SELECT
    1 OR 1
    , 2 || 2
    , -1 OR 1
    , 1 OR "ABC"
    , NULL OR NULL
    , 0 OR NULL
    , 1 OR NULL;

-- 가격이 5000원 초과이며 카테고리 번호가 10인 메뉴 조회
SELECT
    menu_code
    , menu_name
    , menu_price
    , category_code
    , orderable_status
FROM
    tbl_menu
WHERE
    menu_price > '5000'
AND category_code = '10';
    
-- 주문가능하며 카테고리번호가 10인 메뉴 조회
SELECT
    *
FROM
    tbl_menu
WHERE
    category_code = '10'
AND orderable_status = 'Y';


-- 카테고리번호가 4거나 가격이 9000원인 메뉴 중에서
-- 메뉴번호가 10보다 큰 메뉴 조회
SELECT
    *
FROM
    tbl_menu
WHERE
    category_code = '4'
OR menu_price = '9000'
AND menu_code > '10';

SELECT
    *
FROM
    tbl_menu
WHERE
    (category_code = '4'
OR menu_price = '9000')
AND menu_code > '10';

-- BETWEEN AND

-- 가격이 10000~25000원인 메뉴 조회
SELECT
    menu_name
    , menu_price
    , category_code
FROM
    tbl_menu
WHERE
    -- menu_price >= '10000' AND menu_price <= '25000';
    menu_price BETWEEN 10000 AND 25000;

-- 부정표현
SELECT
    menu_name
    , menu_price
    , category_code
FROM
    tbl_menu
WHERE
    menu_price NOT BETWEEN 10000 AND 25000;

-- 사전등제순 한글 비교
SELECT
    menu_name
    , menu_price
FROM
    tbl_menu
WHERE
    menu_name BETWEEN '가' AND '마'; -- 가 - 힣

-- LIKE
-- 메뉴명이 '마'로 시작하는 메뉴 조회
SELECT
    menu_name
    , menu_price
FROM
    tbl_menu
WHERE
    menu_name LIKE '마%'; -- 마로 시작하는 글자수 제한 없는 항목

-- 메뉴명에 '마늘'이 포함되어있는 메뉴 조회
SELECT
    menu_name
    , menu_price
FROM
    tbl_menu
WHERE
    menu_name LIKE '%마늘%';
    
-- 메뉴명이 '밥'으로 끝나는 메뉴 조회
SELECT
    menu_name
    , menu_price
FROM
    tbl_menu
WHERE
    menu_name LIKE '%밥';

-- 초밥 앞글자가 3글자인 메뉴 조회
SELECT
    menu_name
    , menu_price
FROM
    tbl_menu
WHERE
    menu_name LIKE '___초밥';
    
-- '갈치'가 포함되어있지 않은 메뉴조회
SELECT
    menu_name
    , menu_price
FROM
    tbl_menu
WHERE
    menu_name NOT LIKE '%갈치%';

-- IN
-- 카테고리번호가 4 또는 5 또는 6인 메뉴
SELECT
    menu_name
    , category_code
FROM
    tbl_menu
WHERE
    category_code IN (4, 5, 6);
    -- category_code BETWEEN 4 AND 6;

SELECT * FROM menudb.tbl_category;

-- IS NULL
-- 대분류 카테고리만 조회 (상위 카테고리 번호가 NULL인 데이터 조회)
SELECT
    category_name
    , ref_category_code
FROM
    tbl_category
WHERE
    -- ref_category_code = NULL; -- 조회 안됨 '=' 은 실제 존재하는 값만 비교
    ref_category_code IS NULL;

-- 소분류 카테로기만 조회 (즉, 상위카테고르번호가 NULL이 아닌)
SELECT
    category_name
    , ref_category_code
FROM
    tbl_category
WHERE
    -- ref_category_code != NULL; -- 조회안됨 같은이유
     ref_category_code IS NOT NULL;

-- ORDER BY
-- 가격 순으로 내림차순 정렬
SELECT
    menu_code
    , menu_name
    , menu_price
FROM
    tbl_menu
ORDER BY
    -- menu_price
    -- menu_price DESC
    menu_price DESC, menu_name
;

-- 메뉴번호, 메뉴가격, 메뉴부가세포함가격
-- 부가세포함가격 내림차순 정렬

SELECT
    menu_code
    , menu_name
    , menu_price
    , CAST((menu_price * 1.1) AS SIGNED INTEGER) AS 부가세포함가격
FROM
    tbl_menu
ORDER BY
    -- menu_price * 1.1 DESC
    -- 부가세포함가격 DESC
    4 DESC -- SELECT 절 순번으로도 사용 가능
;

SELECT
    category_code
    , category_name
    , ref_category_code
FROM
    tbl_category
ORDER BY
    -- ref_category_code -- 오름차순 정렬시 NULL이 상단
    -- ref_category_code IS NULL -- NULL을 하단에 위치
    -- ref_category_code DESC -- 내림차순 정렬시 NULL이 하단
    ref_category_code IS NULL DESC, ref_category_code DESC
    -- 내림차순 정렬시 NULL을 상단에 위치시키고자 할 경우
;

-- -----------------------------------------------------

-- LIMIT 절

-- Top-N분석
-- 비싼 메뉴 순으로 상위 5개 조회
SELECT
    menu_code
    , menu_name
    , menu_price
FROM
    tbl_menu
ORDER BY
    menu_price DESC
    , menu_name
LIMIT
    # 0, 5 -- 0번 인덱스부터 5개 조회
    5 -- offset 생략시 0번 인덱스부터 조회
;

-- 페이징 처리
-- 총 21건의 데이터를 한페이지에 5건씩 출력 (총 5페이지 == 올림(전체수/한페이지당수))

SELECT
    *
FROM
    tbl_menu
ORDER BY
    menu_code DESC
LIMIT
    -- 0, 5 -- 1페이지
    -- 5, 5 -- 2페이지
    -- 10, 5 -- 3페이지
    -- 15, 5 -- 4페이지
    20, 5 -- 5페이지
;

