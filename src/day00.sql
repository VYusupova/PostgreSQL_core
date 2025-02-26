---------------- (Упражение) 00 — Первые шаги в мире SQL  ----------------
SELECT name, 
       age
  FROM person 
 WHERE address = 'Kazan'
---------------- (Упражение) 01 — Первые шаги в мире SQL  ----------------
  SELECT name, 
         age
    FROM person 
   WHERE gENDer = 'female' 
     AND address = 'Kazan'
ORDER BY name
----------------  (Упражение) 02 — Первые шаги в мире SQL ----------------
   SELECT name,
          ratINg
     FROM pizzeria
    WHERE ratINg >= 3.5
      AND ratINg <= 5
 ORDER BY ratINg;
  
   SELECT name,
          ratINg
     FROM pizzeria
    WHERE ratINg BETWEEN 3.5 AND 5
 ORDER BY ratINg;
----------------  (Упражение) 03  — Первые шаги в мире SQL ----------------
  SELECT DISTINCT person_id 
    FROM person_visits  
   WHERE visit_date BETWEEN '2022-01-06' AND '2022-01-09' 
      OR pizzeria_id = 2
ORDER BY person_id DESC
----------------  (Упражение) 04  — Первые шаги в мире SQL ----------------
--`Anna (age:16,gENDer:'female',address:'Moscow')`

SELECT CONCAT(name, ' (', 
              'age:', age , 
              ',gENDer:''', gENDer, 
              ''',address:''', address, 
              ''')') AS person_INformation
  FROM person
ORDER BY 1
----------------  (Упражение) 05  — Первые шаги в мире SQL ----------------
SELECT 
       ( SELECT name 
           FROM person 
          WHERE id = person_id 
       ) AS name
  FROM person_order 
 WHERE menu_id IN (13,14,18)
   AND order_date = '2022-01-07';

----------------  (Упражение) 06  — Первые шаги в мире SQL ----------------
SELECT 
       ( SELECT name 
           FROM person 
          WHERE id = person_id 
       ) AS name,
       
        CASE when person_id = (SELECT id 
                                 FROM person 
                                WHERE name = 'Denis')
        THEN 'true'
        ELSE 'false'
        END AS check_name
          
  FROM person_order 
 WHERE menu_id IN (13,14,18)
   AND order_date = '2022-01-07';
----------------  (Упражение) 07  — Первые шаги в мире SQL ----------------
    --if (age >= 10 AND age <= 20) THEN return 'INterval #1'
    --ELSE if (age > 20 AND age < 24) THEN return 'INterval #2'
    --ELSE return 'INterval #3'
    
    SELECT id,
    	   name,
           CASE WHEN age >= 10 AND age <= 20 
           THEN 'INterval #1'
           ELSE CASE WHEN age > 20 AND age < 24 
                THEN 'INterval #2'
                ELSE 'INterval #3'
                END
           END AS INterval_INfo
      FROM person
      ORDER BY INterval_INfo
----------------  (Упражение) 08  — Первые шаги в мире SQL ----------------
SELECT *
  FROM person_order
  WHERE id%2=0
  ORDER BY id
----------------  (Упражение) 09  — Первые шаги в мире SQL ----------------
SELECT (SELECT name 
          FROM person 
         WHERE id = pv.person_id) AS person_name ,  
       (SELECT name 
          FROM pizzeria
         WHERE id = pv.pizzeria_id) AS pizzeria_name  
    FROM (SELECT person_id, 
                 pizzeria_id 
            FROM person_visits
           WHERE visit_date BETWEEN '2022-01-07' AND '2022-01-09') AS pv 
    ORDER BY 1 ASC, 2 DESC
