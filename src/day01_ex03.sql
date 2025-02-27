--ex 03

SELECT order_date as action_date, person_id from person_order 
INTERSECT
select visit_date as action_date, person_id from person_visits
order by 1 ASC, 2 DESC

  
--ex 04


SELECT person_id from person_order where order_date = '2022-01-07'
EXCEPT all
select person_id from person_visits where visit_date = '2022-01-07'

--EX 05
-- person.id | person.name | age | gender | address | pizzeria.id | pizzeria.name | rating |
SELECT  person.id as "person.id", 
        person.name AS "person.name",
        age, 
        gender, 
        address , 
        pizzeria.id AS "pizzeria.id",
        pizzeria.name AS "pizzeria.name",
        rating
   FROM person, pizzeria
ORDER BY person.id, pizzeria.id 

  --EX 06
--version 1
SELECT order_date AS action_date, (SELECT name FROM person where id = person_id) AS person_name FROM person_order 
INTERSECT
SELECT visit_date AS action_date, (SELECT name FROM person where id = person_id) AS person_name FROM person_visits
ORDER BY 1 ASC, 2 DESC

--version 2
SELECT action_date,
      (SELECT name FROM person WHERE id = person_id) AS person_name
  FROM
      (SELECT order_date AS action_date,
              person_id
         FROM person_order
       INTERSECT
       SELECT  visit_date AS action_date,
               person_id
          FROM person_visits
       )
ORDER BY 1 ASC, 2 DESC

--ex 07
  --Andrey (age:21) 

SELECT order_date,
       CONCAT(person.NAME, ' (age:', person.age, ')') AS  person_information 
 FROM person_order
 JOIN person  ON person.id = person_id
ORDER BY 1,2

--ex 08 version 1
--Andrey (age:21) 

       SELECT order_date,
              CONCAT(person.NAME, ' (age:', person.age, ')') AS  person_information 
         FROM (SELECT order_date, 
                      person_id AS id 
                 FROM person_order)
 NATURAL JOIN person 
 ORDER BY 1,2
--ex 08 version 2
--Andrey (age:21) 

       SELECT order_date,
              person_information 
         FROM person_order
 NATURAL JOIN (SELECT id AS person_id,
                      CONCAT(person.NAME, ' (age:', person.age, ')') AS  person_information 
                 FROM person)
 ORDER BY 1,2


--ex 09 version 1
Select name from pizzeria where id not in (SELECT pizzeria_id from person_visits)
--ex 09 version 2
Select name from pizzeria where not EXISTS (SELECT pizzeria_id from person_visits where pizzeria.id = pizzeria_id)

--ex 10 
  Select person.name,
  	     menu.pizza_name,
         pizzeria.name
    FROM person
    JOIN person_order on person.id = person_order.person_id
    JOIN menu         ON person_order.menu_id = menu.id
    JOIN pizzeria     ON menu.pizzeria_id = pizzeria.id
ORDER BY 1,2,3
