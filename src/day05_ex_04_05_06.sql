-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -
|  Exercise 04 - Uniqueness for data (уникальность данных)   |
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -
/* idx_menu_unique 
** UNIQUE гарантирует что в индексе будут записаны только уникальные значения
** Если в таблие все же есть повторения, то индекс при создании выдаст ошибку
** */
CREATE UNIQUE INDEX if not EXISTS idx_menu_unique  ON  menu (pizzeria_id, pizza_name);

--DROP INDEX idx_menu_unique;

SET ENABLE_SEQSCAN TO OFF;

EXPLAIN ANALYZE 
SELECT DISTINCT pizzeria_id, pizza_name
FROM menu;


SET ENABLE_SEQSCAN TO ON;

-- Так же после создания уникального индекса UNIQUE  вы не сможете 
-- добавить в таблицу повторяющиеся данные
-- для примера выражение ниже вызовет ошибку 
INSERT INTO
      menu (id, pizzeria_id, pizza_name, price)
VALUES
      (21, 4, 'mushroom pizza', 1000);
      
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
|  Exercise 05 - Partial uniqueness for data (Частичная уникальность данных)   |
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- ---- -- -- -- -- -- -- -- 

/* idx_person_order_order_date
 в таблице person_order для атрибутов person_id и menu_id 
 с частичной уникальностью для столбца order_date для даты `2022-01-
*/
CREATE UNIQUE INDEX if not EXISTS idx_person_order_order_date
	ON  person_order (person_id, menu_id)
    WHERE order_date = '2022-01-01';

--DROP INDEX idx_person_order_order_date;

SET ENABLE_SEQSCAN TO OFF;

EXPLAIN ANALYZE 
SELECT DISTINCT person_id, menu_id 
FROM person_order WHERE  order_date = '2022-01-01';


SET ENABLE_SEQSCAN TO ON;

-- Index Only Scan using idx_person_order_order_date on person_order …


      
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -
|  Exercise 06 -  (Давайте улучшим производительность)   |
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- ----  

CREATE  INDEX if not EXISTS idx_1  ON pizzeria (rating ASC) ;-- menu (pizza_name) ;-- pizzeria (rating) ;  (pizza_name, pizzeria_id) 
-- DROP INDEX  idx_1;

SET ENABLE_SEQSCAN TO OFF;

EXPLAIN ANALYZE 

SELECT
    m.pizza_name AS pizza_name,
    max(rating) OVER (PARTITION BY rating ORDER BY rating ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS k
FROM  menu m
INNER JOIN pizzeria pz ON m.pizzeria_id = pz.id
ORDER BY 1,2;

SET ENABLE_SEQSCAN TO ON;



