/*
    ## view
    1. 쿼리문을 저장해 둘 수 있는 데이터베이스 객체
    2. 다른 테이블에 있는 데이터를 보여줄 뿐 데이터 자체를 ㅗ함하고 있진 않음
        - 물리적인 실제 테이블과의 링크 개념
    3. 뷰를 사용하면 특정 사용자가 원본 테이블에 접근하여 모든 데이터를 보게 하는 게 아니라 일부만 보여지도록 할 수 잇음
    
    CREATE [OR REPLCASE] VIEW 뷰명  -- * OR REPLACE 옵션 : 기존에 동일한 이름의 뷰가 존재할 경우 대체
    AS
    저장시킬쿼리문;
*/

-- 한식메뉴 (카테고리번호가 4)따로 조회되는 view 생성
CREATE OR REPLACE VIEW vw_menu_korean
AS
SELECT
    menu_code
    ,menu_name
    ,menu_price
    ,category_code
    ,orderable_status
FROM
    tbl_menu
WHERE
    category_code = 4
;
SELECT * FROM vw_menu_korean;

-- 베이스테이블의 정보가 변경되면 VIEW 결과도 같이 변경
INSERT INTO tbl_menu VALUES(NULL,'식혜맛국밥',5500,4,'Y');







/*
    VIEW 를 통한 DML
    VIEW 생성시 저장시킨 쿼리문에 그룹함수 DISTNCT, CROUP BY를 사용하지 않고
    컬럼값을 가공하지 않은 경우 VIEW를 통해 DML(INSERT, UPDATE, DELETE) 가능
*/

SHOW VARIABLES LIKE 'autocommit';
SET autocommit = 0;

SELECT * FROM vw_menu_korean;

-- 1. VIEW를 통한 INSERT
INSERT INTO vw_menu_korean VALUES(null,'초코맛국밥',6000,4,'Y');
INSERT INTO vw_menu_korean(menu_name ,menu_price,category_code,orderable_status) VALUES('수정과맛국밥',6000,4,'Y');


-- 2. VIEW를 통한 UPDATE
UPDATE
    vw_menu_korean
SET
    menu_name = '아빠손칼국수'
    ,menu_price = 80000
WHERE
--    menu_code = 1 # view 에 존재하지 않는 데이터이므로 실제 db테이블에도 반영안됨
    menu_code = 5;
;


-- 3. VIEW 를 통한 DELETE
DELETE
FROM vw_menu_korean
WHERE menu_code = 5; # 실제 DB에도 적용됨

ROLLBACK;



/*
    ## 저장된 서브쿼리에 따라 DML로 조작이 불가능한 경우
    1. 뷰에 정의되어있지 않은 컬럼으로조작하는 경우
    2. 뷰애 포함되지 않은 컬럼 중에 베이스테이블 컬럼이 NOT NULL제약조건일 경우
    3) 산술 표현식 또는 함수식이 정의되어있을 경우
    4) JOIN을 이용해 여러 테이블을 연결한 경우 
    5. DISTINCT를 포함한 경우
    6. 그룹함수나 GROUP BY절을 포함한 경우
*/
CREATE OR REPLACE VIEW vw_menu_korean
AS
SELECT
    menu_code AS '메뉴번호'
    ,menu_name AS '메뉴명'
    ,menu_price AS '가격'
    ,category_code AS '카테고리'
FROM
    tbl_menu
WHERE
    menu_code = 4;

SELECT * FROM tbl_menu;
SELECT * FROM vw_menu_korean;


-- 데이터베이스 컬럼의 제약조건이 not null일 경우 viwe에서 null데이터 추가 시 오류
-- Error Code: 1423. Field of view 'menudb.vw_menu_korean' underlying table doesn't have a default value
INSERT INTO vw_menu_korean VALUES(null, '솔의눈떡볶이',40000,4); -- orderable_status (NOT NULL)에 null이 들어가려고해서 오류

UPDATE vw_menu_korean
SET 가격 = 7000
WHERE 메뉴명 = '한우딸기국밥'; # 베이스 DB에도 적용, 정의되어있는 컬럼만을 가지고 제약조건 지켜서 조작시 문제 없

-- Error Code: 1054. Unknown column 'orderable_status' in 'field list'
UPDATE vw_menu_korean
SET orderable_status = 'N' # DB에는 있지만 VIEW에는 정의되어있지 않아서 조작 불가능
WHERE 메뉴명 = '한우딸기국밥';


CREATE OR REPLACE VIEW vw_menu_korean
AS
SELECT
    m.menu_code
    ,menu_name
    ,menu_price
    ,category_name
    ,orderable_status
FROM
    tbl_menu m
        JOIN tbl_category c ON c.category_code = m.category_code
WHERE
    category_name = '한식'
;

SELECT * FROM vw_menu_korean;
SELECT * FROM tbl_menu;
SELECT * FROM tbl_category;

-- Error Code: 1394. Can not insert into join view 'menudb.vw_menu_korean' without fields list
INSERT INTO vw_menu_korean VALUES(null, '초코우유',3000,'우유','N');

UPDATE vw_menu_korean
SET menu_price = 15000
WHERE menu_name= '생마늘샐러드'; # 베이스테이블에 반영


UPDATE vw_menu_korean
SET category_name ='KOREAN'
WHERE category_name = '한식'; # 주체 베이스테이블컬럼은 아니지만 조인한 테이블에도 반영이 가능한다.


ROLLBACK;


-- WITH CHECK OPTION : 뷰의 데이터 일관성 유지를 위해 DML을 통해 데이터 삽입및수정 시 서브쿼리의 WHERE 조건에 해당하는 것만 가능
CREATE OR REPLACE VIEW vw_menu_expensive
AS
SELECT
    menu_code
    ,menu_name
    ,menu_price
    ,category_code
    ,orderable_status
FROM
    tbl_menu
WHERE
    menu_price >= 20000
WITH CHECK OPTION               # 해당 조건에 만족하는 데이터만 수정 가능하다.
;

SELECT * FROM vw_menu_expensive;
SELECT * FROM tbl_menu;

-- Error Code: 1369. CHECK OPTION failed 'menudb.vw_menu_expensive'
# WITH CHECK OPTION 때문에 where절에 정의한 조건의 데이터만 삽입할 수 있다.(2만원 이상)
INSERT INTO vw_menu_expensive VALUES(null,'엄마손칼국수',15000,4,'Y');
INSERT INTO vw_menu_expensive VALUES(null,'엄마손칼국수',23000,4,'Y');
-- 베이스테이블인 tbl_menu에도 값이 추가된다                   26	엄마손칼국수	23000	4	Y


UPDATE vw_menu_expensive
-- SET orderable_status = 'N'  # 조작하려는메뉴의 가격이 2만원이 넘기 때문에 수정 가능 (가격을 조작하지 않더라도)
-- SET menu_price = 32000
SET menu_price = 15000
WHERE menu_code = 18;

SELECT * FROM vw_menu_expensive;

# 근
# 데
# V
# I
# W
# E
# 는
# DML 지양
# 그냥 조회만
# 근데 애초에 잘 안씀












