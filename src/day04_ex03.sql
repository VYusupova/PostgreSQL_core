SELECT generated_date AS missing_date From v_generated_dates
EXCEPT
SELECT DISTINCT visit_date from person_visits
ORDER BY 1