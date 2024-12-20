
WITH pop (id) AS
(
 SELECT person_id
  FROM person_order
  JOIN menu ON menu_id = menu.id
 WHERE pizza_name in ( 'cheese pizza')
 INTERSECT
 SELECT person_id
  FROM person_order
  JOIN menu ON menu_id = menu.id
 WHERE pizza_name in ( 'pepperoni pizza')
)

 SELECT DISTINCT person.name
   FROM person
   JOIN pop ON person.id = pop.id
   WHERE gender = 'female'
 ORDER BY 1
