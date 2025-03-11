/*
    ## SQL문 종류
    1. DQL (Data Query Language) : 데이터 질의 언어
        - SELECT : 데이터 조회
        
    2. DML (Data Manipulation Language) : 데이터 조작 언어 
        - INSERT : 데이터 삽입
        - UPDATE : 데이터 수정
        - DELETE : 데이터 삭제
    3. DDL (Data Definition Language) : 데이터 정의 언어
        - CREATE : 데이터 구조 생성
        - ALTER : 데이터 구조 변경
        - DROP : 데이터 구조 삭제
    3. DCL (Data Control Language) : 데이터 제어 언어
        - GRANT : 권한 부여
        - REVOKE : 권한 철회
        
        
    4. TCL (Transaction Control Language) : 트렌잭션 제어 언어
        - COMMIT : 트랜잭션 확정
        - ROLLBACK : 트랜잭션 확정
*/

-- 현재 선택된 database의 모든 테이블 조회
show tables;

-- 특정 데이블의 구조 확인(컬럼, 컬럼타입, null허용여부, key, ...) - Schemas에서 바로 확인도 가능
DESC tbl_menu;

SELECT * FROM tbl_category; -- 12행
SELECT * FROM tbl_menu;
SELECT * FROM tbl_order;
SELECT * FROM tbl_order_menu;
SELECT * FROM tbl_payment;
SELECT * FROM tbl_payment_order;


/*
    ## SELECT 문
    1. DQL(Query) 명령문 (DML 의 하위 분류
    2. 정의된 데이블이 데이터를 조회/ 검색 하는 명령문
    3. 조회 결과를 ResultSet(결과 집합)이라 함
    4. 표현법
        (5) SELECT 컬럼, 산술식, 함수식, ... AS 별칭
        (1) [FROM 테이블명]
        (2) [WHERE 조건식]
        (3) [GROUP BY 그룹기준]
        (4) [HAVING 조건식]
        (6) [ORDER BY 정렬기준 정렬방식]
        (7) [LIMIT 숫자, 숫자]
*/

-- 단일 컬럼 데이터 조회
SELECT menu_name FROM tbl_menu; -- 테이블 tbl_menu에서 menu_name 컬럼만 확인하겠다.

-- 여러 컬럼 조회
SELECT 
    menu_code
    , menu_name
    , menu_price
FROM
    tbl_menu
;

-- 모든 걸럼 조회
SELECT
    * -- 모두, 단 실무에서는 사용 지양,컬럼 종류 파악 어려움
FROM
    tbl_menu
;

SELECT
    menu_code
    ,menu_name
    ,menu_price
    ,category_code
    ,orderable_status
FROM
    tbl_menu
;


/*
    ## 산술연산
    SELECT절에 산술연산식 작성시 산술 연상 결과 조회
*/
SELECT 6+4;
SELECT
    6/4 -- 나누기
    ,6 div 4; -- 몫
SELECT
    6%4
    ,6 mod 4;

-- 부가세 포함 계산
SELECT
    menu_name
    , menu_price
    , menu_price + (menu_price * 0.1)
    , menu_price + cast((menu_price * 0.1) as signed integer)
FROM
    tbl_menu
;

/*
    ## 컬럼 별칭(Alias)
    조회되는 ReaultSet의 컬럼명(헤더) 부분을 내가 원하는 별칭으로 조회 가능
    
    [표현법]
    컬럼명 AS 별칭
             "별칭"
             `별칭`
             
    부여할 별칭이 아래와 같은 경우 "",'',``으로 감싸야됨
    1. 숫자로 시작
    2. 공백이나 특수문작 있을 경우
*/

SELECT
    menu_name 메뉴이름
    , menu_price '메뉴 가격'
    , menu_price * 0.1 AS "메뉴 부가세"
    , menu_price * 1.1 AS `메뉴 부가세 포함 가격`
FROM
    tbl_menu
;


