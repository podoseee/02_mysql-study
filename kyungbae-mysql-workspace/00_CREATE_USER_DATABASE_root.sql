-- single comment (한줄 주석)
# single comment (한줄 주석, oracle에서는 지원x)
/*
    multiple comment 여러줄 주석
    
    < workbench 설정 >
*/

/*
    ## 현재 존재하는 계정들 조회
*/
select * from user; -- mysql(database)를 사용하겠다고 선택해야됨
select * from mysql.user; -- database명.table명으로 조회가능



