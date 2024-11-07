
Select name from pizzeria where id not in (SELECT pizzeria_id from person_visits)

Select name from pizzeria where not EXISTS (SELECT pizzeria_id from person_visits where pizzeria.id = pizzeria_id)