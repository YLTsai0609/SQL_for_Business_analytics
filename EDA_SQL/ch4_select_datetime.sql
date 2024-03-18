-- -- Count requests created on January 31, 2017
SELECT count(*) 
  FROM evanston311
WHERE CAST(date_created AS date) = '2017-01-31'::date;


-- Count requests created on February 29, 2016
SELECT count(*)
  FROM evanston311 
 WHERE date_created >= '2016-2-29'::date
   AND date_created < '2016-3-1'::date;


-- Count requests created on March 13, 2017
SELECT count(*)
  FROM evanston311
 WHERE date_created >= '2017-03-13'::date
   AND date_created < '2017-03-13'::date + 1