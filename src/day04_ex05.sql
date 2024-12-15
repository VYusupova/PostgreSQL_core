CREATE VIEW v_price_with_discount AS
SELECT person.name,
       menu.pizza_name, 
       menu.price, 
       ceil(price -price*0.1) AS discount_price 
FROM person_order
JOIN person ON person.id = person_id
JOIN menu   ON menu.id = menu_id
ORDER BY person.name, menu.pizza_name