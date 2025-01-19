--Exercise 00 - Simple aggregated information
--_________________________________________________________
SELECT person_id,
         COUNT(*) AS count_of_visits
    FROM person_visits 
    JOIN person ON person_id = person.id
GROUP BY person_id
ORDER BY count_of_visits DESC, person_id ASC

--Exercise 01 - Let’s see real names
--_________________________________________________________
  SELECT name,
         COUNT(*) AS count_of_visits
    FROM person_visits 
    JOIN person ON person_id = person.id
GROUP BY name
ORDER BY count_of_visits DESC, name ASC
limit 4
--Exercise 02 - Restaurants statistics
--_________________________________________________________
 WITH orders AS 
 (SELECT name,
         COUNT(*) AS count,
         'orders' AS action_type
    FROM person_order
    JOIN menu on menu_id = menu.id
    JOIN pizzeria ON pizzeria_id = pizzeria.id
GROUP BY name
ORDER BY count DESC, name ASC
limit 3
 ),
visit AS 
(SELECT name,
         COUNT(*) AS count ,
         'visits' AS action_type
    FROM person_visits 
    JOIN pizzeria ON pizzeria_id = pizzeria.id
GROUP BY name
ORDER BY count DESC, name ASC
limit 3  )

SELECT * FROM orders
UNION ALL
SELECT * FROM visit
--Exercise 03 - Restaurants statistics #2
--_________________________________________________________
 WITH orders AS 
 (SELECT name,
         COUNT(pizzeria_id) AS count,
         'orders' AS action_type
    FROM person_order
    JOIN menu on menu_id = menu.id
    RIGHT JOIN pizzeria ON pizzeria_id = pizzeria.id
GROUP BY name
ORDER BY count DESC, name ASC

 ),
visit AS 
(SELECT name,
         COUNT(pizzeria_id) AS count ,
         'visits' AS action_type
    FROM person_visits 
    RIGHT JOIN pizzeria ON pizzeria_id = pizzeria.id
GROUP BY name
ORDER BY count DESC, name ASC
 )

--SELECT * FROM orders
--UNION ALL
--SELECT * FROM visit

/* version #1 
SELECT orders.name, 
       orders.count + visit.count AS total_count
  FROM orders
  JOIN visit ON orders.name = visit.name
ORDER BY total_count DESC, 1 ASC
*/

/* version #2 */ 
SELECT name, SUM(Count) AS total_count FROM 
(
SELECT name, count FROM orders
UNION ALL
SELECT name, count from visit
)
GROUP BY name
ORDER BY total_count DESC, 1 ASC
