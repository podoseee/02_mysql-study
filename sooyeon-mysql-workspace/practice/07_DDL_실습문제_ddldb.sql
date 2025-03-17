/* ## DDL 실습문제 - ddldb ## */

-- CREATE DATABASE ddldb;
-- GRANT ALL PRIVILEGES ON ddldb.* TO 'sotogito'@'%';
-- SHOW GRANTS FOR 'sotogito'@'%';

SHOW VARIABLES LIKE 'autocommit'; -- 자동 커밋 상태 확인
SET autocommit = OFF; -- 커밋 지동 해제

use ddldb;

-- 도서관리 프로그램을 위한 테이블을 구축하려고 한다. 
-- 아래의 요구사항에 맞춰 테이블 생성 및 샘플데이터를 추가하시오.


commit;
-- 1_1. 출판사 테이블 생성 
/*
    *  요구사항
    1. 테이블명 : tbl_publisher
    2. 컬럼 및 제약조건 
       1) 출판사번호 : pub_no, INT, 기본키, 자동순번
       2) 출판사명   : pub_name, VARCHAR(255), 필수
       3) 전화번호   : phone, VARCHAR(255)
    3. 컬럼마다 COMMENT 추가하기 
*/
create table if not exists tbl_publisher(
	pub_no int primary key auto_increment comment "출판사번호",
	pub_name varchar(225) not null comment "출판사명",
    phone varchar(225) comment"전화번호"
)comment = "출판사 테이블";


commit;
-- 1_2. 출판사 테이블에 아래의 데이터 추가
/*
    pub_no  | pub_name  | phone
    =====================================
    1       | BR        | 02-1111-2222
    2       | 문학동네  | 02-3333-4444
    3       | 바람개비  | 02-1111-6666
    -------------------------------------
*/

insert into
	tbl_publisher
values
	(null,"BR","02-1111-2222"),
	(null,"문학동네","02-3333-4444"),
	(null,"바람개비","02-1111-6666")
;
ALTER TABLE tbl_publisher AUTO_INCREMENT = 4;

    
delete from tbl_publisher order by pub_no desc limit 1;

select * from tbl_publisher;

commit;
-- 2_1. 도서 테이블 생성 
/*
    *  요구사항
    1. 테이블명 : tbl_book
    2. 컬럼 및 제약조건 
       1) 도서번호   : bk_no, INT, 기본키, 자동순번
       2) 도서명     : bk_title, VARCHAR(255), 필수
       3) 저자명     : bk_author, VARCHAR(255), 필수
       4) 도서가격   : bk_price, INT
       5) 출판사번호 : bk_pub_no, INT, 외래키(tbl_publisher 참조, 부모데이터 삭제시 자식데이터 삭제 옵션)
    3. 컬럼마다 COMMENT 추가하기 
*/
create table if not exists tbl_book(
	bk_no int primary key auto_increment comment"도서번호",
    bk_title varchar(255) not null comment"도서명",
    bk_author varchar(255) not null comment"저자명",
    bk_price int comment"도서가격",
    bk_pub_no int comment"출판사번호",
    
    foreign key(bk_pub_no) #bk_pub_no라는 컬럼은
		REFERENCES tbl_publisher(pub_no) #tbl_publisher부모 테이블의 pub_no컬럼을 참조하는데
        on delete cascade #만약 부모데터가 삭제되면 자식 데이터도 삭제하겠다.
)comment = "도서 테이블";


select * from tbl_book;
rollback;
commit; 

-- 2_2. 도서 테이블에 아래의 데이터 추가
/*
    bk_no | bk_title                 | bk_author    | bk_price | bk_pub_no
    ======================================================================
    1     | 칭찬은 고래도 춤추게한다.| 고래         | 10000    | 1
    2     | 자바의 정석              | 홍길동       | 20000    | 2
    3     | ORACLE 마스터하기        | 오라클       | 30000    | 2
    4     | 자바 완전 정복하기       | 제임스 고슬링| 15000    | 1
    5     | SQL문 익히기             | 선생님       | 15000    | 3
    ----------------------------------------------------------------------
*/


