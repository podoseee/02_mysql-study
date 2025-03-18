-- VIEW
USE menudb;

-- 한식 메뉴 (카테고리 번호 4) 만 조회되는 VIEW 생성
CREATE OR REPLACE VIEW vw_korean
AS
SELECT
    menu_code
    , menu_name
    , menu_price
    , category_code
    , orderable_status
FROM
    tbl_menu
WHERE
    category_code = 4;

SELECT * FROM vw_korean;

-- 베이스테이블 정보 변경
INSERT INTO tbl_menu VALUES(null, '식혜맛국밥', 5500, 4, 'Y');


-- VIEW를 통한 DML
SHOW VARIABLES LIKE 'autocommit';
SET autocommit = 'OFF';

SELECT * FROM vw_korean;

-- 1. VIEW를 통한 INSERT
INSERT INTO vw_korean VALUES(null, '초코맛국밥', 6000, 4, 'Y');
INSERT INTO vw_korean(menu_name,menu_price,orderable_status) 
VALUES ('수정과맛국밥', 6000, 'Y');

SELECT * FROM tbl_menu;

-- 2. VIEW를 통한 UPDATE
UPDATE 
    vw_korean 
SET 
    menu_name = '아빠손칼국수'
    , menu_price = 80000
WHERE
    menu_code = 5;

SELECT * FROM tbl_menu;

-- 3. VIEW를 통한 DELETE
DELETE
FROM vw_korean
-- WHERE menu_code = 1;
WHERE menu_code = 5;

ROLLBACK;

-- DML 조작이 불가능한 경우
CREATE OR REPLACE VIEW vw_korean
AS
SELECT
    menu_code 메뉴번호
    , menu_name 메뉴명
    , menu_price 가격
    , category_code 카테고리
FROM
    tbl_menu
WHERE
    category_code = 4;

SELECT * FROM vw_korean;
SELECT * FROM tbl_menu;

INSERT INTO vw_korean VALUES(null, '솔의눈떡볶이', 40000, 4);
-- NOT NULL 제약조건이 부여되어있는 orderable_status 에 null이 들어가려고 하여 오류 발생

UPDATE vw_korean
SET 가격 = 7000 
WHERE 메뉴명 = '한우딸기국밥';
-- 정의되어있는 컬럼만을 가지고 조작시 문제 없음

UPDATE vw_korean
SET orderable_status = 'N'
WHERE 메뉴명 = '한우딸기국밥';
-- 정의되어 있지 않은 컬럼 조작시 오류

CREATE OR REPLACE VIEW vw_korean
AS
SELECT
    menu_code
    , menu_name
    , menu_price
    , category_name
    , orderable_status
FROM
    tbl_menu m
    JOIN tbl_category c ON c.category_code = m.category_code
WHERE
    category_name = '한식';

SELECT * FROM vw_korean;

INSERT INTO vw_korean VALUES(null, '초코우유', 3000, '우유', 'N');
-- 오류 발생 

UPDATE vw_korean
SET menu_price = 15000
WHERE menu_name = '생마늘샐러드';
-- tbl_menu 베이스테이블에 반영

SELECT * FROM tbl_menu;

UPDATE vw_korean
SET category_name = 'KOREAN'
WHERE category_name = '한식';
-- tbl_category 베이스테이블에 반영

SELECT * FROM tbl_category;

ROLLBACK; -- DDL문이 작성됐던 곳으로

-- WITH CHECK OPTION
CREATE OR REPLACE VIEW vw_expensive
AS
SELECT
    menu_code
    , menu_name
    , menu_price
    , category_code
    , orderable_status
FROM
    tbl_menu
WHERE
    menu_price >= 20000
WITH CHECK OPTION;

SELECT * FROM vw_expensive;

INSERT INTO vw_expensive VALUES (null, '엄마손칼국수', 15000, 4, 'Y');
-- CHECK OPTION 오류발생

INSERT INTO vw_expensive VALUES (null, '엄마손칼국수', 23000, 4, 'Y');


UPDATE vw_expensive
SET menu_price = 16000
WHERE menu_code = 18;









