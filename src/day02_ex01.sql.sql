    SELECT DISTINCT pv2.visit_date AS missing_date
      FROM (SELECT visit_date
           FROM  person_visits 
           WHERE person_id BETWEEN 1 AND 2
           ) AS pv1
RIGHT JOIN person_visits pv2 ON pv1.visit_date = pv2.visit_date
     WHERE pv1.visit_date IS NULL
  ORDER BY pv2.visit_date