ALTER TABLE tbl_book AUTO_INCREMENT = 1;
insert into
	tbl_book
values
	(0,"칭찬은 고래도 춤추게한다.","고래",10000,1),
	(0,"자바의 정석","홍길동",20000,2),
	(0,"ORACLE 마스터하기","오라클",30000,2),
	(0,"자바 완전 정복하기","제임스 고슬링",15000,1),
	(0,"SQL문 익히기","선생님",15000,3)
;

select * from tbl_book;

commit;

-- 3_1. 회원 테이블 생성 
/*
    *  요구사항
    1. 테이블명 : tbl_member
    2. 컬럼 및 제약조건 
       1) 회원번호   : mem_no, INT, 기본키, 자동순번
       2) 아이디     : mem_id, VARCHAR(30), 필수, 중복불가
       3) 비밀번호   : mem_pwd, VARCHAR(30), 필수
       4) 회원명     : mem_name, VARCHAR(30), 필수
       5) 성별       : gender, CHAR(1), 'M'또는'F'만 허용
       6) 주소       : address, VARCHAR(255)
       7) 연락처     : phone, VARCHAR(30)
       8) 탈퇴여부   : status, CHAR(1), 'Y'또는'N'만 허용, 'N'기본값 
       9) 가입일시   : enroll_dt, DATETIME, 필수, NOW()기본값
    3. 컬럼마다 COMMENT 추가하기 
*/
create table if not exists tbl_member(
	mem_no 		int 			primary key auto_increment 		comment"회원번호",
    mem_id 		varchar(30) 	 not null unique 				comment"아이디",
    mem_pwd 	varchar(30) 	 not null comment"비밀번호",
    mem_name 	varchar(30) 	 not null comment"회원명",
    gender 		CHAR(1) 		CHECK (gender IN ('M', 'F')) 	comment"성별",
    address 	varchar(255) 									comment"주소",
    phone 		varchar(30) 									comment"연락처",
    status 		enum('Y','N') 	default 'N' 					comment"탈퇴여부",
    enroll_dt 	datetime 		 not null default now() 		comment"가입일시"
)comment = "회원 테이블";


select * from tbl_member;


commit;

-- 3_2. 회원 테이블에 아래의 데이터 추가
/*
    mem_no    | mem_id    | mem_pwd     | mem_name    | gender | address       | phone         | status | enroll_dt
    ===================================================================================================================
    1001      | user01    | pass01      | 홍길동      | M      | 서울시 강서구 | 010-1111-2222 | 기본값 | 기본값
    1002      | user02    | pass02      | 강보람      | F      | 서울시 강남구 | 010-3333-4444 | 기본값 | 기본값
    1003      | user03    | pass03      | 신사임당    | F      | 서울시 양천구 | 010-7621-9018 | 기본값 | 기본값
    1004      | user04    | pass04      | 백신아      | F      | 서울시 관악구 | 010-4444-5555 | 기본값 | 기본값
    1005      | user05    | pass05      | 김말똥      | M      | 인천시 계양구 | 010-6666-7777 | 기본값 | 기본값
    -------------------------------------------------------------------------------------------------------------------
*/
alter table tbl_member auto_increment = 1001;

insert into 
	tbl_member (mem_id,mem_pwd,mem_name,gender,address,phone)
values
	('user01', 'pass01', '홍길동', 'M', '서울시 강서구', '010-1111-2222'),
	('user02', 'pass02', '강보람', 'F', '서울시 강서구', '010-1111-3333'),
	('user03', 'pass03', '김철수', 'M', '서울시 강남구', '010-2222-3333'),
	('user04', 'pass04', '백신아', 'F', '서울시 관악구', '010-4444-5555'),
	('user05', 'pass05', '김말똥', 'M', '서울시 마포구', '010-5555-6666')
