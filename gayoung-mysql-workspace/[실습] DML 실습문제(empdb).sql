-- 문제 풀기에 앞서 위의 스크립트 실행시 만들어진 테이블을 확인한 후 풀어주세요.
SELECT * FROM tbl_product;
SELECT * FROM tbl_user;
SELECT * FROM tbl_buy;

-- tbl_product(제품), tbl_user(사용자), tbl_buy(구매내역)


-- 1. 연락처1이 없는 사용자의 사용자번호, 아이디, 연락처1, 연락처2를 조회하시오.

SELECT 
    user_no 
  , user_id
  , user_mobile1
  , user_mobile2
FROM
    tbl_user
WHERE 
    user_mobile1 IS NULL;
    
-- 2. 연락처2가 '5'로 시작하는 사용자의 사용자번호, 아이디, 연락처1, 연락처2를 조회하시오.
SELECT 
     user_no 
  , user_id
  , user_mobile1
  , user_mobile2
FROM
    tbl_user
WHERE
    user_mobile2 LIKE '5%';


-- 3. 2010년 이후에 가입한 사용자의 사용자번호, 아이디, 가입일을 조회하시오.
SELECT 
    user_no
  , user_id
  , user_regdate
FROM tbl_user
WHERE
    YEAR(user_regdate) > 2010; 
    
SELECT * FROM tbl_user;

-- 4. 사용자번호와 연락처1, 연락처2를 연결하여 조회하시오. 
-- 연락처가 없는 경우 NULL 대신 'None'으로 조회하시오.
SELECT 
    user_no
  , IFNULL(user_mobile1,'None')
  , IFNULL(user_mobile2, 'None')
FROM 
    tbl_user
;

-- 5. 지역별 사용자수를 조회하시오. 

SELECT 
    user_addr 지역
  , COUNT(*) "지역별 사용자수"
FROM 
    tbl_user
GROUP BY
    user_addr;
    
-- 6. '서울', '경기'를 제외한 지역별 사용자수를 조회하시오.
SELECT 
    user_addr 지역
  , COUNT(*) "지역별 사용자수"
FROM 
    tbl_user
GROUP BY
    user_addr 
HAVING 
    user_addr NOT IN ('서울', '경기');
    
-- 7. 구매내역이 없는 사용자를 조회하시오. (아이디순으로 오름차순정렬)
SELECT 
    *
FROM 
    tbl_user
WHERE
    user_no NOT IN (SELECT 
                        user_no
                    FROM tbl_buy)
ORDER BY user_id;

-- 8. 카테고리별 구매횟수를 조회하시오. 
SELECT * FROM tbl_product;
SELECT * FROM tbl_user;
SELECT * FROM tbl_buy;

SELECT
    prod_category 카테고리
  , COUNT(*) 구매횟수 
FROM 
    tbl_buy LEFT JOIN tbl_product USING (prod_code)
GROUP BY 
    prod_category;
    
-- 9. 아이디별 구매횟수를 조회하시오.
SELECT
    user_id 아이디
  , COUNT(*) 구매횟수 
FROM 
    tbl_buy LEFT JOIN tbl_user USING (user_no)
GROUP BY 
    user_id;
   
-- 10. 아이디별 구매횟수를 조회하시오. 
--    구매 이력이 없는 경우 구매횟수는 0으로 조회하고 아이디의 오름차순으로 조회하시오.


    
    
    





