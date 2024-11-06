SELECT order_date as action_date, (Select name From person where id = person_id) as person_name from person_order 
INTERSECT
select visit_date as action_date, (Select name From person where id = person_id) as person_name from person_visits
order by 1 ASC, 2 DESC