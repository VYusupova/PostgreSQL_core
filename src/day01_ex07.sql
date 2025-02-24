--Andrey (age:21) 

select order_date,
       CONCAT(person.NAME, ' (age:', person.age, ')') as  person_information from person_order
 JOIN person  ON person.id = person_id
 ORDER BY 1,2

--EX08 -- 2 version
       --#version 1
--Andrey (age:21) 

       select order_date,
              CONCAT(person.NAME, ' (age:', person.age, ')') as  person_information 
         from (SELECT order_date, 
                      person_id as id 
                 from person_order)
 NATURAL JOIN person 
 ORDER BY 1,2
   --#version 2
--Andrey (age:21) 

       select order_date,
              person_information 
         from person_order
 NATURAL JOIN (SELECT id AS person_id,
                      CONCAT(person.NAME, ' (age:', person.age, ')') as  person_information 
                 FROM person)
 ORDER BY 1,2
