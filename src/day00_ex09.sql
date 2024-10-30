SELECT (SELECT name 
          from person 
         where id = pv.person_id) AS person_name ,  
       (SELECT name 
          from pizzeria
         where id = pv.pizzeria_id) AS pizzeria_name  
    FROM (SELECT person_id, 
                 pizzeria_id 
            FROM person_visits
           Where visit_date BETWEEN '2022-01-07' and '2022-01-09') AS pv 
    ORDER BY 1 asc, 2 DESC