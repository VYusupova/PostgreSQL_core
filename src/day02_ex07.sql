SELECT pizzeria.name 
  FROM person_order
  JOIN person        ON person_id = person.id AND person.name = 'Dmitriy'
  JOIN menu          ON person_order.menu_id = menu.id AND menu.price <= 800
  JOIN person_visits ON person.id = person_visits.person_id AND person_order.order_date =person_visits.visit_date
  JOIN pizzeria      ON person_visits.pizzeria_id = pizzeria.id
