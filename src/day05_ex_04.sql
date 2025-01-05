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
      
