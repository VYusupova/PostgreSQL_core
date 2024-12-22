WITH pizzeria AS
 (
  SELECT menu.id,
         pizza_name,
         pizzeria.name AS pizzeria_name, 
         price
    FROM menu
    JOIN pizzeria ON menu.pizzeria_id = pizzeria.id
 )

 SELECT p1.pizza_name,
        p1.pizzeria_name AS pizzeria_name_1,
        p2.pizzeria_name AS pizzeria_name_2,
        p1.price
   FROM pizzeria p1
   JOIN pizzeria p2 ON p1.pizza_name = p2.pizza_name
                     AND p1.pizzeria_name != p2.pizzeria_name
                     AND p1.price = p2.price
 WHERE p1.id > p2.id
 ORDER BY p1.pizza_name
