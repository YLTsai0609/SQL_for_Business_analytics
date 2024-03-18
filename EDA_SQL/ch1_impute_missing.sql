'''
industry 有 null, 但想要找到根據 industry 來說最多的資料是什麼，
coalesce 根據第一個 non null 來填值，而且可以直接被 groupby
'''
SELECT COALESCE(industry, sector, 'Unknown') AS industry2,
       -- Don't forget to count!
       COUNT(*) AS nRows
  FROM fortune500 
-- Group by what? (What are you counting by?)
 GROUP BY industry2
-- Order results to see most common first
 ORDER BY nRows DESC
-- Limit results to get just the one value you want
 LIMIT 1;