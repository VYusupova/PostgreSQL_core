
WITH pop (id) AS
(
SELECT person_id as id 
  FROM person_order
  JOIN menu ON menu_id = menu.id
 WHERE pizza_name in ( 'pepperoni pizza', 'mushroom pizza')
)
 
 SELECT person.name 
   FROM person
   join pop ON person.id = pop.id 
  WHERE gender = 'male' 
    AND address in ('Moscow', 'Samara')
 ORDER BY 1 DESC