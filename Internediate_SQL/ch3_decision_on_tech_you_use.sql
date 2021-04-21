-- JOIN, subquery, CTE are so overlapping
-- Let's compare the pros and cons


-- JOIN
-- combine 2+ tables
-- simple operation / aggregation

-- correlated-subquery
-- match subqueries and tables
-- AVOID LIMIT of JOIN
-- HIGH PROCSSING TIME

-- Multiple / Nested subquery
-- multi-step tansformation of your data
-- Improve accuracy and reconstrucibility

-- CTE
-- organized your query seqeuncially
-- Can reference other CTEs

-- Which one to use, use them all to get a clear and reusable query


-- correlated query, -> extremely simple but time consuming
SELECT
    m.date,
   (SELECT team_long_name
    FROM team AS t
    -- Connect the team to the match table
    WHERE team_api_id = hometeam_id) AS hometeam
FROM match AS m;
