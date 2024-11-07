--Andrey (age:21) 

select order_date,
       CONCAT(person.NAME, ' (age:', person.age, ')') as  person_information from person_order
 JOIN person  ON person.id = person_id
 ORDER BY 1,2