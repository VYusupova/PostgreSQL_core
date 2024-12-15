WITH visit AS 
( Select pizzeria_id, person.name
    from person_visits
    JOIN person ON person_id = person.id 
),
orders AS (
Select pizzeria_id, person.name from person_order 
JOIN person ON person_id = person.id
JOIN menu ON menu_id = menu.id
)

SELECT name as pizzeria_name FROM pizzeria
JOIN(
Select pizzeria_id FROM visit where name = 'Andrey'
EXCEPT
SELECT pizzeria_id FROM orders where name = 'Andrey'
) ON pizzeria.id = pizzeria_id