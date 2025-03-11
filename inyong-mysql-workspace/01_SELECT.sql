/*
    ## SQL문 종류 ##
    1. DQL (Data Query Language) : 데이터 질의 언어
       - SELECT (데이터 조회)
    2. DML (Data Manipulation Language) : 데이터 조작 언어 
       - INSERT (데이터 삽입)
       - UPDATE (데이터 수정)
       - DELETE (데이터 삭제)
    3. DDL (Data Definition Language) : 데이터 정의 언어 
       - CREATE (데이터 구조 생성)
       - ALTER  (데이터 구조 변경)
       - DROP   (데이터 구조 삭제)
    4. DCL (Data Control Language) : 데이터 제어 언어 
       - GRANT  (권한 부여)
       - REVOKE (권한 철회)
    5. TCL (Transaction Control Language) : 트랜잭션 제어 언어 
       - COMMIT   (트랙잭션 확정)
       - ROLLBACK (트랜잭션 취소)
*/

-- 현재 선택된 database의 모든 테이블들 조회 
show tables;

-- 특정 테이블의 구조 확인 (컬럼, 컬럼타입, null허용여부, key, 등)
DESC tbl_menu;

SELECT * FROM tbl_category;     -- 12행
SELECT * FROM tbl_menu;         -- 21행
SELECT * FROM tbl_order;
SELECT * FROM tbl_order_menu;
SELECT * FROM tbl_payment;
SELECT * FROM tbl_payment_order;

/*
    ## SELECT 문 ##
    1. DQL(Query) 명령문 (DML의 하위 분류)
    2. 정의된 테이블의 데이터를 조회/검색 하는 명령문
    3. 조회 결과를 ResultSet(결과 집합)이라 함
    4. 표현법
       (5) SELECT 컬럼, 산술식, 함수식, .. AS 별칭
       (1) [FROM 테이블명]
       (2) [WHERE 조건식]
       (3) [GROUP BY 그룹기준]
       (4) [HAVING 조건식]
       (6) [ORDER BY 정렬기준 정렬방식]
       (7) [LIMIT 숫자, 숫자]
     실행순서
*/

-- 단일 컬럼 데이터 조회
SELECT menu_name FROM tbl_menu;

-- 여러 컬럼 조회
SELECT 
    menu_code
  , menu_name
  , menu_price
FROM
    tbl_menu;

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
    
/*
    ## 산술연산 ## 
    SELECT절에 산술연산식 작성시 산술 연산 결과 조회
*/
SELECT 6 + 4;
SELECT 6 - 4;
SELECT 6 * 4;
SELECT 
    6 / 4       -- 나누기 (1.5)
  , 6 div 4;    -- 몫 (1)
SELECT
    6 % 4
  , 6 mod 4;
  
-- 부가세 포함 계산
SELECT
    menu_name
  , menu_price
  , menu_price + (menu_price * 0.1) 
  , menu_price + cast( (menu_price * 0.1) as signed integer )
FROM 
    tbl_menu;

/*
    ## 컬럼 별칭(Alias) ##
    조회되는 ResultSet의 컬럼명(헤더) 부분을 내가 원하는 별칭으로 조회 가능
    
    [표현법]
    컬럼명 [AS] 별칭|'별칭'|"별칭"|`별칭`
    
    별칭이 숫자로 시작되거나 공란/특수문자가 있을 경우 반드시 "", '', ``로 감싸야됨
*/
SELECT
    menu_name 메뉴이름
  , menu_price '메뉴 가격'
  , menu_price * 0.1 AS "메뉴 부가세"
  , menu_price * 1.1 AS `메뉴 부가세포함 가격`
FROM
    tbl_menu;

/*
    ## 리터럴 ##
    임의로 지정한 문자값 
    SELECT절에 리터럴 제시시 마치 존재하는 데이터처럼 조회 가능 
*/
SELECT
    menu_name AS 메뉴이름
  , menu_price * 1.1 AS "부가세포함 가격"
  , '원' AS "단위"
