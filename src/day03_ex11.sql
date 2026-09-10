-- Упражнение 11 ----------------------------------------------------------------

UPDATE menu set price = price*(1-0.10) WHERE pizza_name = 'greek pizza'


-- Упражнение 12 ----------------------------------------------------------------
  
INSERT INTO person_order ( ID, person_id, menu_id, order_date) 
SELECT (SELECT MAX(id) FROM person_order)+id,
       id,
       (SELECT id FROM menu WHERE pizza_name = 'greek pizza'),
       '2022-02-25' AS order_date 
   FROM person
;

-- Упражнение 13 ----------------------------------------------------------------
-- -- написать 2 DML запроса которые удаляют все новые заказы из упражнения 12, возвращая таблицу к базовому виду. Удалите “greek pizza” из меню
  
DELETE FROM  person_order
       WHERE menu_id = (SELECT id FROM menu WHERE pizza_name = 'greek pizza')
         and order_date = '2022-02-25' ;
 
DELETE FROM menu WHERE pizza_name = 'greek pizza' ;
