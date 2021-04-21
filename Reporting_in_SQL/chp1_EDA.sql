-- with comsole
-- data rows but inaccuracte picture
-- no insights into distributions


-- with queries
-- SELECT DISTINCT (unique values)

-- Field-level aggregation
-- SELECT COUNT(*) GROUP BY (SUM, AVG, COUNT, MEDINA, ...)

-- Table-level aggregation
-- SELECT COUNT(*) - how many rows in the table


-- Query validation
--  to do that, do table-level aggregation with subquery in the FROM
-- (crucial step) Make your report reliable


-- EDA, value_counts including null
SELECT 
	bronze, 
	COUNT (*) AS rows
FROM summer_games
GROUP BY bronze;

-- QUERY VALIDATION
WITH medals_country AS(
SELECT 
	c.country, 
    COUNT(s.bronze) AS bronze_medals
FROM summer_games AS s
JOIN countries AS c
ON s.country_id = c.id
GROUP BY c.country
)

SELECT SUM(bronze_medals)
FROM medals_country;



-- athlete_name and 
-- gold_medals for summer games
-- HAVING不能使用別名，某些版本中的MYSQL可以，但是你可以想像這個壞習慣會讓你再切換資料庫時無法了解自己出錯的原因

-- check from https://blog.csdn.net/sanbingyutuoniao123/article/details/53523267?utm_medium=distribute.pc_relevant.none-task-blog-title-3&spm=1001.2101.3001.4242
-- 因为SQL的执行顺序为：
-- 先where 再group 再having 再select 后order.

-- sql语句解析的顺序的问题。先where条件过滤出需要的纪录，再对筛选出来的记录分组group加having。接下来就是选取字段的过滤select最后order排序。所以别名只有在select和order by内才可以只用。



-- Pull athlete_name and gold_medals for summer games
SELECT 
	a.name AS athlete_name, 
    SUM(s.gold) AS gold_medals
FROM summer_games AS s
JOIN athletes AS a
ON s.athlete_id = a.id
GROUP BY a.name
-- Filter for only athletes with 3 gold medals or more
HAVING SUM(s.gold) >= 3
-- Sort to show the most gold medals at the top
ORDER BY gold_medals DESC;

