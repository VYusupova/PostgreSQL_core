-- ___________________________________________________________________________________________________
-- | Exercise 00 - Discounts, discounts , everyone loves discounts (Скидки, скидки, все любят скидки)|
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

CREATE TABLE IF NOT EXISTS person_discounts
( id bigint primary key ,
  person_id bigint not null ,
  pizzeria_id bigint not null ,
  discounts numeric default 0 not null ,
 constraint fk_person_discounts_person_id foreign key  (person_id) references person(id),
 constraint fk_person_discounts_pizzeria_id foreign key (pizzeria_id) references pizzeria(id),
 constraint ch_discounts check ( discounts  between 1 AND 25)
  );

-- ______________________________________________
-- |  Exercise 01 - Let’s set personal discounts |
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -
INSERT INTO person_discounts 
    SELECT ROW_NUMBER( ) OVER ( ) AS id, 
           po.person_id, 
           menu.pizzeria_id, 
           CASE WHEN ( Count(*) = 1) 
                 THEN 10.5
                 ELSE  CASE WHEN ( Count(*) = 2)
                       THEN 22
                       ELSE 30
                       END
            END AS discount
          
    FROM person_order po
    JOIN menu ON menu.id = po.menu_id
    GROUP BY po.person_id, menu.pizzeria_id 
    ORDER BY po.person_id, menu.pizzeria_id 

-- _______________________________________________________
-- |  Exercise 02 - Let’s recalculate a history of orders |
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
SELECT  
       person.name,
       menu.pizza_name,
       menu.price,
       menu.price - CEIL(menu.price * pd.discounts / 100) AS discount_price,
       pizzeria.name
  from person_order
  JOIN person ON person.id = person_order.person_id
  JOIN menu  ON menu_id = menu.id
  JOIN pizzeria ON pizzeria.id = menu.pizzeria_id
  JOIN person_discounts pd on menu.pizzeria_id = pd.pizzeria_id AND person.id = pd.person_id
ORDER BY 1, 2
