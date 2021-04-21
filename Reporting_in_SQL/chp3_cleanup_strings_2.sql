-- 不同口徑的data
-- 例如5種字串都表示U.S.A
-- IF/ELSE -> CASE!

-- 
-- REPLACE -> Remove, Replace
-- part of string -> LEFT, RIGHT, SUBSTRING
-- change case -> UPPER, LOWER, INITCAP
-- TRIM 去除兩邊空白
-- FUNCTIONAL concat
-- 先replace, trim, left, upper
-- postgre 9.1



-- Output all characters starting with position 7
SELECT 
	country,
    -- LOWER(country) 
    -- INITCAP(country)
    -- 從第7個字元開始
    -- SUBSTRING(country,7) AS country_altered
    LEFT(country,3) AS country_altered
FROM countries
GROUP BY country;



SELECT 
	region, 
    -- Replace all '&' characters with the string 'and'
    REPLACE(region,'&','and') AS character_swap,
    -- Remove all periods
    -- 把逗點去掉
    REPLACE(region,'.','') AS character_remove
FROM countries
WHERE region = 'LATIN AMER. & CARIB'
GROUP BY region;


-- 一次兩個REPLACE
SELECT 
	region, 
    -- Replace all '&' characters with the string 'and'
    REPLACE(region,'&','and') AS character_swap,
    -- Remove all periods
    REPLACE(region,'.','') AS character_remove,
    -- Combine the functions to run both changes at once
    REPLACE(REPLACE(region,'&','and'),
    '.','') AS character_swap_and_remove
FROM countries
WHERE region = 'LATIN AMER. & CARIB'
GROUP BY region;
