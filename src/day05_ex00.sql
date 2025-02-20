--«idx_{table_name}_{column_name}»
-- В БД уже есть индекс uk_person_visits

CREATE INDEX IF NOT EXISTS idx_menu_pizzeria_id ON menu(pizzeria_id);
CREATE INDEX IF NOT EXISTS idx_person_order_person_id ON person_order(person_id);
CREATE INDEX IF NOT EXISTS idx_person_order_menu_id ON person_order(menu_id);
CREATE INDEX IF NOT EXISTS idx_person_visits_person_id ON person_visits(person_id);
CREATE INDEX IF NOT EXISTS idx_person_visits_pizzeria_id ON person_visits(pizzeria_id);

--DROp INDEX IF EXISTS idx_menu_pizzeria_id;
--DROp INDEX IF EXISTS idx_person_order_person_id;
--DROp INDEX IF EXISTS idx_person_order_menu_id;
--DROp INDEX IF EXISTS idx_person_visits_person_id;
--DROp INDEX IF EXISTS idx_person_visits_pizzeria_id;

--DROP TABLE IF EXISTS menu CASCADE;
--DROP TABLE IF EXISTS person CASCADE;
--DROP TABLE IF EXISTS person_order ;
--DROP TABLE IF EXISTS person_visits  ;
--DROP TABLE IF EXISTS pizzeria  ;

-- Упражнение 01 — Как убедиться, что индекс работает? 

SET ENABLE_SEQSCAN TO OFF;

EXPLAIN ANALYZE
SELECT menu.pizza_name AS pizza_name,
      pizzeria.name AS pizzeria_name
FROM menu
JOIN pizzeria  ON pizzeria_id = pizzeria.id
order by 1, 2 DESC
;

SET ENABLE_SEQSCAN TO ON;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
-- Exercise 02 - Formula is in the index. Is it Ok? (Формула в индексе. Все в порядке?)
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
--idx_person_name
CREATE INDEX if not EXISTS idx_person_name ON person (UPPER(name));

--DROP INDEX idx_person_name;

SET ENABLE_SEQSCAN TO OFF;

EXPLAIN ANALYZE
SELECT UPPER(NAME) FROM person ORDER BY 1;

SET ENABLE_SEQSCAN TO ON;


-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
-- Exercise 03 - Multicolumn index for our goals (Индекс на основе нескольких столбцов наша цель)
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
--idx_person_order_multi
CREATE INDEX if not EXISTS idx_person_order_multi ON person_order (person_id, menu_id); -- добавить надо бы в чек листе это есть order_date

--DROP INDEX idx_person_order_multi;

SET ENABLE_SEQSCAN TO OFF;

EXPLAIN ANALYZE 
SELECT person_id, menu_id, order_date
FROM person_order
WHERE person_id = 8 AND menu_id = 19;

SET ENABLE_SEQSCAN TO ON;

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
