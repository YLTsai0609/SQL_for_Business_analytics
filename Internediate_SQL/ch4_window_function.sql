-- INFORMATION FROM DATA COMP
-- GROUP BY with all non-aggregate columns - using WINDOW


-- Running totals,
-- Running ranks
-- Moving averages

-- Key differences
-- Processed after every par of query except ORDER BY
-- Use information in result set rather than database
-- NOT in sqlite, 


-- calculates the average number of goals scored overall 
-- and then includes the aggregate value in each row using 
-- a window function.

-- INFORMATION FROM Mysql 8 新特性 window functions 的作用
-- https://www.itread01.com/article/1512011039.html
-- same result with groupby and self join to the table
-- if we does not use PARTITION BY, there are only one window

-- How many goals were scored in each match, and how did that compare to the overall average
-- select id, country, searson, home_goal, away_goal，並以整個result table計算一個overall_average_score，接著JOIN回去該查詢
-- 結果即下面
SELECT 
	-- Select the id, country name, season, home, and away goals
	m.id, 
    c.name AS country, 
    m.season,
	m.home_goal,
	m.away_goal,
    -- Use a window to include the aggregate average in each row
	AVG(m.home_goal + m.away_goal) OVER() AS overall_avg
FROM match AS m
LEFT JOIN country AS c ON m.country_id = c.id;


-- , you will create a data set of ranked matches according to which leagues,
--  on average, score the most goals in a match.

-- 在2011/2012季中，撈出每個聯盟的平均home_goal以及away_goal，並且給定他們排名，並由小排到大

SELECT 
	-- Select the league name and average goals scored
	name AS league,
    AVG(m.home_goal + m.away_goal) AS avg_goals,
    -- Rank each league according to the average goals
    RANK() OVER(ORDER BY AVG(m.home_goal + m.away_goal)) AS league_rank
FROM league AS l
LEFT JOIN match AS m 
ON l.id = m.country_id
WHERE m.season = '2011/2012'
GROUP BY l.name
-- Order the query by the rank you created
ORDER BY league_rank;



-- 將其相反排序


SELECT 
	-- Select the league name and average goals scored
	name AS league,
    AVG(m.home_goal + m.away_goal) AS avg_goals,
    -- Rank each league according to the average goals
    RANK() OVER(ORDER BY AVG(m.home_goal + m.away_goal) DESC) AS league_rank
FROM league AS l
LEFT JOIN match AS m 
ON l.id = m.country_id
WHERE m.season = '2011/2012'
GROUP BY l.name
-- Order the query by the rank you created
ORDER BY league_rank DESC;


-- How many goals were scored in each match,
--  and how did that compare to the season average


-- creating a data set of games played by Legia Warszawa (Warsaw League),
-- the top ranked team in Poland, 
-- and comparing their individual game performance to the overall average for that season.
-- 在整個result data上OVER，自帶self join
SELECT
	date,
	season,
	home_goal,
	away_goal,
	CASE WHEN hometeam_id = 8673 THEN 'home' 
		 ELSE 'away' END AS warsaw_location,
    -- Calculate the average goals scored partitioned by season
    -- It will caculate overall score not only the hometeam_id, awayteam_id = 8673
    AVG(home_goal) OVER(PARTITION BY season) AS season_homeavg,
    AVG(away_goal) OVER(PARTITION BY season) AS season_awayavg
FROM match
-- Filter the data set for Legia Warszawa matches only
WHERE 
	hometeam_id = 8673
    OR awayteam_id = 8673
ORDER BY (home_goal + away_goal) DESC;