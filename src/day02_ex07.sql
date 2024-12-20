
SELECT pizzeria.name FROM person 
JOIN person_visits ON person_id = person.id
JOIN pizzeria      ON pizzeria.id = pizzeria_id
JOIN menu		   ON menu.pizzeria_id = pizzeria.id	
where person.NAME = 'Dmitriy'
and visit_date = '2022-01-08'
AND price < 800
