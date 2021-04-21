-- Building complex caculations
-- Window function
--      standard aggrwgation mean. median, max, min
--      window specific function LAG(N) LEAD(N)
--          LAG(N), row number - 3 lag(1) 是 2, lag(2) 是 1, lead(1) 是4, lead(2) 是 5
--          ROW_NUMBER(), RANK()
--      window function with group by
--      nested sum() - inner for group by, outer sum for OVER()
-- layer caculations
--  aggregation on exsited aggregation
--  draw a initail table, intermediate table, and final table to planning a query
-- we can use two approach for complex caculation 

-- 從region和country_id來看
-- Query total_golds by region and country_id
SELECT 
	region, 
    country_id, 
    SUM(gold) AS total_golds
FROM summer_games_clean AS s
JOIN countries AS c
ON s.country_id = c.id
GROUP BY region, country_id;


-- 使用subquery來看avg total
-- Pull in avg_total_golds by region
SELECT 
	region,
    AVG(total_golds) AS avg_total_golds
FROM
  (SELECT 
      region, 
      country_id, 
      SUM(gold) AS total_golds
  FROM summer_games_clean AS s
  JOIN countries AS c
  ON s.country_id = c.id
  -- Alias the subquery
  GROUP BY region, country_id) AS subquery
GROUP BY region
-- Order by avg_total_golds in descending order
ORDER BY avg_total_golds;