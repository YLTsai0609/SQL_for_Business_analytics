-- Background 
-- company 有 id, 名稱, 標記 ticket , 也有母公司 id, 
-- fortune500 有股價排名，但只會有母公司，不會有子公司 ticket
-- Q : 找出所有 company 的排名，子公司就算母公司的，需要做一次 self-join (id and parent-id)，因為子公司要用母公司的 ticker (ticker 會拿去作為 join key)
SELECT company_original.name, fortune500.title, fortune500.rank
  -- Start with original company information
  FROM company AS company_original
       -- Join to another copy of company with parent
       -- company information
	   LEFT JOIN company AS company_parent
       ON company_original.parent_id = company_parent.id
       -- Join to fortune500, only keep rows that match
       INNER JOIN fortune500 
       -- Use parent ticker if there is one, 
       -- otherwise original ticker
       ON coalesce(company_parent.ticker, 
                   company_original.ticker) = 
             fortune500.ticker
 -- For clarity, order by rank
 ORDER BY rank; 


-- SELECT *
-- FROM company AS child
-- LEFT JOIN company AS parent
-- WHERE child.parent_id IS NOT NULL
-- WHERE child.id IN (2, 8)
-- ON child.parent_id = parent.id