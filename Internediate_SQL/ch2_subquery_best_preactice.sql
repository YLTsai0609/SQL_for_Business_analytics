-- too much subquery make query difficult to read!
-- LINE UP SELECT, FROM, GROUP BY, WHERE
-- indent
-- anootation
-- HOLYWELL SQL Style Guide


-- SUBQUERY require computing power!
--  How big is your DB, your Table


-- 選出以每個stage groupby，分數比overall平均高的data
SELECT 
	-- Select the stage and average goals from the subquery
	stage,
	ROUND(avg_goals,2) AS avg_goals
FROM 
	-- Select the stage and average goals in 2012/2013
	(SELECT
		 stage,
         AVG(home_goal + away_goal) AS avg_goals
	 FROM match
	 WHERE season = '2012/2013'
	 GROUP BY stage) AS s
WHERE 
	-- Filter the main query using the subquery
	s.avg_goals > (SELECT AVG(home_goal + away_goal) 
                    FROM match WHERE season = '2012/2013');



-- 選出以每個stage groupby，分數比overall平均高的data
SELECT 
	-- Select the stage and average goals from s
	stage,
    ROUND(avg_goals,2) AS avg_goal,
    -- Select the overall average for 2012/2013
    (SELECT AVG(home_goal + away_goal) FROM match WHERE season = '2012/2013') AS overall_avg
FROM 
	-- Select the stage and average goals in 2012/2013 from match
	(SELECT
		 stage,
         AVG(home_goal + away_goal) AS avg_goals
	 FROM match
	 WHERE season = '2012/2013'
	 GROUP BY stage) AS s
WHERE 
	-- Filter the main query using the subquery
	s.avg_goals > (SELECT AVG(home_goal + away_goal) 
                    FROM match WHERE season = '2012/2013');
