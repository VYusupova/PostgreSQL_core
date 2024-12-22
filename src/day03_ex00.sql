WITH pp_visit(piz_id, date) AS
(
SELECT pizzeria_id,
       visit_date
  FROM person
  JOIN person_visits  ON person_id = person.id
 WHERE name = 'Kate'
)
SELECT pizza_name,
       price,
       name AS pizzeria_name,
       date AS visit_date
  FROM pizzeria
 JOIN pp_visit ON piz_id = id
 JOIN menu     ON pizzeria_id = pizzeria.id
WHERE price BETWEEN '800' AND '1000'
ORDER BY 1,2,3,4