FROM
    tbl_menu;
    
/*
    ## 문자열 연결 ##
    여러 컬럼값들을 마치 하나의 컬럼인거 처럼 연결하거나 
    리터럴과도 연결 가능 
    
    [표현법]
    CONCAT(값1, 값2, ..)
*/
SELECT
    CONCAT('홍', '길', '동');

SELECT
    menu_name
  , CONCAT(menu_price, '원') 
FROM
    tbl_menu;
    
/*
    ## DISTINCT ##
    컬럼의 중복값을 한번씩 표현하고자 할 때 사용
    * 유의사항 : SELECT절에 한번만 기술가능
*/

-- 메뉴별 카테고리
SELECT
    DISTINCT category_code
FROM
    tbl_menu;

SELECT
    DISTINCT menu_price
FROM
    tbl_menu;

-- 제시된 컬럼 값을 쌍으로 묶어 중복 판별
SELECT DISTINCT 
    category_code
  , orderable_status
FROM
    tbl_menu;

-- ===========================================================================

/*
    ## WHERE절 ## 
    1. 테이블의 데이터 중 원하는 데이터만 선택적으로 조회할 때 사용 (일부 행)
    2. WHERE 조건식
                ㄴ 컬럼명, 연산자, 표현식 등을 결합해서 작성
*/

/*
    ## 비교 연산자 ##
    1. 값 간의 관계를 비교하기 위해 사용
    2. 비교 결과는 논리값(TRUE/FALSE/NULL)이 됨
    3. 비교하는 두 값은 동일한 데이터 타입이어야됨 
    4. 종류
       =            : 같은지 비교
       !=, <>       : 같지 않은지 비교
       >, >=, <, <= : 크고 작음을 비교
       BETWEEN AND  : 특정 범위에 포함되는지 비교 
       [NOT] LIKE   : 패턴 부합 여부 비교
       IS [NOT] NULL: NULL 여부 비교
       [NOT] IN     : 목록에 포함/미포함 되는지 비교
*/

-- 주문 불가능한 메뉴 조회 
SELECT
    menu_name
  , menu_price
  , orderable_status
FROM
    tbl_menu
WHERE
--    orderable_status = 'N'
--    orderable_status = 'n' -- MySQL은 기본적으로 대소문자 구분없이 비교함
--    BINARY orderable_status = 'n' -- 대소문자 구분해서 비교하고자 할 경우 => BINARY 키워드
--    orderable_status != 'Y'
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
    menu_price >= 13000;

/*
    ## 논리연산자 ##
    1. 여러 조건 결과를 하나의 논리 결과로 만들어줌 
    2. 종류 
       && AND : 두 조건이 모두 TRUE여야만 최종 TRUE 반환 
       || OR  : 여러 조건 중 하나의 조건만 TRUE여도 최종 TRUE 반환 
        ! NOT : 조건에 대한 반대값으로 반환 
        
    숫자 0을 FALSE로 간주 
    0외의 숫자를 TRUE로 간주 
    문자열은 0(FALSE)로 간주
    연산시 NULL을 만나면 연산결과 또는 NULL
*/
SELECT
    1 AND 1         -- T and T => 1(True)
  , 2 && 2          -- T and T => 1(True)
  , -1 && 1         -- T and T => 1(True)
  , 1 && 'abc'      -- T and F => 0(False)
  , 1 AND NULL      -- T and N => NULL
  , NULL && NULL    -- NULL    => NULL
  , 0 AND NULL;     -- F       => 0(False)   ---- 숏서킷
  
SELECT
    1 OR 1          -- T or T  => 1(True)
  , 2 || 2          -- T or T  => 1
  , -1 || 1         -- T or T  => 1
  , 1 || 'abc'      -- T       => 1
  , NULL || NULL    -- NULL    => NULL
  , 0 OR NULL       -- F or N  => NULL
  , 1 OR NULL;      -- T       => 1
  
