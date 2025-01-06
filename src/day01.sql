 (SELECT id AS objec_id, 
         NAME AS object_name 
    FROM person
)
UNION
 (SELECT id AS objec_id, 
         pizza_name AS object_name 
    FROM menu
)
ORDER BY 1, 2;

 (SELECT NAME AS object_name 
    FROM person
ORDER BY NAME)
UNION ALL
 (SELECT pizza_name AS object_name 
    FROM menu
ORDER BY pizza_name)

SELECT pizza_name AS object_name 
  FROM menu 
UNION 
SELECT pizza_name AS object_name 
  FROM menu 
