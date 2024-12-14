SELECT menu.pizza_name, menu.price, pizzeria.name AS pizzeria_name FROM menu
JOIN pizzeria ON pizzeria_id = pizzeria.id
where menu.id not IN (SELECT menu_id FROM person_order) order by menu.pizza_name, menu.price