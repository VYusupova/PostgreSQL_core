-- ex00 --Создайте 2 представления базы данных (с похожими атрибутами, как у исходной таблицы)
----------на основе простой фильтрации пола лиц. Задайте соответствующие имена для представлений базы данных: `v_persons_female` и `v_persons_male`.

CREATE VIEW v_persons_female AS 
SELECT id, 
       name, 
       age, 
       gender, 
       address 
  FROM person 
 WHERE gender = 'female'
;
CREATE VIEW v_persons_male AS 
SELECT *
  FROM person
 WHERE gender = 'male'

-- ex01 --Используя 2 представления данных из упражнения#00 напишите SQL-скрипт который вернет имена мужчин и женщин в одном списке. Отсортируйте список по именам. Вид вывдоа представлен ниже. 
SELECT name FROM v_persons_female
UNION ALL
SELECT name FROM v_persons_male

ORDER BY name

-- ex02 -- создайте представление (с именем `v_generated_dates`) которое должно сохранять сгенерированные данные с 1 по 31 января 2022 с типом DATE. 
       ---Не забудьте отсортировать сгенерированные данные по дате.
CREATE VIEW v_generated_dates AS 
(SELECT da.date AS generated_date 
  FROM generate_series('2022-01-01'::DATE,'2022-01-31', '1 day') as da
ORDER BY 1
)

-- ex03 -- Напишите SQL-скрипт который вернет пропущенные дни посещений в январе 2022. Используейте представление `v_generated_dates` для этой задачи и отсортируйте результат по пропущенной дате. Пример вывода представлен ниже 
SELECT generated_date AS missing_date FROM v_generated_dates
EXCEPT
SELECT DISTINCT visit_date FROM person_visits
ORDER BY 1

-- ex04 -- Напишите SQL-запрос который удовлетворяет формуле `(R - S)∪(S - R)`.
--Где R это `person_visits` с фильтром по 2 января 2022, S это также `person_visits` но с другим фильтром по 6 января 2022. Пожалуйста, сделайте ваше вычисление с множеством над `person_id` столбцом и этот столбец должен быть единственным в результате. Результат отсортируйте по `person_id` и ваш финальное SQL представлет в `v_symmetric_union`  (*) представлении
--(*) Честно говоря, определения «симметричное объединение» в теории множеств не существует. Это интерпретация автора, основная идея основана на существующем правиле симметричной разности.
CREATE VIEW v_symmetric_union AS
WITH
	R AS (SELECT * 
	        FROM person_visits
			WHERE visit_date = '2022-01-02'),
	S AS (SELECT * 
	        FROM person_visits
		 	WHERE visit_date = '2022-01-06'),
	R_diff_S AS (SELECT * FROM R
					EXCEPT 
				 SELECT * FROM S),
	S_diff_R AS (SELECT * FROM S
					EXCEPT 
				 SELECT * FROM R)
SELECT person_id FROM R_diff_S
UNION
SELECT person_id FROM S_DIFF_R
ORDER BY person_id;

select * from v_symmetric_union

--ex 05 оздайте представление  `v_price_with_discount` которое возвращает заказы с именем, названием пицы, ценой и вычисляемый столбик  `discount_price`(с применением 10% скидки и высчитвываемом по формуле   `price - price*0.1`). Результат, пожалуйста, отсортируйте по имени и названию пиццы и округлите `discount_price` до целого типа. Пожалуйтса, обратите внимание на пример ниже. 
CREATE VIEW v_price_with_discount AS
SELECT person.name,
       menu.pizza_name, 
       menu.price, 
       ceil(price -price*0.1) AS discount_price 
FROM person_order
JOIN person ON person.id = person_id
JOIN menu   ON menu.id = menu_id
ORDER BY person.name, menu.pizza_name

--ex06 Создайте материализованное представление `mv_dmitriy_visits_and_eats` (с включенными данными) на основе оператора SQL, который находит название пиццерии, которую Дмитрий посетил 8 января 2022 года и мог съесть пиццу менее чем за 800 рублей (этот SQL вы можете найти в упражнении № 02 дня № 07).
CREATE MATERIALIZED VIEW mv_dmitriy_visits_and_eats AS
SELECT DISTINCT pizzeria.name 
  FROM person_visits
  JOIN person   ON person.id = person_id
  JOIN pizzeria ON pizzeria.id = pizzeria_id
  JOIN menu     ON menu.pizzeria_id = pizzeria.id
 WHERE person.name = 'Dmitriy'
   AND visit_date = '2022-01-08'
   AND price < 800

--ex 07 Давайте обновим данные в нашем материализованном представлении `mv_dmitriy_visits_and_eats` из упражнения № 06. Перед этим действием, пожалуйста, сгенерируйте еще одно посещение Дмитрия, которое удовлетворяет предложению SQL материализованного представления, за исключением пиццерии, которую мы можем увидеть в результате из упражнения № 06.

INSERt INTO person_visits  (id, person_id, pizzeria_id, visit_date)
VALUES (
  (SELECT MAX(id)+1 FROM person_visits),
  (SELECT id FROM person WHERe name =  'Dmitriy'),
  (SELECT pizzeria.id FROM pizzeria 
   JOIN menu ON pizzeria_id = pizzeria.id
   WHERE name not in (SELECT name FROM  mv_dmitriy_visits_and_eats) 
   AND price < 800 
   LIMIT 1),
  '2022-01-08'
  )
  ;
  REFRESH MATERIALIZED VIEW   mv_dmitriy_visits_and_eats

--ex 08 After all our exercises were born a few Virtual Tables and one Materialized View. Let’s drop them!
DROP VIEW IF EXISTS v_persons_female;
DROP VIEW IF EXISTS v_persons_male;
DROP VIEW IF EXISTS v_price_with_discount;
DROP VIEW IF EXISTS v_symmetric_union;
DROP VIEW IF EXISTS v_generated_dates;
DROP MATERIALIZED VIEW IF EXISTS  mv_dmitriy_visits_and_eats;
