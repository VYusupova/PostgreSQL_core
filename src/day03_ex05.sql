WITH 
visit AS (
  SELECT pizzeria_id, person.name
    FROM person_visits
    JOIN person ON person_id = person.id 
),
orders AS (
  SELECT pizzeria_id, person.name 
    FROM person_order 
    JOIN person ON person_id = person.id
    JOIN menu ON menu_id = menu.id
)

SELECT name AS pizzeria_name 
  FROM pizzeria
  JOIN(
       SELECT pizzeria_id FROM visit WHERE name = 'Andrey'
       EXCEPT
       SELECT pizzeria_id FROM orders WHERE name = 'Andrey'
) ON pizzeria.id = pizzeria_id
ORDER BY 1
