-- subquery is diffcult to track its usage
-- improving readability and accessibility of subquery
-- Declared ahead of your main query

-- Multiple CTE

-- WITH cte1 AS(
--     ...
-- ),
-- cte2 AS(
--     ...
-- ),
-- ...

-- Why use CTEs
-- Excuted once then stored in memory - improve query performance
-- Improving organization of queries
-- Can reference other CTEs
-- the third CTE can retieve information from the first and second CTE
-- CTE can reference itself called recursive CTE


-- Set up your CTE
WITH match_list AS (
    SELECT 
  		country_id, 
  		id
    FROM match
    WHERE (home_goal + away_goal) >= 10)

-- Select league and count of matches from the CTE
SELECT
    l.name AS league,
    COUNT(match_list.id) AS matches
FROM league AS l
-- Join the CTE to the league table
LEFT JOIN match_list ON l.id = match_list.id
GROUP BY l.name;




-- Set up your CTE
WITH match_list AS (
    SELECT 
  		country_id,
  	   (home_goal + away_goal) AS goals
    FROM match
  	-- Create a list of match IDs to filter data in the CTE
    WHERE id IN (
       SELECT id
       FROM match
       WHERE season = '2013/2014' AND EXTRACT(MONTH FROM date) = 08))
-- Select the league name and average of goals in the CTE
SELECT 
	l.name,
    AVG(match_list.goals)
FROM league AS l
-- Join the CTE onto the league table
LEFT JOIN match_list
ON l.id = match_list.country_id
GROUP BY l.name;
