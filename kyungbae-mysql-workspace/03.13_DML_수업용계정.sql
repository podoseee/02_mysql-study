SHOW VARIABLES LIKE 'autocommit';
SET autocommit = OFF;

-- DBL 문
-- INSERT
use menudb;
SELECT * FROM tbl_menu;
DESC tbl_menu;
-- 문법1
INSERT INTO tbl_menu VALUES(23, '바나나해장국', 8500, 4, 'Y');
INSERT INTO tbl_menu VALUES(24, '초코번데기탕', 6000);
INSERT INTO tbl_menu VALUES(24, '초코번데기탕', 6000, 4, 'Y', 'TEST');

-- 문법2
INSERT INTO tbl_menu(menu_name, menu_price, orderable_status, category_code)
VALUES('초코번데기탕', 6000, 'Y', 7);
-- menu_code -> auto_increment로 자동으로 값이 들어감

INSERT INTO tbl_menu(menu_name, menu_price, orderable_status)
VALUES('매생이케이크', 7500, 'Y');

-- * 여러행 일괄 삽입 기능
INSERT INTO
    tbl_menu
VALUES(NULL, '참치아이스크림', 1600, 12, 'Y')
    , (NULL, '숯커피', 3500, 11, 'Y');

INSERT INTO
    tbl_menu(menu_name, menu_price, orderable_status)
VALUES('매생이초콜릿', 500, 'N')
    , ('에스프레소번데기', 2000, 'Y');

-- *데이터값 작성시 서브쿼리 가능
SELECT * FROM tbl_menu;
INSERT INTO
    tbl_menu(menu_name, menu_price, category_code, orderable_status)
VALUES('곱창에스프레소', 5000, (SELECT category_code
                                FROM tbl_category
                                WHERE category_name = '커피'), 'Y');

-- replace
-- INSERT INTO tbl_menu VALUES(18, '참기름소주', 5000, 10, 'Y');
REPLACE INTO tbl_menu VALUES(18, '참기름소주', 5000, 10, 'Y'); -- 중복 대체
REPLACE /*INTO*/ tbl_menu VALUES(40, '참치소주', 5000, 10, 'Y'); -- 중복 없으면 삽입

COMMIT;

-- =======================================================================
-- UPDATE
-- 매생이초콜릿 메뉴의 카테고리번호를 10으로 수정
UPDATE
    tbl_menu
SET
    category_code = 10
WHERE
    menu_name = '매생이초콜릿';

ROLLBACK;

-- 에스프레소번데기 카테고리 10, 가격 3000, 메뉴명 변경
UPDATE
    tbl_menu
SET
    category_code = 10,
    menu_price = 3000,
    menu_name = '에스프레소번데기탕'
WHERE
    menu_code = 29;
    
SELECT * FROM tbl_menu;

-- 전체 메뉴의 가격을 10프로 인상
UPDATE
    tbl_menu
SET
    menu_price = menu_price * 1.1;

SELECT * FROM tbl_menu;

-- * UPDATE내 SUBQUERY 사용
-- 커피 메뉴들의 가격을 5000으로 수정
UPDATE
    tbl_menu
SET
    menu_price = 5000
WHERE
    category_code = (SELECT category_code
                        FROM tbl_category
                        WHERE category_name = '커피');

-- 22번 메뉴의 가격을 우럭스무디 메뉴가격으로 수정
UPDATE
    tbl_menu
SET
    menu_price = (SELECT menu_price
                    FROM tbl_menu
                    WHERE menu_name = '우럭스무디')
                    -- 서브쿼리 테이블이 같아서 오류
WHERE
    menu_code = 22;

-- 인라인뷰 활용
UPDATE
    tbl_menu
SET
    menu_price = (SELECT *
                    FROM(
                        SELECT menu_price
                        FROM tbl_menu
                        WHERE menu_name = '우럭스무디'
                    ) wooruk
                )
WHERE
    menu_code = 22;

USE menudb;

COMMIT;
-- ========================================================
-- DELETE
/*DELETE
FROM tbl_menu;*/
SELECT * FROM tbl_menu;
ROLLBACK;

-- 숯커피 메뉴 삭제
DELETE
FROM tbl_menu
WHERE menu_name = '숯커피';

-- 카테고리가 10인 메뉴들 삭제
DELETE
FROM tbl_menu
WHERE category_code = 10;

-- 카테고리 커피 메뉴 삭제
DELETE
FROM tbl_menu
WHERE category_code = (SELECT category_code
                        FROM tbl_category
                        WHERE category_name = '커피');

-- 민트미역국과 동일한 카테고리의 메뉴들 삭제
DELETE
FROM tbl_menu
WHERE category_code = (SELECT *
                        FROM(
                              SELECT category_code
                              FROM tbl_menu
                              WHERE menu_name = '민트미역국'
                            ) mint
                        );

-- LIMIT 활용
DELETE
FROM tbl_menu
LIMIT 2;


DELETE
FROM tbl_menu
ORDER BY menu_price DESC
LIMIT 2;



