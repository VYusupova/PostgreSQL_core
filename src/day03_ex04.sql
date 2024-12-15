WITH orders (person_id, pizzeria_id) AS 
(
	SELECT person_id, menu.pizzeria_id 
      FROM person_order
	  JOIN menu ON menu_id = menu.id
 ),
 orders_only_female(pizzeria_id) AS
 (
	 SELECT DISTINCT pizzeria_id 
       from orders
 	   JOIN person ON person_id = person.id AND person.gender = 'female'  
 	   EXCEPT
 	 SELECT DISTINCT  pizzeria_id from orders
 	   JOIN person ON person_id = person.id AND person.gender = 'male'
 ),
 orders_only_male(pizzeria_id) AS
 (
	 SELECT DISTINCT pizzeria_id 
       from orders
 	   JOIN person ON person_id = person.id AND person.gender = 'male'  
 	   EXCEPT
 	 SELECT DISTINCT  pizzeria_id from orders
 	   JOIN person ON person_id = person.id AND person.gender = 'female'
 )
 
 SELECT NAME AS pizzeria_name FROM pizzeria 
 JOIN (
 SELECT pizzeria_id from  orders_only_female
 UNION
 SELECT pizzeria_id from  orders_only_male
   )
   ON pizzeria_id = pizzeria.id
 