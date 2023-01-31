-- ARRAY and levelGroup

SELECT GENERATE_ARRAY(1, 10) AS level, 'level_1_10' AS levelGroup
UNION ALL
SELECT GENERATE_ARRAY(11, 20) AS level, 'level_11_20' AS levelGroup