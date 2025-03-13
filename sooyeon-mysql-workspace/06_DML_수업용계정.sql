SHOW VARIABLES LIKE 'autocommit';
SET autocommit = OFF;
-- 자동 커밋 비활성

/*
    ## DML
    1. Date Manipulation Language
    2. 데이터 조작어
    
    1. INSERT
    2. UPDATE
    3/ DELETE
    4. SELECT
    
*/


/*
    ## INSERT
    1. 새로운 행을 추가하는 구문
    2. 테이블의 행 수가 증가됨
    
        - INSERT INTO 테이블명 VALUES(입력값1, 입력값2, ...)
            테이블에 컬럼 순번대로 값을 전달해야함
        - INSERT INTO 테이블명(컬럼1, 컬럼2, ...) VALUES(입력값1, 입력값2, ...)
            지정한 컬럼의 순번대로 값을 전달해야함
            지정하지 않은 컬럼에서는 기본값이 들어감 (설정해두지 않으면 NULL이 들어감)
*/

SELECT * FROM tbl_menu;

DESC tbl_menu;

-- 사용안하는방식
INSERT INTO tbl_menu VALUES(23,'바나나맛해장국',8500,4,'Y');

-- menu_code는 마지막 데이터의 +1 한 값으로 자동으로 들어간다.
INSERT INTO tbl_menu(menu_name,menu_price,category_code,orderable_status)
VALUES('초코번데기탕',6000,7,'Y');

-- 선택이 안된컬럼에서는 기본적으로 NULL이 들어감
INSERT INTO tbl_menu(menu_name,menu_price,orderable_status)
VALUES('매생이케이크',25000,'N');


-- 데이터 값 작성시 서브쿼리 가능
INSERT INTO
    tbl_menu(menu_name,menu_price,category_code,orderable_status)
VALUES 
    ('곱창에스프레소',5000,(SELECT category_code
                            FROM tbl_category
                            WHERE category_name = '커피'),'Y');



-- 여러행 일괄 삽입 가능
INSERT INTO
    tbl_menu
VALUES (null, '참치맛아이스크림',1600,12,'Y'),
        (null, '숯커피',3500,11,'Y')
;

INSERT INTO
    tbl_menu(menu_name, menu_price, orderable_status)
VALUES('매생이초콜릿',500,'N'),
        ('에스프레스번데기',2000,'Y')
;



/*
    ## REPLACE
    INSERT PRIMARY KEY 또는 UNIQUE KEY가 중복될 여자기 있을 경우
    REPLCE를 통해 중복된 데이터로 덮어씌움
    삭제 -> 삽입
*/
-- INSERT INTO tbl_menu VALUES(17,'참기름소주',5000,10,'Y'); 중복키가 존재하여 오류 발생
REPLACE INTO tbl_menu VALUES(17,'참기름소주',5000,10,'Y');
REPLACE tbl_menu VALUES(40,'참치액젓소주',5000,10,'Y');

COMMIT;










/*
    ## UPDATE
    1. 테이블에 기록되어있는 기존의 컬럼값을 수정하는 구문
    2. 테이블의 행 수는 변화가 없음
    3. 문법
        UPDATE 테이블명
        SET 컬럼명 = 바꿀값,
            컬럼명 = 바꿀값,
            ...
    [WHERE 조건]; 조건절이 없으면 전체 행 대상으로 다 수정되므로 유의해야한다.
*/

-- 매생이 초콜릿 메뉴의 카테고리벊로 10으로 변경
UPDATE
    tbl_menu
SET
    category_code = 10;

SELECT * FROM tbl_menu;

ROLLBACK;

UPDATE
    tbl_menu
SET
    category_code = 10
WHERE
    menu_name = "매생이초콜릿"
;

UPDATE tbl_menu
SET
    category_code = 100,
    menu_price = 3000,
    menu_name = "에스프레소번데기탕"
WHERE
    menu_name = "에스프레스번데기";

UPDATE 
    tbl_menu
SET
    menu_price = menu_price*1.1;


-- UPDATE내에 서브쿼리 활용 가능
-- 커피 메뉴들의 가격을 5000원 수정
UPDATE
    tbl_menu
SET
    menu_price = 5000
WHERE
    category_code = (SELECT category_code FROM tbl_category WHERE category_name = "커피")
;

-- 22번 메뉴 가격 우럭스무디 가격으로 수정
-- 서브쿼리에서 만약 사장 상위 쿼리에서 사용하고있는 테이블을 사용하면 오류가 남(오라클은 가능)  -  Error Code 1093
-- UPDATE
--     tbl_menu
-- SET
--     menu_price = (SELECT menu_price FROM tbl_menu WHERE menu_name = "우럭스무디")
-- WHERE
--     menu_code = 22
-- ;

UPDATE
    tbl_menu
SET
    menu_price = (
                    SELECT menu_price
                    FROM (
                              SELECT menu_price 
                              FROM tbl_menu 
                              WHERE menu_name = "우럭스무디"
                        )
                    wooruk
                ) 
WHERE
    menu_code = 22
;
    
SELECT * FROM tbl_menu WHERE menu_code = 22;
SELECT * FROM tbl_menu WHERE menu_name =  "우럭스무디";

COMMIT;








/*
    ## DELETE
    1. 테이블의 행을 삭제하는 구문
    2. 테이블 행 개수가 줄어듦
    
    DELETE
    FROM 테이블명
    WHERE 어떤 행
    ;
*/
DELETE
FROM tbl_menu; # 다 삭제됨

ROLLBACK; # 마지막 커밋 시점으로 이동
SELECT * FROM tbl_menu;


-- 숯커피 메뉴 삭제
DELETE
FROM tbl_menu
WHERE menu_name = "숯커피"
;
SELECT * FROM tbl_menu WHERE menu_name = "숯커피"; # 0 row(s) returned

DELETE
FROM tbl_menu
WHERE category_code = 10;

-- 실습. 카테고리가 커피인 메뉴 삭제하기
DELETE
FROM tbl_menu
WHERE category_code = (SELECT category_code FROM tbl_category WHERE category_name = "커피");

-- 실습. 민트미역국과 동일한 카테고리의 메뉴들 삭제하기
DELETE
FROM tbl_menu
WHERE category_code = (
                        SELECT category_code
                        FROM (SELECT category_code FROM tbl_menu WHERE menu_name = "민트미역국")
                        MINT
                    )
;

-- LIME 활용도 가능
DELETE
FROM tbl_menu
ORDER BY menu_price DESC
LIMIT 2
;   
