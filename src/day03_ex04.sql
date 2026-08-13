-- ex 04 -- найти пиццерий в которыйх были заказы как мужчин так и женщин. 
-- Другими словами, вам надо найти множество названий пиццерий в который заказывали только женщины и обеденить с множеством пиццерий где заказывали только мужчины. 
-- Убедитесь со словом "только" для обеих полов. Для любых операторова SQL в множестве не должно быть дублей (UNION, EXCEPT, INTERSECT). Результат отсортируйте. 
WITH orders (person_id, pizzeria_id) AS
(
	SELECT person_id,
	       menu.pizzeria_id
      FROM person_order
	  JOIN menu ON menu_id = menu.id
 ),
 orders_only_female(pizzeria_id) AS
 (
	 SELECT DISTINCT pizzeria_id
       FROM orders
 	   JOIN person ON person_id = person.id AND person.gender = 'female'
 	   EXCEPT
 	 SELECT DISTINCT  pizzeria_id
 	 FROM orders
     JOIN person ON person_id = person.id AND person.gender = 'male'
 ),
 orders_only_male(pizzeria_id) AS
 (
	 SELECT DISTINCT pizzeria_id
       FROM orders
 	   JOIN person ON person_id = person.id AND person.gender = 'male'
 	   EXCEPT
 	 SELECT DISTINCT  pizzeria_id
 	 FROM orders
     JOIN person ON person_id = person.id AND person.gender = 'female'
 )

 SELECT NAME AS pizzeria_name
   FROM pizzeria
 JOIN (SELECT pizzeria_id
         FROM  orders_only_female
        UNION
       SELECT pizzeria_id
         FROM  orders_only_male
) ON pizzeria_id = pizzeria.id

-- ex 05 Вернуть список пиццерй с визитом Андрея но в которых он не сделал заказ. Сортируйте по названию
WITH visit AS (
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


