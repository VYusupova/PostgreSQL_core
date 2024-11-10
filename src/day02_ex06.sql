
  SELECT menu.pizza_name, 
         pizzeria.name 
    FROM person 
    JOIN person_order ON person.id = person_id 
    JOIN menu         ON menu_id = menu.id
    JOIN pizzeria     ON pizzeria_id = pizzeria.id
   WHERE person.name IN ('Anna', 'Denis') 
 ORDER BY 1,2
 