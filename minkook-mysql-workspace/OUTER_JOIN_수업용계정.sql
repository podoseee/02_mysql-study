/*
	## 외부 조인(Outer Join) ##
	좌측/우측 테이블을 기준으로 조인시키는 방법
	기준이 되는 테이블에는 누락되는 행 없이 조회됨
	즉 , inner Join에서 특정 테이블에 누락된 행을 같이 조회시키고자 할 때 사용
*/

-- Inner Join
use menudb;

-- LEFT OUTTER JOIN
select 
	 menu_name
	,category_code
from tbl_menu
		left  join tbl_category using(category_code);

-- 카테고리명과 상위카테고리명을 조회

select 
	  C1.category_code
	 ,C1.category_name
	 ,C1.ref_category_code
	 ,C2.category_code
	 ,C2.category_name
from
	tbl_category C1
		join tbl_category C2 on C2.category_code = C1.ref_category_code;


-- 실습 사원명과 사수명을 조회하시오
use empdb;
select 
	 e1.emp_name 사원명
	,e2.emp_name 사수명
from 
	employee e1
		join employee e2 on e2.emp_id = e1.manager_id;

/*
	## 비등가 조인 ##
	매칭 시킬 컬럼에 대한 조건을 =이 아나라 다른 연산자로 할 경우
*/

select * from employee; -- salary
select * from sal_grade; -- min_sal, max_sal

select e.emp_name
	  ,e.salary
	  ,S.SAL_LEVEL
from 
	employee e
		join sal_grade s on e.salary between s.MIN_SAL and s.MAX_SAL;


/*
	## 다중 조인()
-- 사번, 사원명 ,부서명, 직급명
*/


select A.EMP_NAME
      ,B.DEPT_TITLE
	  ,C.JOB_NAME
from 
	employee A
LEFT join department B on(A.DEPT_CODE = B.DEPT_ID)
inner join job C on(A.JOB_CODE = C.JOB_CODE)

-- 실습 사번, 사원명, 근무지역명
select A.EMP_ID
      ,A.EMP_NAME
	  ,C.LOCAL_NAME
from 
	employee A
LEFT  join department B on(B.DEPT_ID = A.DEPT_CODE)
INNER join location C on(C.LOCAL_CODE = B.LOCATION_ID)

select * from employee;
select * from department;
select * from job;
select * from location;
select * from nation;

-- 실습 사번, 사원명, 부서명, 근무지역명 ,근무국가명, 직급명 조회
select A.EMP_ID
      ,A.EMP_NAME
	  ,B.DEPT_TITLE
	  ,D.LOCAL_NAME
	  ,E.NATIONAL_NAME
	  ,C.JOB_NAME
from 
	employee A
LEFT  join department B on(B.DEPT_ID = A.DEPT_CODE)
LEFT  join JOB C on (C.JOB_CODE = A.JOB_CODE)
LEFT  join location D on(D.LOCAL_CODE = B.LOCATION_ID)
LEFT  join nation E on (E.NATIONAL_CODE = D.NATIONAL_CODE)

