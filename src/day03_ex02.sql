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
