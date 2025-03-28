----------------  (Упражение) 00  -- необходимо вернуть список названий пиццерий с рейтингом которые никто не посещал
SELECT NAME, 
          rating 
     FROM pizzeria 
LEFT JOIN person_visits ON pizzeria.id = pizzeria_id
WHERE pizzeria_id is NULL;

----------------  (Упражение) 01 -- вернуть потерянные даты с 1 по 10 января 2022 (включительно) 
-----------посещений с идентификатором 1 или 2 (это значит дней дней утеряно оба)
-----------отсортируйте дни посещений по возрастанию
    SELECT DISTINCT pv2.visit_date AS missing_date
      FROM (SELECT visit_date
           FROM  person_visits 
           WHERE person_id BETWEEN 1 AND 2
           ) AS pv1
RIGHT JOIN person_visits pv2 ON pv1.visit_date = pv2.visit_date
     WHERE pv1.visit_date IS NULL
  ORDER BY pv2.visit_date ASC;

----------------  (Упражение)02 -- вернуть весь список имен посетителей( или не посетителей)пиццерий 
-----------за период с 1 по 3 января 2022 с одной стороны и весь список названий пиццерий 
-----------который имеет и не имет посетителй с другой стороны. 
--------------Обратите внимание на замену ‘-’ for NULL значений в столбцах.
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
----------------  (Упражение)03 -- вернемся к упраженению 1 перепешите ваш SQL с использованием СТЕ паттерна. перемести в часть СТЕ ваш "генератор дней". Вывод должен быть таким же как в упражнениии 1

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

----------------  (Упражение)04 --__________________________
WITH pizza (pizzeria_id, pizza_name, price) AS (
SELECT pizzeria_id, pizza_name, price from menu where pizza_name in ('mushroom pizza', 'pepperoni pizza')
 )
 
 SELECT pizza_name, NAME as pizzeria_name, price from pizza
 JOIN pizzeria ON id = pizzeria_id
 ORDER BY 1,2

----------------  (Упражение)05 -- __________________________

SELECT name
  FROM person
 WHERE age > 25
   AND gender = 'female'
ORDER BY name
----------------  (Упражение)06 -- __________________________

  SELECT menu.pizza_name, 
         pizzeria.name 
    FROM person 
    JOIN person_order ON person.id = person_id 
    JOIN menu         ON menu_id = menu.id
    JOIN pizzeria     ON pizzeria_id = pizzeria.id
   WHERE person.name IN ('Anna', 'Denis') 
 ORDER BY 1,2

----------------  (Упражение)07 -- __________________________

SELECT pizzeria.name FROM person 
JOIN person_visits ON person_id = person.id
JOIN pizzeria      ON pizzeria.id = pizzeria_id
JOIN menu		   ON menu.pizzeria_id = pizzeria.id	
where person.NAME = 'Dmitriy'
and visit_date = '2022-01-08'
AND price < 800

----------------  (Упражение)08 -- __________________________
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

----------------  (Упражение)09 -- __________________________
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
----------------  (Упражение) 10 -- Найти все людей, которые живут по одному адресу. __________________________

SELECT  person1.name AS person_name1, 
        person2.name AS person_name2, 
        person1.address AS common_address
   FROM person AS person1
   JOIN person AS person2 ON person1.address = person2.address
  WHERE person1.id > person2.id
ORDER BY 1, 2, 3;
