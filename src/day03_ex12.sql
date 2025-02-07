

INSERT INTO person_order ( ID, person_id, menu_id, order_date) 
SELECT (SELECT MAX(id) FROM person_order)+id,
       id,
       (SELECT id FROM menu WHERE pizza_name = 'greek pizza'),
       '2022-02-25' AS order_date 
   FROM person
;

-- Упражнение 13 ----------------------------------------------------------------

DELETE FROM  person_order
       WHERE menu_id =(SELECT id FROM menu WHERE pizza_name = 'greek pizza')
         and order_date = '2022-02-25' ж
 
DELETE FROM menu WHERE pizza_name = 'greek pizza'

