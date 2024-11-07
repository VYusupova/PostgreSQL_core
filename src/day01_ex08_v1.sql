--Andrey (age:21) 

       select order_date,
              CONCAT(person.NAME, ' (age:', person.age, ')') as  person_information 
         from (SELECT order_date, 
                      person_id as id 
                 from person_order)
 NATURAL JOIN person 
 ORDER BY 1,2