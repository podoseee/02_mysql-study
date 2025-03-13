/* 
    ASCII(문자) : 해당 문자의 아스키 코드 값을 반환
    CHAR(숫자) : 해당 아스키코드 숫자의 문자값을 반환
*/
SELECT ASCII('A'), CHAR(2);
/*
#LENGTH, BIT_LENGTH, CHAR_LENGTH
1. 해당 문자열의 할당된 바이트 크기 반환
2. 해당 문자열의 할당된 비트 크기 반환
3. 해당 문자열의 길이(글자수)반환

    * utf8mb4 문자셋 기준
    -한글 한글자당 -3바이트(24비트)
    - 그외 한글자당 - 1바이
*/


show variables LIKE 'character_set_database';
select LENGTH('파이'), BIT_LENGTH('파이'),CHAR_LENGTH('파이');




/*
## CONCAT, CONCAT_WS
                ㄴ 해당 문자열들을 해당 구분자로 이어붙인 결과 반환
                
                
*/
SELECT 
    CONCAT('호랑이', '기린', '캥거루');
    ,CONCAT_WS(",", "호랑이", "기린", "캥거루");

/*
## ELT, FIELD, FIND_IN_SET##
1. 나열된 문자열들 중 해당 위치의 문자열을 반환
2. FIELD(찾을 문자열, 문자열1, 문자열2, ...) : 해당 문자열의 위치를 반환(없으면 0반환)
3. FIND_IN_SET(찾을 문자열, 문자열 리스트) : 문자열 리스트 중 " 반환(단, 문자열 리스트는 반드시 ,로 나열된 문자열이여야됨)

*/
SELECT 
    ELT(2, '사과', '딸기', '바나나')
    ,FIELD('바나나', '사과', '딸기', '바나나')
    ,FIND_IN_SET('사과', '사과,딸기, 바나나');

SELECT 
    *
FROM
    tbl_menu
ORDER_BY
    -- FIND_IN_SET(menu_code, '15,12') DESC  -- menu code값이 15일 경우 1, menu_code값이 12일 경우 2, 나머지 메뉴 코드값은 0

SELECT
    INSTR('사과딸기바나나', '딸기')
    ,LOCATE("딸기', '사과딸기바나나');
    
/*
## FORMAT
    FORMAT(숫자, 소수점자리수) : 1000단위마다 콤마를 표시해주며 소수점 아래 자리수까지 표현(반올림함)
*/
SELECT 
    menu_name
    ,FORMAT(menu_price, 0)
    ,CONCAT(FORMAT(menu_price,0), '원')
FROM
    tbl_menu;

/* 
    INSERT(기준 문자열, 위치, 길이, 삽입할 문자열) : 기준 문자열의 해당 위치부터 해당 길이만큼을 지우고 삽입할 문자열을 넣어 반환
*/

SELECT 
    INSERT('내 이름은 아무개입니다.', 7,3,'홍길동');

SELECT
    menu_name
    ,INSERT(menu_name, 쥬스위치, 2, 'JUICE'),2,'JUICE';
FROM
    tbl_menu
WHERE
    menu_name Like '%주스%'
    
/*
    #REPLACE(기준 문자열, 찾을 문자열, 바꿀 문자열) : 기준 문자열로부터 특정 문자열을 찾아 바꿀 문자열로 변경후 반환
        ㄴ찾을 문자열이 존재하지 않을 경우 => 기준 문자열 반환

*/
SELECT REPLACE('마이SQL', '마이', 'My');

/*
    1. LEFT(문자열, 길이) : 해당 문자열의 온쪽 지점에서부터 해당 길이만큼의 문자열 반환
    2. RIGHT(문자열, 길이): 오른쪽 지점에서부터 ""
*/

/*
    LPAD, RPAD(기준 문자열, 길이, 채울 문자열): 기준 문자열에 왼쪽 혹은 오른쪽으로 총길이가 길이가 되도록 채울 문자열을 추가하여 반
    
    
    -- TRIM,LTRIM, RTRIM,TRIM(LEADING|TRAINLING|BOTH 제거할 문자열 FROM 문자열) : 해당 문자열의 지정한 방향에 특정 문자열을 찾아 제거한 후 반	    
                                --왼쪽, 오른쪽, 양쪽 둘다
/*
    REPEAT(문자열, 횟수) : 문자열을 횟수만큼 반복해 만들어 반환
    SPCAE(길이) : 해당 길이만큼의 공백문자열을 반
    REVERSE(문자열) : 문자열의 순서를 거꾸로 뒤집어 반
    SUBSTRING(문자열, 시작위치, 길이) : 해당 문자열의 시작위치에서부터 해당 길이만큼을 반환(SUBSTR로 대체 가능), 길이 생략시 끝까지를 의미
    
    SUBSTRING_INDEX : 해당 문자열의 구분자의 위치까지를 반환

*/
SELECT
    RPAD(SUBSTRING('880917-2346712', 1,8), 14, '*');


SELECT 
    SUBSTRING_INDEX('hong.test@gmail.com)
/* 숫자 처리함수
    #RAND() : 0이상 1미만의 실수 난수 반환*/
    */
    
/* # NOW, SYSDATE, LOCALTIME, LOCALTIMESTAMAP 현재 날짜 및 시간 정보를 "연-월-일 시:분:초 형식으로 반환"
*/
SELECT
    NOW()
    ,SYSDATE()
    ,LOCALTIME(), LOCALTIME()
    ,LOCALTIMESTAMP(), LOCALTIMESTAMP;
    
/* 
    CURDATE, CURRENT_DATE
    현재 날짜 정보를 "연-월-일" 형식으로 반환
    
    ADDDATE, SUBDATE 일수만큼을 기준날짜에 더하고 뺀것을 반, 일수 대신에 "INTERVAL N" 단위 형식으로 작성 가능, 해당 단위의 N날짜 더하거나 뺸 날짜 반	

    ADDTIME(날짜 및 시간, 시간) : 해당 날짜 및 시간을 기준으로 특정 시간만큼 더한 시간을 반
    SUBTIME(날짜 및 시간, 시간) 
    DATEDIFF(날짜1, 날짜2) : 날짜1-날짜2의 일수 반환
    TIMEDIFF(날짜 및시간, 날짜 및 시간2) : 시간 1-시간 2의 결과 반환
    EXTRACT 함수
    DAYOFWEEK(날짜): 요일 반환(1이 일요일  7이 토요일)
    DAYOFMONTH(날짜) : 해당 월을 기준으로 몇일 흘럿는지 반환
    DAYOFYEAR(날짜) : 해당 년도를 기준으로 몇일 흘럿는ㅂ지 반환
    MONTHNAME(날짜): 달의 이름 반
    LAST_DAY(날짜) : 해당 달의 마지막 날짜를 구해서 반환
    MAKEDATE(연도, 정수) 해당 연도의 정수만큼 지난 날짜 구해서 반
    PERIOD_ADD(연월, 개월수) : 연월에서 개월 수 이후의 연월을 구해서 반
    CAST, CONVERT
    NULL처리 함수
    IFNULL(값, null일떄 대체값) : 값이 null일 경우 대체값 반환, null이 아닐 경우 기존값 반환
    ISNULL(값) : 값이 null일 경우 1(true) 반환
    COALESCE(값) : 나열된 값들 중 null이 아닌 첫번째 값을 반환
    


