-- 단일행함수
-- 숫자처리함수

-- ABS
SELECT
    ABS(1)
    , ABS(-1);

-- CEILING, FLOOR, TRUNCATE, ROUND
SELECT
    CEILING(123.456)
    , FLOOR(123.456)
    , FLOOR(-0.65);
    
SELECT
    TRUNCATE(123.456, 0)
    ,TRUNCATE(123.456, 1)
    ,TRUNCATE(123.456, 2)
    ,TRUNCATE(123.456, -1);

SELECT
    ROUND(123.456)
    , ROUND(123.456, 1);

-- MOD
SELECT
    75 % 10
    , 75 MOD 10
    , MOD (75,10);

-- POW, SQRT
SELECT
    POW(2,10)
    , SQRT(16);

-- RAND
SELECT
    RAND()
    , FLOOR(RAND() * 10 + 1);

-- SIGN
SELECT
    SIGN(10.1)
    , SIGN(0)
    , SIGN(-10.1);


