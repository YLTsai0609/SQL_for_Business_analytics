-- can we partition small table?
-- 2023, Jan smallest grain is "Hourly"
-- https://stackoverflow.com/questions/41617422/can-one-have-hourly-partitions-in-a-bigquery-table
-- https://cloud.google.com/bigquery/docs/creating-partitioned-tables#create_a_time-unit_column-partitioned_table

-- unfortunately, we cannot create any partition on bq
-- or we use integer partition to bypass the question.


-- we can leverage IntegerPartitioning to partition each 5 mins
-- https://medium.com/google-cloud/partition-on-any-field-with-bigquery-840f8aa1aaab
-- https://cloud.google.com/bigquery/quotas#partitioned_tables
-- hash the column, provide 10000 partition for a table maximum
-- needs hash to int64 - 202312050100, 202312052355
-- 4k for regular partitioned table
-- 100k for integer range partitioned table