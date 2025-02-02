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
