SELECT name, 
       age
  FROM person 
 WHERE address = 'Kazan'
---------------- (Упражение) 00 — Первые шаги в мире SQL  ----------------
  SELECT name, 
         age
    FROM person 
   WHERE gender = 'female' 
     AND address = 'Kazan'
ORDER BY name
----------------  (Упражение) 01 — Первые шаги в мире SQL ----------------
   SELECT name,
          rating
     FROM pizzeria
    WHERE rating >= 3.5
      AND rating <= 5
 ORDER BY rating;
  
   SELECT name,
          rating
     FROM pizzeria
    WHERE rating BETWEEN 3.5 AND 5
 ORDER BY rating;
----------------  (Упражение) 02  — Первые шаги в мире SQL ----------------
  SELECT distinct person_id 
    FROM person_visits  
   WHERE visit_date BETWEEN '2022-01-06' AND '2022-01-09' 
      OR pizzeria_id = 2
ORDER BY person_id DESC
----------------  (Упражение) 03  — Первые шаги в мире SQL ----------------
--`Anna (age:16,gender:'female',address:'Moscow')`

SELECT CONCAT(name, ' (', 
              'age:', age , 
              ',gender:''', gender, 
              ''',address:''', address, 
              ''')') as person_information
  FROM person
ORDER BY 1
----------------  (Упражение) 05  — Первые шаги в мире SQL ----------------
SELECT 
       ( SELECT name 
           From person 
          where id = person_id 
       ) as name
  from person_order 
 where menu_id in (13,14,18)
   and order_date = '2022-01-07';

----------------  (Упражение) 06  — Первые шаги в мире SQL ----------------
SELECT 
       ( SELECT name 
           From person 
          where id = person_id 
       ) as name,
       
        case when person_id = (select id 
                                 from person 
                                where name = 'Denis')
        then 'true'
        else 'false'
        end as check_name
          
  from person_order 
 where menu_id in (13,14,18)
   and order_date = '2022-01-07';
----------------  (Упражение) 07  — Первые шаги в мире SQL ----------------
    --if (age >= 10 and age <= 20) then return 'interval #1'
    --else if (age > 20 and age < 24) then return 'interval #2'
    --else return 'interval #3'
    
    select id,
    	   name,
           case WHEN age >= 10 and age <= 20 
           then 'interval #1'
           else CASE WHEN age > 20 and age < 24 
                THEN 'interval #2'
                else 'interval #3'
                END
           end AS interval_info
      from person
      order by interval_info
----------------  (Упражение) 08  — Первые шаги в мире SQL ----------------
SELECT *
  from person_order
  where id%2=0
  order by id
----------------  (Упражение) 09  — Первые шаги в мире SQL ----------------
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
