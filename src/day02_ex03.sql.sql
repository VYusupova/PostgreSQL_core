   WITH day_generator (visit_date) AS 
   (SELECT visit_date
           FROM  person_visits 
           WHERE person_id BETWEEN 1 AND 2
   )
   
   SELECT DISTINCT pv2.visit_date AS missing_date
      FROM day_generator
RIGHT JOIN person_visits pv2 ON day_generator.visit_date = pv2.visit_date
     WHERE day_generator.visit_date IS NULL
  ORDER BY pv2.visit_date
