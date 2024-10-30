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