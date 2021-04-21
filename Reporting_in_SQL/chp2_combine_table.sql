-- UNION ALL is better than union, keep us from lost rows when combining table
-- https://www.runoob.com/sql/sql-union.html
-- UNION ALL 允許重複值
-- UNION 自動吃掉重複值
-- 先JOIN在UNION vs 先UNION在JOIN
-- there are serval ways to create the same report
-- step by step = easier to troubleshooting


-- UNION兩張表，並SELECT一個常數作為columns來區別
-- Query season, country, and events for all summer events
SELECT 
	'summer' AS season, 
    c.country, 
    COUNT(DISTINCT s.event) AS events
FROM summer_games AS s
JOIN countries AS c
ON s.country_id = c.id
GROUP BY c.country
-- Combine the queries
UNION ALL
-- Query season, country, and events for all winter events
SELECT 
	'winter' AS season, 
    c.country, 
    COUNT( DISTINCT w.event) AS events
FROM winter_games AS w
JOIN countries AS c
ON w.country_id = c.id
GROUP BY c.country
-- Sort the results to show most events at the top
ORDER BY events DESC;


-- ANOTHER UGLY CODE
-- JOIN the UNION table in the subquery

-- Add outer layer to pull season, country and unique events
SELECT 
	season, 
    country, 
    COUNT(DISTINCT event) AS events
FROM
    -- Pull season, country_id, and event for both seasons
    (SELECT 
     	'summer' AS season, 
     	country_id, 
     	event
    FROM summer_games
    UNION ALL
    SELECT 
     	'winter' AS season, 
     	country_id, 
     	event
    FROM winter_games) AS subquery
JOIN countries AS c
ON subquery.country_id = c.id
-- Group by any unaggregated fields
GROUP BY season, country
-- Order to show most events at the top
ORDER BY events DESC;
