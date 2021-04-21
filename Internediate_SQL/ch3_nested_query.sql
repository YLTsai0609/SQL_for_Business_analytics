-- Nested subquery could be correlated or not correlated
-- can reference information from the outer subquery
-- or main query



SELECT
	-- Select the season and max goals scored in a match
	season,
    MAX(home_goal + away_goal) AS max_goals,
    -- Select the overall max goals scored in a match
   (SELECT MAX(home_goal + away_goal) FROM match) AS overall_max_goals,
   -- Select the max number of goals scored in any match in July
   (SELECT MAX(home_goal + away_goal) 
    FROM match
    WHERE id IN (
          SELECT id FROM match WHERE EXTRACT(MONTH FROM date) = 07)) AS july_max_goals
FROM match
GROUP BY season;



-- Select matches where a team scored 5+ goals
SELECT
	country_id,
    season,
	id
FROM match
WHERE home_goal >=5 OR away_goal >= 5;



-- What's the average number of matches per season 
-- where a team scored 5 or more goals? How does this differ by country?
-- Count match ids
SELECT
    country_id,
    season,
    COUNT(id) AS matches
-- Set up and alias the subquery
FROM (
	SELECT
    	country_id,
    	season,
    	id
	FROM match
	WHERE home_goal >= 5 OR away_goal >= 5) AS subquery
-- Group by country_id and season
GROUP BY country_id, season;




-- What's the average number of matches per season where a team 
-- scored 5 or more goals?
--  How does this differ by country?



SELECT
	c.name AS country,
    -- Calculate the average matches per season
	AVG(outer_s.matches) AS avg_seasonal_high_scores
FROM country AS c
-- Left join outer_s to country
LEFT JOIN (
      
      SELECT country_id, season,
             COUNT(id) AS matches
      FROM (
            SELECT country_id, season, id
        	FROM match
        	WHERE home_goal >= 5 OR away_goal >= 5) AS inner_s
      -- Close parentheses and alias the subquery
      GROUP BY country_id, season) AS outer_s
      
ON c.id = outer_s.country_id
GROUP BY country;