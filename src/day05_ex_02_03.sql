-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
-- Exercise 02 - Formula is in the index. Is it Ok? (Формула в индексе. Все в порядке?)
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
--idx_person_name
CREATE INDEX if not EXISTS idx_person_name ON person (UPPER(name));

--DROP INDEX idx_person_name;

SET ENABLE_SEQSCAN TO OFF;

EXPLAIN ANALYZE 
SELECT * FROM person ORDER BY 1;

SET ENABLE_SEQSCAN TO ON;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
-- Exercise 03 - Multicolumn index for our goals (Индекс на основе нескольких столбцов наша цель)
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
--idx_person_order_multi
CREATE INDEX if not EXISTS idx_person_order_multi ON person_order (person_id, menu_id);

--DROP INDEX idx_person_order_multi;

SET ENABLE_SEQSCAN TO OFF;

EXPLAIN ANALYZE 
SELECT person_id, menu_id, order_date
FROM person_order
WHERE person_id = 8 AND menu_id = 19;

SET ENABLE_SEQSCAN TO ON;

