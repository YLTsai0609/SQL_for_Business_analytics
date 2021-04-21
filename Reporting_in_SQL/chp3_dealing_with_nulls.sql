-- sometimes NULL represent zero
-- sometimes represent other thing, you need to check with the business team/backend team
-- can we sum total in the columns contains null? - No, it will be null
-- Null can be a key to groupby


-- Filter out NULLS
-- WHERE column IS NOT NULL
-- COALESCE - 基本上就是relace nan的SQL版本


-- NULL 存在在你資料集的風險
-- LEFT JOIN無法JOIN所有值
-- CASE時產生bug
-- 還很有很多其他的
-- 這個欄位有多少NULL?
-- SELECT SUM(CASE WHEN column IS NULL then 1 else 0 END) / SUM(1.00)

-- 出現一大堆NULL的Query
-- Show total gold_medals by country
SELECT 
	country,
-- 	用COUNT看來不會受到null的干擾
    SUM(w.gold) AS gold_medals
FROM winter_games AS w
JOIN countries AS c
ON c.id = w.country_id
GROUP BY c.country
-- Order by gold_medals in descending order
ORDER BY gold_medals DESC;



-- 使用WHERE來進行過濾
-- Show total gold_medals by country
SELECT 
	country, 
    SUM(gold) AS gold_medals
FROM winter_games AS w
JOIN countries AS c
ON w.country_id = c.id
-- Comment out the WHERE statement
WHERE gold IS NOT NULL
GROUP BY country
-- Replace WHERE statement with equivalent HAVING statement
-- Order by gold_medals in descending order
ORDER BY gold_medals DESC;



-- 使用HAVING來進行邏輯過濾，較不推薦，因為會撈更多的資料，在更後端才進行過濾
-- Show total gold_medals by country
SELECT 
	country, 
    SUM(gold) AS gold_medals
FROM winter_games AS w
JOIN countries AS c
ON w.country_id = c.id
-- Comment out the WHERE statement
--WHERE gold IS NOT NULL
GROUP BY country
-- Replace WHERE statement with equivalent HAVING statement
HAVING SUM(gold) IS NOT NULL
-- Order by gold_medals in descending order
ORDER BY gold_medals DESC;

-- AVG預設不會計算NULL，但這些NULL在某些情況下你可能想要以0計算


-- Pull events and golds by athlete_id for summer events
SELECT 
    athlete_id, 
    -- Replace all null gold values with 0
    AVG(COALESCE(gold, 0)) AS avg_golds,
    COUNT(event) AS total_events, 
    SUM(gold) AS gold_medals
FROM summer_games
GROUP BY athlete_id
-- Order by total_events descending and athlete_id ascending
ORDER BY total_events DESC, athlete_id;
