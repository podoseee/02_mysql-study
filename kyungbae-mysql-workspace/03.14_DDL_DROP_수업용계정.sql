-- DDL
-- DROP
DROP TABLE IF EXISTS tbl_product;

DROP TABLE IF EXISTS tbl_user_grade;
-- 에러 : 참조중인 자식이 있어서 삭제 불가

-- 외래키 제약조건을 잠시 비활성화
SET FOREIGN_KEY_CHECKS = 0; -- 비활성화
SET FOREIGN_KEY_CHECKS = 1; -- 활성화

-- TRUNCATE
SELECT * FROM user_tbl;
TRUNCATE TABLE user_tbl;








