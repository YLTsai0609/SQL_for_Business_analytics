-- check how many columns
-- information_shcema 裡面藏著 db 中各個 tb 的 metadata
SELECT
    table_name,
    COUNT(*) AS cnt
FROM information_schema.columns
WHERE table_name IN ('stackoverflow','tag_company','company','tag_type','fortune500')
GROUP BY table_name
ORDER BY cnt DESC

-- check rows