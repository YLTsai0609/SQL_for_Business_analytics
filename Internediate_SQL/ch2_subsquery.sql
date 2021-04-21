-- SUBQUERY可以return scalar，list，table
-- 也可以用在WHERE的AND後面
-- WHY SUBQUERY
-- 效能來說比JOIN好，subquery會先跑，然後再跑main query，避免了大表JOIN
-- 可以階段式分析
-- 

-- subquery, scalar case
SELECT 
	-- Select the date, home goals, and away goals scored
    date,
	home_goal,
	away_goal
FROM  matches_2013_2014
-- Filter for matches where total goals exceeds 3x the average
-- 選出分數高於三倍平均的，very handy
WHERE (home_goal + away_goal) > 
       (SELECT 3 * AVG(home_goal + away_goal)
        FROM matches_2013_2014); 


-- subquery list case

SELECT 
	-- Select the team long and short names
	team_long_name,
	team_short_name
FROM team 
-- Exclude all values from the subquery
-- 要記得DISTINCT uid
WHERE team_api_id NOT IN
     (SELECT DISTINCT hometeam_id  FROM match);