-- 가격이 5000원 초과이며 카테고리번호가 10인 메뉴 조회 (모든 컬럼)
SELECT
    *
FROM 
    tbl_menu
WHERE
    menu_price > 5000
AND category_code = 10;

-- 주문가능하며 카테고리번호가 10인 메뉴 조회 
SELECT
    *
FROM 
    tbl_menu
WHERE
    orderable_status = 'Y'
AND category_code = 10;

-- 카테고리번호가 4거나 가격이 9000원인 메뉴 중에서
-- 메뉴번호가 10보다 큰 메뉴 조회 
SELECT
    *
FROM 
    tbl_menu
WHERE
    category_code = 4 
 OR menu_price = 9000
AND menu_code > 10; -- 가격이 9000이면서 메뉴번호가 10보다 큰 메뉴 + 카테고리번호가 4인 메뉴

SELECT
    *
FROM 
    tbl_menu
WHERE
    (category_code = 4 
 OR menu_price = 9000)
AND menu_code > 10; 

-- AND 연산이 OR 연산보다 우선순위가 높음 

/*
    ## BETWEEN AND ##
    숫자, 문자열, 날짜/시간 값의 범위에 대한 조건 제시시 사용
    
    [표현법]
    비교대상 BETWEEN 하한값 AND 상한값
    
    비교대상 값이 하한값 이상 상한값 이하일 경우 TRUE 반환 
*/

-- 가격이 10000~25000원인 메뉴 조회 
SELECT
    menu_name
  , menu_price
  , category_code
FROM
    tbl_menu
WHERE
--     menu_price >= 10000 AND menu_price <= 25000;
    menu_price BETWEEN 10000 AND 25000; -- 8 row

-- 부정 표현
SELECT
    menu_name
  , menu_price
  , category_code
FROM
    tbl_menu
WHERE
--    menu_price NOT BETWEEN 10000 AND 25000; -- 13 row
    NOT menu_price BETWEEN 10000 AND 25000;

-- 사전등재순으로 문자열 범위 비교 
SELECT
    menu_name
  , menu_price
FROM
    tbl_menu
WHERE
    menu_name BETWEEN '가' AND '마'; -- 가 - 힣

/*
    ## LIKE ##
    비교값이 지정한 패턴을 만족하는지 비교해주는 연산자 
    패턴 작성시 '%', '_' 와일드 카드 작성 가능
    
    * 와일드 카드
      다른 문자로 대체 가능한 특수한 의미를 가진 문자
      1) % : 0개 이상의 임의의 글자
      2) _ : 1개의 임의의 글자 
*/
-- 메뉴명이 '마'로 시작하는 메뉴 조회 
SELECT
    menu_name
  , menu_price
FROM
    tbl_menu
WHERE
    menu_name LIKE '마%';
    
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
    
-- 쥬스 앞글자가 3글자인 메뉴 조회 
SELECT
    menu_name
  , menu_price
FROM
    tbl_menu
WHERE
    menu_name LIKE '___쥬스';
    
-- '갈치'가 포함되어있지 않은 메뉴 조회
SELECT
    menu_name
  , menu_price
FROM
    tbl_menu
WHERE
     NOT menu_name LIKE '%갈치%';
     
/*
    ## IN ##
    비교값이 제시한 목록 중에 존재할 경우 TRUE 반환해주는 연산자
    
    [표현법]
    비교대상 IN (값1, 값2, ..)
*/

-- 카테고리번호가 4 또는 5 또는 6인 메뉴 
SELECT
    menu_name
  , category_code
FROM
    tbl_menu
WHERE
--    category_code = 4 OR category_code = 5 OR category_code = 6;
--    category_code IN (4, 5, 6);
    category_code NOT IN (4, 5, 6);
    
/*
    ## IS NULL #
    비교대상이 NULL인지를 비교해주는 연산자
*/

