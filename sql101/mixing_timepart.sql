-- This one is not working
-- SELECT TIMESTAMP_ADD(CURRENT_TIMESTAMP(), INTERVAL -4 HOUR AND -30 MINUTE)

-- please use this one to integrate the TimePart
SELECT 
  TIMESTAMP_ADD(
  CURRENT_TIMESTAMP(), INTERVAL -30 - 4*60 MINUTE
  )