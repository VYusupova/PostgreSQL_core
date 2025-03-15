--- Exercise 00: Let’s find appropriate prices for Kate---
-----------вернуть список наименование пиццы, цена, название пиццерии и в дату визита Кати и цена пиццы от 800 до 1000. 
-----------Отсоритируйте по названию цены и названию пиццерии. 
WITH pp_visit(piz_id, date) AS
(
SELECT pizzeria_id,
       visit_date
  FROM person
  JOIN person_visits  ON person_id = person.id
 WHERE name = 'Kate'
)
SELECT pizza_name,
       price,
       name AS pizzeria_name,
       date AS visit_date
  FROM pizzeria
 JOIN pp_visit ON piz_id = id
 JOIN menu     ON pizzeria_id = pizzeria.id
WHERE price BETWEEN '800' AND '1000'
ORDER BY 1,2,3

-- Exercise 01: Let’s find forgotten menus	--
-----------найдите все идентификаторы в меню? которые никто не заказывал. Результат должен быть отсортирован.
SELECT id 
  FROM menu 
 WHERE id NOT IN (SELECT menu_id 
                    FROM person_order) 
ORDER BY id

-- Exercise 02: Let’s find forgotten pizza and pizzerias ----
----------- Используя запрос из упраженния 1 и покажите названия пицц из пиццерий которые никто никогда не заказывал, включая соответвующую цену. 
SELECT menu.pizza_name, 
       menu.price, 
       pizzeria.name AS pizzeria_name 
  FROM menu
 JOIN pizzeria ON pizzeria_id = pizzeria.id
where menu.id NOT IN (SELECT menu_id 
                        FROM person_order) 
ORDER BY menu.pizza_name, 
         menu.price

-- Решения #2 без JOIN

SELECT menu.pizza_name, 
       menu.price, 
       (SELECT pizzeria.name 
          FROM pizzeria 
         WHERE pizzeria_id = pizzeria.id )  AS pizzeria_name 
  FROM menu
where menu.id NOT IN (SELECT menu_id 
                        FROM person_order) 
ORDER BY menu.pizza_name, 
         menu.price

-- Exercise 03: Let’s compare visits -- -- --
----------- найти пиццерии которые часто посещали мужчины или женщины. для любого оператора множестово вывода должно сохранять дубликаты
WITH 
female_visit AS (
	           SELECT pizzeria.name      AS pizzeria_name, 
                         Count(pizzeria_id) AS cnt
  	             FROM pizzeria
                    JOIN person_visits ON pizzeria.id = person_visits.pizzeria_id
                    JOIN person        ON person_id = person.id AND person.gender = 'female' 
  GROUP BY 1
  ),
male_visit AS (
    SELECT pizzeria.name AS pizzeria_name , 
           Count(pizzeria_id) AS cnt 
  	  FROM pizzeria
      JOIN person_visits ON pizzeria.id = person_visits.pizzeria_id
      JOIN person        ON person_id = person.id AND person.gender = 'male'
  GROUP BY 1
  )

SELECT female_visit.pizzeria_name
  FROM female_visit 
  JOIN male_visit ON female_visit.pizzeria_name = male_visit.pizzeria_name 
WHERE  female_visit.cnt > male_visit.cnt
UNION ALL
SELECT female_visit.pizzeria_name
  FROM female_visit
  JOIN male_visit ON female_visit.pizzeria_name = male_visit.pizzeria_name 
WHERE female_visit.cnt < male_visit.cnt
ORDER BY 1

-- Exercise 04: Let’s compare orders -- -- -- --
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
