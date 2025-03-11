/*
    ## GROUP BY 절 ##
    1. 특정 컬럼 값을 기준으로 전체 행(ROW)을 서브 그룹으로 그룹화 가능
    2. 둘 이상의 컬럼을 이용해 다중 그룹화 진행 가능
    3. 
    
*/
SELECT * FROM tbl_menu;

-- 카테고리별 메뉴 수 조회
select category_code, orderable_status, count(*) 
from tbl_menu 
group by category_code, orderable_status
having COUNT(*) = 1
order by category_code;













