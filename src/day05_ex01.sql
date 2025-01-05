SET ENABLE_SEQSCAN TO OFF;

EXPLAIN ANALYZE SELECT menu.pizza_name AS pizza_name,	
      pizzeria.name AS pizzeria_name 
  FROM menu
JOIN pizzeria  ON pizzeria_id = pizzeria.id
;
SET ENABLE_SEQSCAN TO ON;
