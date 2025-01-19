--EX 07
INSERT INTO menu (id, pizzeria_id, pizza_name, price)  VALUES (19, 2, 'greek pizza', 800)

--EX 08
INSERT INTO menu (id, pizzeria_id, pizza_name, price)  
VALUES ((SELECT MAX(id)+1 FROM menu),
        (SELECT id FROM pizzeria WHERE name = 'Dominos'), 
        'sicilian pizza', 
        900)

--EX 09
INSERT INTo person_visits (id, person_id, pizzeria_id, visit_date)
VALUES(
  (SELECT MAX(id)+1 FROM person_visits),
  (SELECT id FROM person WHERE name = 'Denis'),
  (SELECT id FROM pizzeria WHERE name = 'Dominos'),
  '2022-02-24'
  ),
  (
  (SELECT MAX(id)+2 FROM person_visits),
  (SELECT id FROM person WHERE name = 'Irina'),
  (SELECT id FROM pizzeria WHERE name = 'Dominos'),
  '2022-02-24'
  )

--EX 10

INSERT INTo person_order (id, person_id, menu_id, order_date)
VALUES(
  (SELECT MAX(id)+1 FROM person_order),
  (SELECT id FROM person WHERE name = 'Denis'),
  (SELECT id FROM menu WHERE pizza_name = 'sicilian pizza'),
  '2022-02-24'
  ),
  (
  (SELECT MAX(id)+2 FROM person_order),
  (SELECT id FROM person WHERE name = 'Irina'),
  (SELECT id FROM menu WHERE pizza_name = 'sicilian pizza'),
  '2022-02-24'
  )

   
