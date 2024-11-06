Select action_date, (SELECT name From person where id = person_id) as person_name From
(SELECT order_date as action_date, person_id from person_order 
INTERSECT
select visit_date as action_date, person_id from person_visits
)
Order by 1 ASC, 2 DESC