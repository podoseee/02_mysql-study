/*
    ## SQL문 종류 ##
    1. DQL (Data Query Language) : 데이터 질의 언어 (데이터 조회용)
        - SELECT
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
        - COMMIT   (트랜잭션 확정)
        - ROLLBACK (트랜잭션 취소)
*/

-- 현재 선택된 database의 모든 테이블들 조회
show tables; 

-- 특정 테이블의 구조 확인 (컬럼, 컬럼타입, null허용여부, key 등)
desc tbl_menu;


SELECT * FROM tbl_category; -- 12개의 행
SELECT * FROM tbl_menu;  -- 21

/*
    ## select문 ##
    1. DQL 명령문 (DML의 하위분류)
    2. 정의된 테이블의 데이터를 조회/검색하는 명령문
    3. 조회 결과를 ResultSet(결과집합)이라 함
    4. 표현법 
        5 SELECT 컬럼, 산술식, 함수식, .. AS 별칭 
        1 [FROM 테이블]
        2 [WHERE 조건식]
        3 [GROUP BY 그룹기준]
        4 [HAVING 그룹조건식]
        6 [ORDER BY 정렬기준 정렬방식]
        7 [LIMIT 숫자, 숫자] // 라인범위지정가능
        실행순서
*/

-- 단일 컬럼 데이터 조회 
SELECT  menu_name FROM tbl_menu;

-- 여러 컬럼 조회
SELECT 
    menu_code
  , menu_name
  , menu_price
FROM 
    tbl_menu;
    
-- 모든 컬럼(*) 조회 (실무에서는 * 사용금지)

-- *******************************************************


-- ********************************************************

/*
    ## 컬럼 별칭(Alias) ##
    조회되는 ResultSet의 컬럼명(헤더) 부분을 내가 원하는 별칭으로 조회 가능
    
    [표현법]
    컬럼명 [AS] 별칭
    
    별칭이 숫자로 시작되거나 공란/특수문자가 있을 경우 반드시 "", '', `` 로 감싸야됨 
*/

SELECT
    menu_name 메뉴이름
  , menu_price '메뉴 가격'
  , menu_price * 0.1 AS "메뉴 부가세"
  , menu_price * 0.1 AS `메뉴 부가세 포함가격`
FROM 
 tbl_menu;
 
 /*
    ## 리터럴 ##
    임의로 지정한 문자값  
    SELECT절에 리터럴 제시 시, 마치 존재하는 데이터처럼 조회 가능
*/
SELECT
    menu_name AS 메뉴이름
  , menu_price
  , '원' AS "단위"
FROM
    tbl_menu;

/*
    ## 문자열 연결 ##
    여러 컬럼값들을 마치 하나의 컬럼인거처럼 연결하거나 
    리터럴과도 연결 가능
    
    [표현법]
    CONCAT(값1, 값2, ...)
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
    * 유의 : SELECT절에 한번만 기술가능 
*/

SELECT
    DISTINCT category_code
  -- , DISTINCT orderable_status >> SELECT절에서 한번만 쓸 수 있음. 하나의 테이블로 표현될 수 없기 때문에
FROM
    tbl_menu;
    
    
-- 이건 가능
-- 제시된 컬럼 값을 쌍으로 묶어 중복 판별     
SELECT DISTINCT
    category_code
  , orderable_status
FROM
    tbl_menu;


/*
    ## WHERE 절 ##
    1. 테이블의 데이터 중 원하는 데이터만 선택적으로 조회할 때 사용 (일부 행)
    2. WHERE 조건식
       ㄴ 컬럼명, 연산자, 표현식 등을 결함해서 작성
*/

/* 
    ## 비교 연산자 ##
    1. 값 가의 관계를 비교하기 위해 사용 
    2. 비교 결과는 논리값(TRUE/FLASE/NULL)이 됨
    3. 비교하는 두 값은 동일한 데이터 타입이어야됨
    4. 종류
       =  : 두값이 같은지 비교 (SQL은 대입연산자가 필요없음)
       != , <>  : 같지 않은지 비교
       >,<,>=,<= : 크고작음을 비교
       BETWEEN AND : 특정 범위에 포함되는지 비교 
       [NOT] LIKE  : 패턴 부합 여부 비교
       IS [NOT] NULL : NULL 여보 비교
       [NOT] IN  : 목록에 포함/미포함 되는지 비교
    */
    
SELECT
    menu_name
  , menu_price
  , orderable_status
FROM
    tbl_menu
WHERE 
    orderable_status = 'n' -- 이래도 조회되긴함(오라클은 안됨)
    -- MySQL은 기본적으로 대소문자 구분없이 
    
    -- 대소문자 구분을 원한다면
    -- BINARY orderable_status = 'n' -- 에러발생
;

-- *************************************************

-- 숫자 0을 FALSE로 간주
-- 0이외의 숫자를 TRUE로 간주
-- 문자열은 0(FALSE)로 간주
-- 연산시 NULL을 만나면 연산결과 또한 NULL이 된다. 

-- WHERER절에서 OR과 AND연산으로 조건을 작성할때
-- AND 연산이 OR연산보다 우선순위가 높음**********유의하기

       