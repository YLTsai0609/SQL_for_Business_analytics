-- Subtract the min date_created from the max
SELECT MAX(date_created) - MIN(date_created)
  FROM evanston311;


-- How old is the most recent request?
SELECT now() - MAX(date_created)
  FROM evanston311;

-- Add 100 days to the current timestamp
SELECT now() + '100 days'::interval;


-- Select the current timestamp, 
-- and the current timestamp + 5 minutes
SELECT 
    now(),
    now() + '5 minutes'::interval

-- -- Select the category and the average completion time by category
-- SELECT category, 
--        AVG(date_completed - date_created) AS completion_time
--   FROM evanston311
--   GROUP BY category
-- -- Order the results
--  ORDER BY completion_time DESC;