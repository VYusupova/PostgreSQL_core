--Andrey (age:21) 

       select order_date,
              person_information 
         from person_order
 NATURAL JOIN (SELECT id AS person_id,
                      CONCAT(person.NAME, ' (age:', person.age, ')') as  person_information 
                 FROM person)
 ORDER BY 1,2