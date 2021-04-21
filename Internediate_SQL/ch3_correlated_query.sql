-- Use values from the outer query to generate a result

-- SIMEPLE subquery vs Correlated subquery

-- can be run independently from the main query vs dependent on the main query to exrcute
-- evaluated once in the whole query vs evaluate in LOOPS which SIGNIFICANTLY SLOWS DOWN QUERY RUNNING TIME(be careful!)



-- 可怕的self join
-- 想找出home_goal + away_goal > 平均的3倍的data，某人寫的query如下
SELECT 
	-- Select country ID, date, home, and away goals from match
	main.country_id,
    date,
    main.home_goal, 
    away_goal
FROM match AS main
WHERE 
	-- Filter the main query by the subquery
	(home_goal + away_goal) > 
        (SELECT AVG((sub.home_goal + sub.away_goal) * 3)
         FROM match AS sub
         -- Join the main query to the subquery in WHERE
         WHERE main.country_id = sub.country_id);

-- what was the highest scoring match for each country, in each season?
-- 請愛用GROUP BY XD

SELECT 
	-- Select country ID, date, home, and away goals from match
	main.country_id,
    date,
    main.home_goal,
    away_goal
FROM match AS main
WHERE 
	-- Filter for matches with the highest number of goals scored
	(home_goal + away_goal) = 
        (SELECT MAX(sub.home_goal + sub.away_goal)
         FROM match AS sub
         WHERE main.country_id = sub.country_id
               AND main.season = sub.season);


