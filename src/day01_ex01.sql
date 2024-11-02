 (SELECT NAME as object_name 
    from person
order by NAME)
UNION all
 (SELECT pizza_name as object_name 
    from menu
order by pizza_name)