;

commit;

-- 4_1. 대여 이력 테이블 생성 
/*
    *  요구사항
    1. 테이블명 : tbl_rent
    2. 컬럼 및 제약조건 
       1) 대여이력번호 : rent_no, INT, 기본키, 자동순번
       2) 대여회원번호 : rent_mem_no, INT, 외래키(tbl_member 참조, 부모데이터 삭제시 자식데이터 null로 변경옵션)
       3) 대여도서번호 : rent_bk_no, INT,  외래키(tbl_book 참조, 부모데이터 삭제시 자식데이터 null로 변경옵션)
       4) 대여일시     : rent_dt, DATETIME, 필수, NOW()기본값
    3. 컬럼마다 COMMENT 추가하기 
*/

create table if not exists tbl_rent(
	rent_no 	int 		primary key auto_increment	 comment"대여이력번호",
    rent_mem_no	int			default null				comment"대여회원번호",
    rent_bk_no  int 		default null				comment"대여도서번호",
    rent_dt     datetime	not null default now()		comment"대여일시",
    
    foreign key(rent_mem_no)
		REFERENCES tbl_member(mem_no)
        on delete set null,
        
	foreign key(rent_bk_no)
		REFERENCES tbl_book(bk_no)
        on delete set null
        
)comment = "대여 이력 테이블";

select * from tbl_rent;

commit;

-- 4_2. 회원 테이블에 아래의 데이터 추가
/*
    rent_no | rent_mem_no | rent_bk_no   | rent_dt
    =================================================
    1       | 1001        | 2            | 기본값
    2       | 1001        | 3            | 기본값
    3       | 1002        | 1            | 기본값
    4       | 1002        | 2            | 기본값
    5       | 1001        | 5            | 기본값
*/
insert into
	tbl_rent(rent_mem_no,rent_bk_no)
values
	(1001,2),
	(1001,3),
	(1002,1),
	(1002,2),
	(1001,5)
;

select * from tbl_rent;

-- 5. 커밋하시오. 
commit; 

-- 6. 전체 도서의 도서번호, 도서명, 저자명, 가격, 출판사명, 출판사전화번호를 조회하는 쿼리문을 작성하시오.

-- 7. 전체 대여목록의 회원명, 도서명, 대여일을 조회하는 쿼리문을 작성하시오.
select
	mem_name
    ,bk_title
    ,rent_dt
from
	tbl_rent
		join tbl_member on mem_no = rent_mem_no
        join tbl_book on rent_bk_no = bk_no
;


-- 8. 2번 도서를 대여한 회원의 회원명, 아이디, 대여일, 반납예정일을 조회하는 쿼리문을 작성하시오.
select * from tbl_rent;

select
	mem_name
    ,mem_id
    ,rent_dt
    ,rent_dt + interval 2 week 
from
	tbl_rent
		join tbl_member on mem_no = rent_mem_no
group by
	mem_name,mem_id,rent_dt
having
	count(*) = 2
;

-- 9. 회원번호가 1001인 회원이 대여한 도서의 도서명, 출판사명, 대여일, 반납예정일을 조회하는 쿼리문을 작성하시오. 
select
	bk_title
    ,pub_name
    ,rent_dt
    ,rent_dt + interval 2 week 
from
	tbl_rent
		join tbl_book on bk_no = rent_bk_no
        join tbl_publisher on pub_no = bk_pub_no
where
	rent_mem_no = "1001"
;	
	
	
-- 10. 전체 도서의 도서번호, 도서명, 대여건수를 조회하는 쿼리문을 작성하시오.
select
	bk_no
    ,bk_title
    ,coalesce(count(*),0)
from
	tbl_book
		left join tbl_rent on rent_bk_no = bk_no
group by
	bk_no, bk_title
;
