WITH BMI AS(
  SELECT 
  *,
  weight / POWER((height / 100.0),2)  AS bmi
  FROM patients
)

SELECT 
	patient_id,
    CASE WHEN bmi >= 30 THEN 1 ELSE 0 END AS isObese
FROM BMI