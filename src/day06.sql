-- ___________________________________________________________________________________________________
-- | Exercise 00 - Discounts, discounts , everyone loves discounts (Скидки, скидки, все любят скидки)|
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

CREATE TABLE IF NOT EXISTS person_discounts
( id bigint primary key ,
  person_id bigint not null ,
  pizzeria_id bigint not null ,
  discount numeric default 0 not null ,
 constraint fk_person_discounts_person_id foreign key  (person_id) references person(id),
 constraint fk_person_discounts_pizzeria_id foreign key (pizzeria_id) references pizzeria(id),
 constraint ch_discounts check ( discount  between 1 AND 50)
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
       menu.price - CEIL(menu.price * pd.discount / 100) AS discount_price,
       pizzeria.name
  from person_order
  JOIN person ON person.id = person_order.person_id
  JOIN menu  ON menu_id = menu.id
  JOIN pizzeria ON pizzeria.id = menu.pizzeria_id
  JOIN person_discounts pd on menu.pizzeria_id = pd.pizzeria_id AND person.id = pd.person_id
ORDER BY 1, 2

-- _________________________________________
-- | Exercise 03 - Improvements are in a way  |
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -
CREATE UNIQUE INDEX IF NOT EXISTS idx_person_discounts_unique ON person_discounts (person_id, pizzeria_id);
--DROP INDEX  idx_person_discounts_unique

SET ENABLE_SEQSCAN TO OFF;
EXPLAIN ANALYSE

SELECT person_id, pizzeria_id FROM person_discounts ORDER BY 1;

SET ENABLE_SEQSCAN TO ON;
-- _______________________________________________
-- |Exercise 04 - We need more Data Consistency  |
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

alter table person_discounts add constraint ch_nn_person_id CHECK (person_id is NOT NULL) ;
alter table person_discounts add constraint ch_nn_pizzeria_id CHECK (pizzeria_id is NOT NULL) ;
alter table person_discounts add constraint ch_nn_discount CHECK (discount is NOT NULL) ;
alter table person_discounts ALTER COLUMN  discount SET DEFAULT 0;
alter table person_discounts add constraint ch_range_discount  check ( discount  between 0 AND 100);

-- _______________________________________________
-- |         Exercise 05 - Data Governance Rules |
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
COMMENT ON TABLE person_discounts IS 'размер скидки клиента в пиццерии зависит от количетва сделанных заказов в пиццерии';
COMMENT ON COLUMN person_discounts.id IS 'уникальный идентификатор скидки';
COMMENT ON COLUMN person_discounts.person_id IS 'идентификатор клиента для которого есть скидка';
COMMENT ON COLUMN person_discounts.pizzeria_id IS 'идентификатор пиццерии в которой у клиента скидка';
COMMENT ON COLUMN person_discounts.discount IS 'размер скидки клиента';


--что бы проверить что добавилось это срипт для себя
SELECT obj_description(oid), relname
FROM  pg_class WHERE   obj_description(oid) is not null;

SELECT * FROM information_schema.tables where table_name like '%c%';


-- _____________________________________________________
-- | Exercise 06: Let’s automate Primary Key generation |
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
CREATE SEQUENCE IF NOT EXISTS
      seq_person_discounts AS INT
 OWNED BY
      person_discounts.id;

SELECT
      SETVAL('seq_person_discounts', MAX(id))
FROM  person_discounts;

INSERT INTO
      person_discounts (person_id, pizzeria_id, discount)
VALUES
      (2, 5, 22);

SELECT * FROM person_discounts;


