-- can we partition small table?
-- 2023, Jan smallest grain is "Hourly"
-- https://stackoverflow.com/questions/41617422/can-one-have-hourly-partitions-in-a-bigquery-table
-- https://cloud.google.com/bigquery/docs/creating-partitioned-tables#create_a_time-unit_column-partitioned_table

-- unfortunately, we cannot create any partition on bq
-- or we use integer partition to bypass the question.