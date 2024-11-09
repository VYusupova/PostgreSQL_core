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