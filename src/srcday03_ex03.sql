WITH 
female_visit AS (
	SELECT pizzeria.name AS pizzeria_name, 
           Count(pizzeria_id) as cnt
  	  from pizzeria
      JOIN person_visits ON pizzeria.id = person_visits.pizzeria_id
      Join person        ON person_id = person.id and person.gender = 'female' 
  GROUP BY 1
  ),
male_visit AS (
    SELECT pizzeria.name AS pizzeria_name , 
           Count(pizzeria_id) as cnt 
  	  from pizzeria
      JOIN person_visits ON pizzeria.id = person_visits.pizzeria_id
      Join person        ON person_id = person.id and person.gender = 'male'
  GROUP BY 1
  )

SELECT female_visit.pizzeria_name
  From female_visit 
  JOIN male_visit ON female_visit.pizzeria_name = male_visit.pizzeria_name 
   and female_visit.cnt > male_visit.cnt
UNION ALL
SELECT female_visit.pizzeria_name
  From female_visit
  JOIN male_visit ON female_visit.pizzeria_name = male_visit.pizzeria_name 
   and female_visit.cnt < male_visit.cnt
ORDER BY 1