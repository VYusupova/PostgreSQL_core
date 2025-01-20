--ex 04
CREATE VIEW v_symmetric_union AS
WITH
	R AS (SELECT * 
	        FROM person_visits
			WHERE visit_date = '2022-01-02'),
	S AS (SELECT * 
	        FROM person_visits
		 	WHERE visit_date = '2022-01-06'),
	R_diff_S AS (SELECT * FROM R
					EXCEPT 
				 SELECT * FROM S),
	S_diff_R AS (SELECT * FROM S
					EXCEPT 
				 SELECT * FROM R)
SELECT person_id FROM R_diff_S
UNION
SELECT person_id FROM S_DIFF_R
ORDER BY person_id;

select * from v_symmetric_union

--ex 05
CREATE VIEW v_price_with_discount AS
SELECT person.name,
       menu.pizza_name, 
       menu.price, 
       ceil(price -price*0.1) AS discount_price 
FROM person_order
JOIN person ON person.id = person_id
JOIN menu   ON menu.id = menu_id
ORDER BY person.name, menu.pizza_name

--ex06
CREATE MATERIALIZED VIEW mv_dmitriy_visits_and_eats AS
SELECT DISTINCT pizzeria.name 
  FROM person_visits
  JOIN person   ON person.id = person_id
  JOIN pizzeria ON pizzeria.id = pizzeria_id
  JOIN menu     ON menu.pizzeria_id = pizzeria.id
 WHERE person.name = 'Dmitriy'
   AND visit_date = '2022-01-08'
   AND price < 800

--ex 07

INSERt INTO person_visits  (id, person_id, pizzeria_id, visit_date)
VALUES (
  (SELECT MAX(id)+1 FROM person_visits),
  (SELECT id FROM person WHERe name =  'Dmitriy'),
  (SELECT pizzeria.id FROM pizzeria 
   JOIN menu ON pizzeria_id = pizzeria.id
   WHERE name not in (SELECT name FROM  mv_dmitriy_visits_and_eats) 
   AND price < 800 
   LIMIT 1),
  '2022-01-08'
  )
  ;
  REFRESH MATERIALIZED VIEW   mv_dmitriy_visits_and_eats

--ex 08
DROP VIEW IF EXISTS v_persons_female;
DROP VIEW IF EXISTS v_persons_male;
DROP VIEW IF EXISTS v_price_with_discount;
DROP VIEW IF EXISTS v_symmetric_union;
DROP VIEW IF EXISTS v_generated_dates;
DROP MATERIALIZED VIEW IF EXISTS  mv_dmitriy_visits_and_eats;
