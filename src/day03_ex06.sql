-- ex 06 Найти несколько пицц названия которых имеют одинаковую стоимость но в разных пицериях.
-- -- Убедитесь что результат отсортирован по названию пицц. Простоой вывод представлен ниже. Пожалуйста проверьте что названия столбцов такие же как ниже.
--my output -----------------------------------------------------
-- _____________________________________________________________
-- cheese pizza	      |  Best Pizza  |  	Papa Johns	  |  700
-- pepperoni pizza	   |  Best Pizza  |  	DinoPizza	   |  800
-- supreme pizza	     |  Best Pizza  |  	DoDo Pizza	  |  850
-- _____________________________________________________________

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


--EX 07 зарегистрировать новую пиццу “greek pizza” (use id = 19) ценой 800 руб в ресторане “Dominos” (pizzeria_id = 2).
INSERT INTO menu (id, pizzeria_id, pizza_name, price)  VALUES (19, 2, 'greek pizza', 800)
-- new variant 
 -- declare @name_pizza varchar (100) = 'greek pizza'
 -- declare @price int = 800
 -- declare @pizzeriaid int = (SELECT pizzeria_id FROM pizzeria WHERE name = 'Dominos')
 -- INSERT INTO menu (id, pizzeria_id, pizza_name, price)  VALUES (19, @pizzeriaid, @name_pizza, @price)
--EX 08
INSERT INTO menu (id, pizzeria_id, pizza_name, price)  
VALUES ((SELECT MAX(id)+1 FROM menu),
        (SELECT id FROM pizzeria WHERE name = 'Dominos'), 
        'sicilian pizza', 
        900)

--EX 09
INSERT INTo person_visits (id, person_id, pizzeria_id, visit_date)
VALUES(
  (SELECT MAX(id)+1 FROM person_visits),
  (SELECT id FROM person WHERE name = 'Denis'),
  (SELECT id FROM pizzeria WHERE name = 'Dominos'),
  '2022-02-24'
  ),
  (
  (SELECT MAX(id)+2 FROM person_visits),
  (SELECT id FROM person WHERE name = 'Irina'),
  (SELECT id FROM pizzeria WHERE name = 'Dominos'),
  '2022-02-24'
  )

--EX 10

INSERT INTo person_order (id, person_id, menu_id, order_date)
VALUES(
  (SELECT MAX(id)+1 FROM person_order),
  (SELECT id FROM person WHERE name = 'Denis'),
  (SELECT id FROM menu WHERE pizza_name = 'sicilian pizza'),
  '2022-02-24'
  ),
  (
  (SELECT MAX(id)+2 FROM person_order),
  (SELECT id FROM person WHERE name = 'Irina'),
  (SELECT id FROM menu WHERE pizza_name = 'sicilian pizza'),
  '2022-02-24'
  )

   