-- 대분류 카테고리만 조회 (상위카테고리번호가 NULL인 데이터 조회)
SELECT
    category_name
  , ref_category_code
FROM
    tbl_category
WHERE
--    ref_category_code = NULL; -- 제대로 비교 안됨
    ref_category_code IS NULL; -- 제대로 비교됨

-- 소분류 카테고리만 조회 (즉, 상위카테고리번호가 NULL이 아닌)
SELECT
    category_name
  , ref_category_code
FROM
    tbl_category
WHERE
--    ref_category_code != NULL; -- 제대로 비교 안됨
    ref_category_code IS NOT NULL;
    
-- =====================================================================

/*
    ## ORDER BY 절 ##
    1. 조회 결과를 정렬하고자 할 때 사용 
    2. 오름차순 정렬(ASC, 생략시 기본값)과 내림차순 정렬(DESC) 존재
    3. 표현법
       ORDER BY 정렬기준 [IS NULL] [정렬방식]
*/
SELECT 
    menu_code
  , menu_name
  , menu_price
FROM
    tbl_menu
ORDER BY
--    menu_price ASC
--    menu_price        -- 정렬방식 생략시 오름차순
--    menu_price DESC     
    menu_price DESC, menu_name ASC -- 정렬기준 여러개 제시 가능
;

-- 메뉴번호, 메뉴가격, 메뉴부가세포함가격
-- 단, 부가세포함가격 내림차순 정렬
SELECT
    menu_code
  , menu_price
  , menu_price * 1.1 AS 부가세포함가격
FROM
    tbl_menu
ORDER BY
--    menu_price * 1.1 DESC   -- 산술연산식 작성 가능
--    부가세포함가격 DESC    -- 별칭 작성 가능 (SELECT절 수행 후기 때문에)
    3 DESC      -- 컬럼 순번 작성 가능
;

SELECT
    category_code
  , category_name
  , ref_category_code
FROM
    tbl_category
ORDER BY
--    ref_category_code ASC         -- 오름차순 정렬시 기본적으로 NULL이 상단에 위치함 
--    ref_category_code IS NULL ASC -- 오름차순 정렬시 NULL을 하단에 위치시키고자 할 경우 
--    ref_category_code DESC        -- 내림차순 정렬시 기본적으로 NULL이 하단에 위치함 
    ref_category_code IS NULL DESC, ref_category_code DESC -- 내림차순 정렬시 NULL을 상단에 위치시키고자 할 경우
;

-- ========================================================================================

/*
    ## LIMIT 절 ##
    1. 출력되는 행의 개수를 제한하는 구문 
    2. 주로 ORDER BY절로 원하는 기준으로 정렬한 뒤 LIMIT절을 이용해서 출력 개수 제한둠 
       (Top-N분석, 페이징 처리) 
    3. 표현법
       LIMIT [offset,] row_count
       
       > offset    : 출력을 시작할 행수 (인덱스)
       > row_count : 출력 개수
*/

-- Top-n분석
-- 비싼 메뉴 순으로 조회 
SELECT
    menu_code
  , menu_name
  , menu_price
FROM
    tbl_menu
ORDER BY
    menu_price DESC
  , menu_name ASC
LIMIT
--    0, 5      -- 상위 5개만 조회
--    5         -- offset 생략시 기본적으로 0으로 간주
    1, 10       -- 2번째 행부터 10개 조회
;

-- 페이징 처리 
-- 총 21건의 데이터를 한 페이지에 5건씩 출력 (총 5페이지 == 올림(전체수/한페이지당수))


SELECT
    *
FROM
    tbl_menu
ORDER BY
    menu_code DESC
LIMIT
--    0, 5    -- 1페이지
--    5, 5    -- 2페이지
--    10, 5   -- 3페이지
--    15, 5   -- 4페이지
    20, 5     -- 5페이지(마지막페이지)
;