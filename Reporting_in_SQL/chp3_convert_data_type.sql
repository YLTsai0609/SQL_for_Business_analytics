SELECT 
	year,
    -- Pull decade, decade_truncate, and the world's gdp
    DATE_PART('year', CAST( year AS date)) AS decade,
    DATE_TRUNC('month' ,CAST(year AS date)) AS decade_truncated,
    SUM(gdp) AS world_gdp
FROM country_stats
-- Group and order by year in descending order
GROUP BY year
ORDER BY year DESC;


-- 也可以放10年

SELECT 
	year,
    -- Pull decade, decade_truncate, and the world's gdp
    DATE_PART('decade',CAST(year AS date)) AS decade,
    DATE_TRUNC('decade',CAST(year AS date)) AS decade_truncated,
    SUM(gdp) AS world_gdp
FROM country_stats
-- Group and order by year in descending order
GROUP BY year
ORDER BY year DESC;

