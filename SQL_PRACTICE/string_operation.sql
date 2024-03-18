SELECT patient_id, first_name
FROM patients
WHERE first_name LIKE 's%s'
AND len(first_name) >= 6