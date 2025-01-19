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
