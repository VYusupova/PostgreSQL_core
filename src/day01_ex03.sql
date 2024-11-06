SELECT order_date as action_date, person_id from person_order 
INTERSECT
select visit_date as action_date, person_id from person_visits
order by 1 ASC, 2 DESC