/*
    ## 리터럴
    임의로 지정한 문자값
    SELECT절에 리터럴 제시시 마치 존재하는 데이터처럼 조회 가능
*/
SELECT
    menu_name AS 메뉴이름
    , menu_price * 1.1 AS "부가세포함 가격"
    , '원' AS "단위"
FROM
    tbl_menu
;

/*
    ## 문자열 연결
    여러 컬럼값들을 마치 하나의 컬럼인거 처럼 연결하거나
    리터럴과도 연결 가능
    
    [표현법]
    CONCAT(값1, 값2, ...)
*/

SELECT
    CONCAT('홍','길','홍');


SELECT
    menu_name
    , CONCAT(menu_price, '원')
FROM
    tbl_menu;


/*
    ## DISTINCT
    컬럼의 중복값을 한번씩 표현하고자 할 때 사용
    
    DISTINCT를 두개 이상 작성했을 시 중복제거 되었을 때 행의 수가 다르기 때문에 안됨
    SELECT DISTINCT -> 이건 가능
*/
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


-- ========================================================================================================================================================================

/*
    ## WHERE 절
    1. 테이블의 데이터 중 원하는 데이터만 선택적으로 조회할 때 사용 - 일부 행만
    2. WHERE 조건식
                ㄴ> 컬럼명, 연산자, 표현식 등을 결합해서 작성
*/

/*
    ## 비교 연산자
    1. 값 간의 관계를 비교하기 위해 사용
    2. 비교 결과는 논리값(TRUE, FALSE, NULL)
    3. 비교하는 두 값은 동일한 데이터 타입이어야됨
    4. 종류
        =            : 같은지
        !=, <>       : 다른지
        >, >=, <, <= : 크고 작음을 비교
        BETWEEN AND  : 특정 범위에 포함되는지 비교
        [NOT] LIKE   : 패턴 부합 여부 비교
        IS [NOT] NULL: NULL 비교 여부
        [NOT] IN     : 목록에 포함/미포함 되는지 비교
*/

SELECT
    menu_name
    , menu_price
    , orderable_status
FROM
    tbl_menu
WHERE
--      orderable_status = 'N' -- MySQL은 소문자도 됨,근데 맞춰서 쓰는게 좋음
--    BINARY orderable_status = 'n' -- 대소문자 비교햐소 비교하고자 할 경우
--        orderable_status != 'Y'
    orderable_status <> 'Y'
;
SELECT 
    menu_name, 
    menu_price, 
    orderable_status
FROM
    tbl_menu
WHERE
    menu_price >= 13000
;

/*
    ## 논리연산자
    1. 여러 조건 결과를 하나의 논리 결과로 만들어줌
    
        && AND
        || OR 
         ! NOT : 조건에 대한 반대값으로 반환
    
    MySQL은 숫자 0을 FALSE로 간주
    0외의 숫자를 TRUE로 간주
    문자열은 0(FALSE)로 간주
*/
SELECT 
    1 AND 1,
    2 && 2,
    - 1 && 1,
    1 && 'abc',
    1 AND NULL,
    NULL && NULL,
    0 AND NULL
;

SELECT
    1 OR 1            
    , 2||2              
    , -1 || 1           
    , 1 || 'abc'        
    , 1 OR NULL       
    , NULL || NULL     
    , 0 OR NULL         -- F or NULL -> NULL
;

-- 가격이 5,000원 초가이며, 카테고리 번로가 10인 메뉴 조회
SELECT
    *
FROM
    tbl_menu
WHERE
    menu_price > 5000
AND category_code = 10
;

SELECT 
    *
FROM
    tbl_menu
WHERE
    orderable_status = 'Y'
AND category_code = 10
;


SELECT 
    *
FROM
    tbl_menu
WHERE
    (category_code = 4 
OR menu_price = 9000) -- AND 연산이 OR 연산자보다 우선순위가 높음
AND menu_code >= 10
;

/*
    ## BETWEEN AND
    숫자, 문자열, 날짜및 시간 값의 범위에 대한 조건 제시시 사용
    
    [표현법]
    비교대상 BETWEEN 하한값 AND 상한값
    
    비교대상 값이 하한값 이상 상한값 이하일 경우 T
*/

