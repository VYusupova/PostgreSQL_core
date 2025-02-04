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
--my output -----------------------------------------------------
-- _____________________________________________________________
-- cheese pizza	      |  Best Pizza  |  	Papa Johns	  |  700
-- pepperoni pizza	   |  Best Pizza  |  	DinoPizza	   |  800
-- supreme pizza	     |  Best Pizza  |  	DoDo Pizza	  |  850
-- _____________________________________________________________

-- original --- 
SELECT m1.pizza_name, 
       p1.name AS pizzeria_name_1, 
       p2.name AS pizzeria_name_2, 
       m1.price 
FROM menu m1 
INNER JOIN menu m2 ON m1.id <> m2.id AND m1.price = m2.price AND m1.pizzeria_id > m2.pizzeria_id 
AND m1.pizza_name = m2.pizza_name 
INNER JOIN pizzeria p1 ON m1.pizzeria_id = p1.id
INNER JOIN pizzeria p2 ON m2.pizzeria_id = p2.id 
ORDER BY 1

-- _____________________________________________________________
-- cheese pizza	      |  Best Pizza  |  	Papa Johns	  |  700
-- pepperoni pizza	   | 	DinoPizza	  |   Best Pizza   |  800  <<-- this String 
-- supreme pizza	     |  Best Pizza  |  	DoDo Pizza	  |  850
-- _____________________________________________________________
