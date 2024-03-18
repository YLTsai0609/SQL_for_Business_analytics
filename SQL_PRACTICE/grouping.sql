-- grouping by weights and group, order by
WITH WeightsGroup AS(
  SELECT 
  *,
  10 * (weight / 10) AS weight_group
  FROM patients
)

SELECT 
	COUNT(DISTINCT patient_id) AS patients_in_group,
	weight_group
FROM WeightsGroup
GROUP BY weight_group
ORDER BY weight_group DESC