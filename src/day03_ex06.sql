
 With pizzeria1 AS
 (
  select menu.id, pizza_name, pizzeria.name, price FROM menu 
   JOIN pizzeria ON menu.pizzeria_id = pizzeria.id
 )
 			
 SELECT p1.pizza_name, p1.name AS pizzeria_name_1, p2.name AS pizzeria_name_2, p1.price FROM pizzeria1 p1
 JOIN pizzeria1 p2 ON p1.pizza_name = p2.pizza_name AND p1.name != p2.name AND p1.price = p2.price
 WHERE p1.id > p2.id
 ORDER BY p1.pizza_name