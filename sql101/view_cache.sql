-- https://cloud.google.com/bigquery/docs/reference/rest/v2/Job#JobConfigurationQuery.FIELDS.use_query_cache

-- when we're using view. the cache result is store somewhere at developer level(other developer cannot access the cache)
-- if the cache isn't expire. we may get unexpceted result.