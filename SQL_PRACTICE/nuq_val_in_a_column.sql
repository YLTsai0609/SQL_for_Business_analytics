SELECT 
	first_name
FROM patients
group by first_name
having COUNT(1) = 1