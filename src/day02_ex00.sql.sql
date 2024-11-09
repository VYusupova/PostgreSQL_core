   SELECT NAME, 
          rating 
     FROM pizzeria 
LEFT JOIN person_visits ON pizzeria.id = pizzeria_id
WHERE pizzeria_id is NULL
