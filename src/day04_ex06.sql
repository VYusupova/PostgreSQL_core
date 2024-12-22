CREATE MATERIALIZED VIEW mv_dmitriy_visits_and_eats AS
SELECT DISTINCT pizzeria.name 
  FROM person_visits
  JOIN person   ON person.id = person_id
  JOIN pizzeria ON pizzeria.id = pizzeria_id
  JOIN menu     ON menu.pizzeria_id = pizzeria.id
 WHERE person.name = 'Dmitriy'
   AND visit_date = '2022-01-08'
   AND price < 800
