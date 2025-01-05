

INSERT INTO person_order ( ID, person_id, menu_id, order_date) 
SELECT (SELECT MAX(id) FROM person_order)+id,
       id,
       (SELECT id FROM menu WHERE pizza_name = 'greek pizza'),
       '2022-02-25' AS order_date 
   FROM person

