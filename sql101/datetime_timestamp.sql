-- convert integer to date
-- in standard sql
-- doc : https://cloud.google.com/bigquery/docs/reference/standard-sql/timestamp_functions

SELECT DATE(TIMESTAMP_SECONDS(1636017273))
UNION ALL

SELECT DATE(TIMESTAMP_MILLIS(1636017273000))

UNION ALL
SELECT DATE(TIMESTAMP_MICROS(1636017273000000))