-- single comment (한줄 주석)
# single comment (한줄 주석, oracle에서는 지원x)
/*
    multiple comment (여러줄 주석)
    
    < workbench 설정 - Edit > Preferences 
    1. General - Editors - Indentation - Tab key inserts~~ 체크하기 (탭을 공백으로 처리)
    2. SQL Editor - Other - Safe Updates 체크해제
        SQL Editor - Query Editor - Enable Code Completion~~ 체크해제
    3. Fonts & Colors - D2Coding 으로 변경   

*/

/*
    ## 현재 존재하는 계정들 조회 ##
    mysql(database)내의 user(table)를 조회
*/
select * from user; -- mysql(database)를 사용하겠다고 선택해야됨
select * from mysql.user;