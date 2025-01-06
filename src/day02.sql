   SELECT NAME, 
          rating 
     FROM pizzeria 
LEFT JOIN person_visits ON pizzeria.id = pizzeria_id
WHERE pizzeria_id is NULL;

    SELECT DISTINCT pv2.visit_date AS missing_date
      FROM (SELECT visit_date
           FROM  person_visits 
           WHERE person_id BETWEEN 1 AND 2
           ) AS pv1
RIGHT JOIN person_visits pv2 ON pv1.visit_date = pv2.visit_date
     WHERE pv1.visit_date IS NULL
  ORDER BY pv2.visit_date ASC;

    SELECT  CASE WHEN (person.name IS NULL) 
                 THEN '-'
                 ELSE person.name 
            END AS person_name,
            pv1.visit_date,
            CASE WHEN (pizzeria.name IS NULL)
                 THEN '-'
                 ELSE pizzeria.name
            END AS pizzeria_name
     FROM (SELECT visit_date,
                  person_id,
                  pizzeria_id
            FROM  person_visits 
            WHERE visit_date BETWEEN '2022-01-01' AND '2022-01-03'
           ) AS pv1
    FULL JOIN pizzeria ON pizzeria.id = pv1.pizzeria_id
    FULL JOIN person   ON person.id = pv1.person_id
    ORDER BY 1,2,3
