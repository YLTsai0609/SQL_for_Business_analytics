-- VALIDATION
-- total_golds should be 449
-- SELECT SUM(COALESCE(gold, 0)) +  SUM(COALESCE(silver, 0))  + SUM(COALESCE(bronze, 0)) as total_medals
-- FROM summer_games


SELECT 
	c.country_id AS country_code,
    -- Add the three medal fields using one sum function
	SUM(COALESCE(gold, 0)) +  SUM(COALESCE(silver, 0))  + SUM(COALESCE(bronze, 0)) AS medals
FROM summer_games AS s
JOIN country_stats AS c
ON c.country_id = s.country_id
GROUP BY c.country_id
ORDER BY medals DESC;





-- check the dtype with three tables
-- select column_name, data_type from information_schema.columns
-- WHERE table_name IN ('summer_games','countries','country_stats')

-- SELECT CAST(pop_in_millions AS float)
-- FROM country_stats

-- 不知所以然的GROUP BY
-- 欄位選取時不可食用其他欄位所使用到的別名
SELECT 
	c.country,
    -- Pull in pop_in_millions and medals_per_million 
	pop_in_millions,
    -- Add the three medal fields using one sum function
	SUM(COALESCE(bronze,0) + COALESCE(silver,0) + COALESCE(gold,0)) AS medals,
	SUM(COALESCE(bronze,0) + COALESCE(silver,0) + COALESCE(gold,0)) / CAST(cs.pop_in_millions AS float) AS medals_per_million
FROM summer_games AS s
JOIN countries AS c 
ON s.country_id = c.id
-- Add a join
JOIN country_stats AS cs 
ON s.country_id = cs.country_id
GROUP BY c.country, pop_in_millions
ORDER BY medals DESC;



SELECT
	-- Clean the country field to only show country_code
    LEFT(REPLACE(UPPER(TRIM(c.country)),'.',''),3) AS country_code,
    -- Pull in pop_in_millions and medals_per_million 
	pop_in_millions,
    -- Add the three medal fields using one sum function
	SUM(COALESCE(bronze,0) + COALESCE(silver,0) + COALESCE(gold,0)) AS medals,
	SUM(COALESCE(bronze,0) + COALESCE(silver,0) + COALESCE(gold,0)) / CAST(cs.pop_in_millions AS float) AS medals_per_million
FROM summer_games AS s
JOIN countries AS c 
ON s.country_id = c.id
-- Update the newest join statement to remove duplication
JOIN country_stats AS cs 
ON s.country_id = cs.country_id AND s.year = CAST(cs.year AS date)
-- Filter out null populations
WHERE cs.pop_in_millions IS NOT NULL
GROUP BY c.country, pop_in_millions
-- Keep only the top 25 medals_per_million rows
ORDER BY medals_per_million DESC
LIMIT 25;



-- 總結來說，需要先有分佈圖，以及NULL統計，SELECT時才不會出錯
-- 也必須有data validation