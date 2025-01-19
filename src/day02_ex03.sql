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

-- __________________________
WITH pizza (pizzeria_id, pizza_name, price) AS (
SELECT pizzeria_id, pizza_name, price from menu where pizza_name in ('mushroom pizza', 'pepperoni pizza')
 )
 
 SELECT pizza_name, NAME as pizzeria_name, price from pizza
 JOIN pizzeria ON id = pizzeria_id
 ORDER BY 1,2

-- __________________________

SELECT name
  FROM person
 WHERE age > 25
   AND gender = 'female'
ORDER BY name
-- __________________________

  SELECT menu.pizza_name, 
         pizzeria.name 
    FROM person 
    JOIN person_order ON person.id = person_id 
    JOIN menu         ON menu_id = menu.id
    JOIN pizzeria     ON pizzeria_id = pizzeria.id
   WHERE person.name IN ('Anna', 'Denis') 
 ORDER BY 1,2

-- __________________________

SELECT pizzeria.name FROM person 
JOIN person_visits ON person_id = person.id
JOIN pizzeria      ON pizzeria.id = pizzeria_id
JOIN menu		   ON menu.pizzeria_id = pizzeria.id	
where person.NAME = 'Dmitriy'
and visit_date = '2022-01-08'
AND price < 800


