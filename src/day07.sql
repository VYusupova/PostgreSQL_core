--_________________________________________________________
--Exercise 00 - Simple aggregated information
--_________________________________________________________
SELECT person_id,
       COUNT(*) AS count_of_visits
    FROM person_visits 
    JOIN person ON person_id = person.id
GROUP BY person_id
ORDER BY count_of_visits DESC, person_id ASC
--_________________________________________________________
--Exercise 01 - Let’s see real names
--_________________________________________________________
  SELECT name,
         COUNT(*) AS count_of_visits
    FROM person_visits 
    JOIN person ON person_id = person.id
GROUP BY name
ORDER BY count_of_visits DESC, name ASC
LIMIT 4
--_________________________________________________________
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
      ORDER BY count DESC
LIMIT 3
 ),
visit AS 
(SELECT name,
         COUNT(*) AS count ,
         'visit' AS action_type
    FROM person_visits 
    JOIN pizzeria ON pizzeria_id = pizzeria.id
GROUP BY name
       ORDER BY count DESC
LIMIT 3  
)

SELECT * FROM orders
UNION
SELECT * FROM visit
ORDER BY action_type ASC, count DESC
--_________________________________________________________
--Exercise 03 - Restaurants statistics #2
--_________________________________________________________

 WITH orders AS 
 (SELECT name,
         COUNT(pizzeria_id) AS count
    FROM person_order
    JOIN menu on menu_id = menu.id
    RIGHT JOIN pizzeria ON pizzeria_id = pizzeria.id
GROUP BY name
 ),
visit AS 
(SELECT name,
         COUNT(pizzeria_id) AS count 
    FROM person_visits 
    RIGHT JOIN pizzeria ON pizzeria_id = pizzeria.id
GROUP BY name
 )

SELECT name, SUM(Count) AS total_count FROM 
(
SELECT name, count FROM orders
UNION ALL
SELECT name, count FROM visit
)
GROUP BY name
ORDER BY total_count DESC, 1 ASC


--_________________________________________________________
-- Exercise 04 - Clause for groups
--_________________________________________________________
         
SELECT name, COUNT(*) AS count_of_visits
FROM person_visits 
JOIN person ON person_id = person.id
GROUP BY name
Having COUNT(*) > 3

       
--_________________________________________________________
-- Exercise 05 - Person's uniqueness
--_________________________________________________________
        
SELECT distinct name FROM person_order 
JOIN  person ON person_id = person.id
ORDER BY  1

       
--_________________________________________________________
-- Exercise 06 - Restaurant metrics
--_________________________________________________________
        /*name	count_of_orders	average_price	max_price	min_price*/
SELECT pizzeria.name, 
      COUNT(*)            AS count_of_orders,
      ROUND(AVG(price),2) AS average_price,
      MAX(PRICE)          AS max_price,
      min(PRICE)          AS min_price
FROM person_order 
JOIN menu     ON menu_id = menu.id
JOIN pizzeria ON pizzeria_id = pizzeria.id

GROUP BY pizzeria.name
ORDER BY pizzeria.name

       
--_________________________________________________________
-- Exercise 07 - Average global rating
--_________________________________________________________
SELECT ROUND(AVG(rating),4) AS global_rating
FROM pizzeria
         
--_________________________________________________________
-- Exercise 08 - Find pizzeria’s restaurant locations
--_________________________________________________________
         -- address	name	count_of_orders
SELECT person.address,
       pizzeria.name, 
      COUNT(*) AS count_of_orders
 FROM person_order 
 JOIN menu      ON menu_id = menu.id
 JOIN pizzeria  ON pizzeria_id = pizzeria.id
 JOIN person    ON person_order.person_id = person.id
GROUP BY  person.address, pizzeria.name
ORDER BY  person.address, pizzeria.name

--_________________________________________________________
-- Exercise 09 - Explicit type transformation
--_________________________________________________________
WITH formula AS (
SELECT  address,
        round(MAX(age)-(min(age)::NUMERIC(4,2)/MAX(age)),2) AS formula,
        AVG(age)::NUMERIC(4,2) AS average
   FROM person GROUP BY address ORDER BY address
)

SELECT *, 
       CASE WHEN (formula > average) 
            THEN 'true'
            ELSE 'false'
       END AS comparison
FROM formula
