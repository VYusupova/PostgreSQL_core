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
