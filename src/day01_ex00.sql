 (SELECT id as objec_id, 
         NAME as object_name 
    from person
)
UNION
 (SELECT id as objec_id, 
         pizza_name as object_name 
    from menu
)
order by 1, 2