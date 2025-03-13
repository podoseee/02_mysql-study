SHOW VARIABLES LIKE 'autocommit';
SET autocommit = OFF;
-- 자동 커밋 비활성화

/*
    ## DML ##
    1. Data Manipulation Language
    2. 데이터 좆ㄱ어 - 데이터를 조작하기 위해 사용되는 언어
    3. 종류
       1) 삽입 : INSERT
       2) 수정 : UPDATE
       3) 삭제 : DELETE
       [4) 조회 : SELECT]
*/

/*
    ## INSERT ##
    1. 새로운 행을 추가하는 구문
    2. 테이블의 행 수가 증가됨
    3. 문법
       1) INSERT INTO 테이블명 VALUES(입력값1, 입력값2, ...)
            : 테이블에 존재하는 모든 컬럼 순번대로 값을 전달해야됨
       2) INSERT INTO 테이블명(컬럼1, 컬럼2, ..) VALUES(입력값1, 입력값2, ..)
            : 지정한 컬럼 순번대로 값을 전달해야됨
              ㄴ 지정안된 컬럼에는 Default값이 설정되어있을 경우 Default값이 들어감
                                                       아닐 경우 NULL이 들어감
*/
SELECT * FROM tbl_menu;

DESC tbl_menu;

-- 문법1)
INSERT INTO tbl_menu VALUES(23, '바나나맛해장국', 8500, 4, 'Y');
INSERT INTO tbl_menu VALUES(24, '초코맛번데기탕', 6000);
INSERT INTO tbl_menu VALUES(24, '초코맛번데기탕', 6000, 4, 'Y', 'test');

-- 문법2)
INSERT INTO tbl_menu(menu_name, menu_price, category_code, orderable_status)
VALUES('초코맛번데기탕', 6000, 7,'Y');
-- auto_increment로 설정되어있는 menu_code에는 자동으로 증가된 값이 들어감

INSERT INTO tbl_menu(menu_name, menu_price, orderable_status)
VALUES('매생이케이크', 25000, 'N');
-- 컬럼이 지정안된 category_code에는 기본적으로 NULL이 들어감

-- * 여러행 일괄 삽입 가능

INSERT INTO
    tbl_menu
VALUES (null, '참치맛아이스크림', 1600, 12, 'Y'),
       (null, '숯커피', 3500,  11, 'Y');
       
INSERT INTO
    tbl_menu(menu_name, menu_price, orderable_status)
VALUES ('매생이초콜릿', 500, 'N'),
       ('에스프레스번데기', 2000, 'Y');
       
SELECT * FROM tbl_menu;

-- * 데이터값 작성시 서브쿼리도 가능
INSERT 
    tbl_menu(menu_name, menu_price, category_code, orderable_status)
values ('곱창에스프레소', 5000, (SELECT category_code
                                FROM tbl_category 
                                WHERE category_name = '커피'), 'Y');
                                
 /*
    ## REPLACE ##
    INSERT PRIMARY KEY 또는 UNIQUE KEY가 중복될 여지가 있을 경우
    REPLACE를 통해 중복된 데이터를 덮어씌울 수 있음
    정확히는 삭제되었다가 다시 삽입되는 구조
 */
-- INSERT INTO tbl_menu VALUES(17, '참기름소주', 5000, 10, 'Y'); -- 중복키가 존재하기 떄문에 오류 발생

REPLACE INTO tbl_menu VALUES(17, '참기름소주', 5000, 10, 'Y'); -- 중복키가 존재하므로 수정
REPLACE /*INTO*/ tbl_menu VALUES(40, '참치액젓소주', 5000, 10, 'Y'); -- 중복키가 존재하지 않으므로 삽입

COMMIT;

/*
    ## UPDATE ##
    1. 테이블에 기록되어 있는 기존의 컬럼값을 수정하는 구문
    2. 테이블의 행 수는 변화가 없음
    3. 문법
       UUPDATE 테이블명
       SET 컬럼명 = 바꿀값,
           컬럼명 = 비꿀값;
           ...
       [WHERE 조건]; -- 조건절이 없으면 전체 행 대상으로 다 수정되므로 유의할 것!!
*/

-- 매생이초콜릿 메뉴이 카테고리번호를 10으로 변경
UPDATE
    tbl_menu
SET
    category_code = 10;
    
SELECT * FROM tbl_menu;

ROLLBACK; -- 마지막 commit시점으로 돌아감 (즉, 마지막 commit 시점 이후에 발생되었던 변경사항들이 취소됨)

UPDATE
    tbl_menu
SET
    category_code = 10
WHERE
    menu_name = '매생이초콜릿';
    
-- 에스프레소번데기 메뉴의 카테고리번호를 10으로, 가격을 3000원으로, 메뉴명을 에스프레소번데기탕 으로 변경
UPDATE
    tbl_menu
SET
    category_code = 10
  , menu_price = 3000
  , menu_name = '에스프레소번데기탕'
WHERE
    menu_name = '에스프레스번데기';

-- 전체 메뉴의 가격을 10프로 인상시키는 UPDATE문
UPDATE
    tbl_menu
SET
    menu_price = menu_price * 1.1;

SELECT * FROM tbl_menu;

-- * update내에 서브쿼리 활용 가능

-- 커피 메뉴들의 가격을 5000원 수정
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
                   WHERE menu_name = '우럭스무디') -- oracle 에서는 가능하나 mysql에서는 자기 자신 테이블의 데이터 사용시 1093 에러 발생
WHERE
    menu_code = 22;
    
UPDATE
    tbl_menu
SET
    menu_price = (
                    SELECT menu_price
                    FROM (
                          SELECT menu_price
                            FROM tbl_menu
                           WHERE menu_name = '우럭스무디'
                         ) wooruk
                  ) -- 인라인뷰로 임시테이블로 사용하게 하면 해결 가능
WHERE
    menu_code = 22;

SELECT * FROM tbl_menu;

COMMIT;

/*
    ## DELETE ##
    1. 테이블의 행을 삭제하는 구문
    2. 테이블의 행 개수가 줄어듦
    3. 문법
       DELETE
       FROM 테이블명
       [WHERE 조건]; -- 조건절 제시안할 경우 전체 행 삭제되니 유의할 것
*/
DELETE
FROM tbl_menu;

SELECT * FROM tbl_menu;

ROLLBACK;

-- 숯커피 메뉴 삭제하기
DELETE
FROM tbl_menu
WHERE menu_name ='숯커피';

-- 카테고리가 10인 메뉴들 삭제하기
DELETE
FROM tbl_menu
WHERE category_code = 10;

-- 실습. 카테고리가 커피인 메뉴 삭제하기
DELETE
FROM tbl_menu
WHERE category_code = (SELECT category_code
                         FROM tbl_category
                        WHERE category_name = '커피');

-- 실습. 민트미역국과 동일한 카테고리의 메뉴들 삭제하기
DELETE
FROM tbl_menu
WHERE category_code = (
                        SELECT category_code
                         FROM (
                                SELECT category_code
                                 FROM tbl_menu
                                WHERE menu_name = '민트미역국'
                               ) mint
                        );
                        
SELECT * FROM tbl_menu;

-- * LIMIT 활용도 가능
DELETE
FROM tbl_menu
LIMIT 2; -- offset 지정은 안됨

DELETE
FROM tbl_menu
ORDER BY menu_price DESC
LIMIT 2;
                                
                                
                                