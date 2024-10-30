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
