-- Sticking to just the clauses in your example,
--  SQL engines generally evaluate the FROM clause first, 
-- determining which tables to pull data from, 
-- then evaluate the WHERE clause to filter the retrieved data, 
-- and then the SELECT clause to determine what to display and how to display it.

-- use CTE instead
-- subquery is not a good option for reabability, use it when the query is short enough.
-- https://stackoverflow.com/questions/62326042/bigquery-standard-sql-unable-to-use-alias

