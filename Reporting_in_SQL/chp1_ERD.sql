-- high level view of data table
-- Age of oldest athlete by region
-- 有ERD之後，先JOIN，從後面一路填回來，JOIN -> GROUPBY -> WHERE  -> SELECT

-- Select the age of the oldest athlete for each region
SELECT 
	c.region, 
    MAX(a.age) AS age_of_oldest_athlete
FROM athletes as a
-- First JOIN statement
JOIN summer_games as s
ON a.id = s.athlete_id
-- Second JOIN statement
JOIN countries as c
ON s.country_id = c.id
GROUP BY c.region;



-- Number of events in each sport
-- 兩個沒關係的表要放在一起，無法JOIN，用UNION


-- Select sport and events for summer sports
SELECT 
	sport, 
    COUNT(DISTINCT event) AS events
FROM summer_games
GROUP BY sport
UNION
-- Select sport and events for winter sports
SELECT 
	sport, 
    COUNT(DISTINCT event) AS events
FROM winter_games
GROUP BY sport
-- Show the most events at the top of the report
ORDER BY events DESC;
