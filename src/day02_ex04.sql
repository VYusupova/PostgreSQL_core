WITH pizza (pizzeria_id, pizza_name, price) AS (
SELECT pizzeria_id, pizza_name, price from menu where pizza_name in ('mushroom pizza', 'pepperoni pizza')
 )
 
 SELECT pizza_name, NAME as pizzeria_name, price from pizza
 JOIN pizzeria ON id = pizzeria_id
 ORDER BY 1,2