-- HOW can we produce a duplication?
-- LEFT/RIGHT JOIN
-- https://campus.datacamp.com/courses/reporting-in-sql/cleaning-validation?ex=12

-- 講師聲稱這是最危險的一種髒資料
-- 必須注意JOIN是否會造成多種ID

-- 修復重複列的做法
-- 1. 不使用aggregation(只適用於一對一JOIN) - 原本GROUP BY p.id points SUM(col_1)
-- 2. 把JOIN KEY增加，通常從1個變到2個以上
-- 3. 先把要JOIN的內容選出來，在對這個子表格JOIN
-- 確認是否query有問題
-- 這個動作可以透過Query Validation來做檢查
-- 例如你做了一個aggregation，可以和原本的表格的聚合值做比較，如果你做的結果值不對，那麼就表示你在中間產生了多餘的ROW


-- Comment out the query after noting the gold medal count
WITH validation AS(
SELECT SUM(gold) AS gold_medals
FROM winter_games)
-- TOTAL GOLD MEDALS: 47

-- Calculate the total gold_medals in your query
SELECT SUM(gold_medals)
FROM
	(SELECT 
        w.country_id, 
     	SUM(gold) AS gold_medals, 
        AVG(gdp) AS avg_gdp
    FROM winter_games AS w
    JOIN country_stats AS c
    ON c.country_id = w.country_id
    -- Alias your query as subquery
    GROUP BY w.country_id) AS subquery;
-- VALIDATION之後會發現值差了10倍


-- 方法一，兩個JOIN KEY

SELECT SUM(gold_medals) AS gold_medals
FROM
	(SELECT 
     	w.country_id, 
     	SUM(gold) AS gold_medals, 
     	AVG(gdp) AS avg_gdp
    FROM winter_games AS w
    JOIN country_stats AS c
    -- Update the subquery to join on a second field
    ON c.country_id = w.country_id AND
    CAST(c.year AS date) = CAST(w.year AS date)
    GROUP BY w.country_id) AS subquery;





-- 

VALIDATION
total_golds should be 449
SELECT SUM(COALESCE(gold, 0)) +  SUM(COALESCE(silver, 0))  + SUM(COALESCE(bronze, 0)) as total_medals
FROM summer_games


SELECT 
	c.country_id AS country_code,
    -- Add the three medal fields using one sum function
	SUM(COALESCE(gold, 0)) +  SUM(COALESCE(silver, 0))  + SUM(COALESCE(bronze, 0)) AS medals
FROM summer_games AS s
JOIN country_stats AS c
ON c.country_id = s.country_id
GROUP BY c.country_id
ORDER BY medals DESC;