-- 가격이 10000~25000원 메뉴
SELECT
    menu_name
    , menu_price
    , category_code
FROM
    tbl_menu
WHERE
--    menu_price >= 10000 AND menu_price <= 25000;
    menu_price BETWEEN 10000 AND 25000;


-- 부정표현
SELECT 
    menu_name
  , menu_price
  , category_code
FROM
    tbl_menu
WHERE
--    menu_price NOT BETWEEN 10000 AND 25000;
    NOT menu_price BETWEEN 10000 AND 25000;


SELECT 
    *
FROM
    tbl_menu
WHERE
    NOT menu_price BETWEEN '가' AND '힣'
;

/*
    ## LIKE
    비교값이 지정한 패턴을 만족하는지 비교해주는 연산자
    패턴 작성시 &, _ 와일드 카드 작성 가능
    
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
    menu_name LIKE '마%' -- 마로 시작하고 뒤에 나머지
;

-- 메뉴명에 '마늘'이 포함되어있는 메뉴
SELECT
    menu_name
    , menu_price
FROM
    tbl_menu
WHERE
    menu_name LIKE '%마늘%'
;

-- 메뉴명이 밥으로 끝나는 메뉴
SELECT
    *
FROM
    tbl_menu
WHERE
    menu_name LIKE '%밥'
;

-- 주스 앞글자가 3글자인 메뉴
SELECT
    *
FROM
    tbl_menu
WHERE
    menu_name LIKE '___쥬스' -- 떙떙땡쥬스
;

-- '갈치'가 포함되어있지 않은 메뉴 조회
SELECT
    *
FROM 
    tbl_menu
WHERE
    menu_name LIKE '%갈치%'
;

SELECT
    *
FROM 
    tbl_menu
WHERE
    menu_name NOT LIKE '%갈치%'
;

/*
    ## IN
    비교값이 제시한 목록 중에 존재할 경우 TRUE를 반화해주는 연산자
    
    [표현법]
    비교대상 IN (값1, 값2, ...)
    
*/
SELECT
    menu_name
    , category_code
FROM
    tbl_menu
WHERE
 --    category_code = 4 OR category_code = 5 OR category_code = 6;
    category_code NOT IN (4,5,6);

/*
    ## IS NULL
    비교대상이 NULL인지 비교해주는 연산자
*/

-- 대분류 카테고리만 조회 (상위 카테고리번호가 NULL인 데이터 조회)
SELECT
    category_name
    , ref_category_code
FROM
    tbl_category
WHERE
--    ref_catefory_code = NULL 비교 안됨
    ref_category_code IS NULL; -- 비교됨
    -- ref_category_code IS NOT NULL; -- 비교-- 
;


-- =====================================================================================================================================================================
/*
## ORDER BY 절
1. 조회 결과를 정렬하고자 할때 사용
2. 오름차순 정렬(ASC)과 내림차순 정렬(DESC)
- ORDER BY 정렬기준 [IS NULL] [정렬방식]
*/
SELECT
    menu_code
    , menu_name
    , menu_price
FROM
    tbl_menu
ORDER BY
--    menu_price ASC -- 가격 기준 오름차순
--    menu_price -- 정렬 방식 생략시 오름차순
--    menu_price DESC -- 가격 내림차순
    menu_price DESC, menu_name ASC
;

use menudb;

-- 메뉴번호, 메뉴가격, 메뉴부가세 포함 가격, 부가세  포함가격 내림차순 정렬
SELECT menu_code, menu_price, menu_price*1.1 AS IncludeTAX 
FROM tbl_menu
ORDER BY IncludeTAX DESC;

SELECT category_code, category_name, ref_category_code
FROM tbl_category
ORDER BY
-- ref_category_code IS NULL ASC;
-- ref_category_code ASC;
-- ref_category_code DESC;
ref_category_code IS NULL DESC, ref_category_code DESC;
