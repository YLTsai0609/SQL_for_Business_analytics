SELECT count(*) - COUNT(ticker) AS missing
  FROM fortune500;

-- 無法動態生成 columns, 並丟到 SQL語法中, Spark 還是好用一點