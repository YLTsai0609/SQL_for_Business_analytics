-- MySQL

SELECT 
	DISTINCT YEAR(birth_date) AS birthY
FROM patients
ORDER BY birthY 