-- 這個月 vs 上個月
--      透過LAG或是LEAD，先把要聚合的值針對month aggregate
--      起來，那麼就可以用LAG了
--      除了比較之外，也可以直接相除，來計算成長率
-- Rolling 7 days
--      ROWS BETWEEN
--      你可能會需要先進行daily aggregation，GROUP BY date
--      接著再進行OVER, ORDER BY date ROWS BETWEEN 


-- 事實上寫一個CTE可能好一點....
SELECT
	-- Pull month and country_id
	DATE_PART('month', date) AS month,
	country_id,
    -- Pull in current month views
    SUM(views) AS month_views,
    -- Pull in last month views
    LAG(SUM(views)) OVER (PARTITION BY country_id ORDER BY DATE_PART('month', date)) AS previous_month_views,
    -- Calculate the percent change
    SUM(views) / LAG(SUM(views)) OVER (PARTITION BY country_id ORDER BY DATE_PART('month', date)) - 1 AS perc_change
FROM web_data
WHERE date <= '2018-05-31'
GROUP BY month, country_id;


-- CTE的寫法，較容易閱讀
WITH monthly_agg_filtered AS(
    SELECT
    DATE_PART('month', date) AS month,
    country_id,
    SUM(views) AS month_views
    FROM web_data
    WHERE date <= '2018-05-31'
    GROUP BY month, country_id
)

SELECT 
    month,
    country_id,
    month_views,
    LAG(month_views, 1) OVER(PARTITION BY country_id ORDER BY month) AS         previous_month_views,
    month_views / LAG(month_views, 1) OVER(PARTITION BY country_id ORDER BY month) - 1 AS perc_change
FROM monthly_agg_filtered;



-- 每日觀看，vs7日平均
-- 這個寫法使用rolling window，必須確認日期index是連續的
SELECT
	-- Pull in date and daily_views
	date,
	SUM(views) AS daily_views,
    -- Calculate the rolling 7 day average
	AVG(SUM(views)) OVER (ORDER BY date ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS weekly_avg
FROM web_data
GROUP BY date;


-- 有上一週之比較版本

SELECT 
	-- Pull in date and weekly_avg
	date,
    weekly_avg,
    -- Output the value of weekly_avg from 7 days prior
    LAG(weekly_avg,7) OVER (ORDER BY date) AS weekly_avg_previous,
    -- Calculate percent change vs previous period
    weekly_avg /  LAG(weekly_avg,1) OVER (ORDER BY date) AS perc_change
FROM
  (SELECT
      -- Pull in date and daily_views
      date,
      SUM(views) AS daily_views,
      -- Calculate the rolling 7 day average
      AVG(SUM(views)) OVER (ORDER BY date ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS weekly_avg
  FROM web_data
  -- Alias as subquery
  GROUP BY date) AS subquery
-- Order by date in descending order
ORDER BY date DESC;




SELECT
	-- Pull in region and calculate avg tallest height
    region,
    AVG(height) AS avg_tallest,
    -- Calculate region's percent of world gdp
    SUM(gdp) / (SUM(SUM(gdp)) OVER()) AS perc_world_gdp    
FROM countries AS c
JOIN
    (SELECT 
     	-- Pull in country_id and height
        country_id, 
        height, 
        -- Number the height of each country's athletes
        ROW_NUMBER() OVER (PARTITION BY country_id ORDER BY height DESC) AS row_num
    FROM winter_games AS w 
    JOIN athletes AS a ON w.athlete_id = a.id
    GROUP BY country_id, height
    -- Alias as subquery
    ORDER BY country_id, height DESC) AS subquery
ON c.id = subquery.country_id
-- Join to country_stats
JOIN country_stats AS cs
ON cs.country_id = c.id
-- Only include the tallest height for each country
WHERE row_num = 1
GROUP BY region;
