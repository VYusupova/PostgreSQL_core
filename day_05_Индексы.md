# Day 05 - Индексы в PostgreSQL 
теория https://tproger.ru/articles/indeksy-v-postgresql
## _I improved my SQL Query! Please, provide proof!_
> Я улучшил свои SQL выражения! Пожалуйста предоставь доказательсва

> Сегодня вы увидите как и когда создавать инндексы в базе данных

<details>
<summary> Exercise 00 -  создадим индексы для каждого внешнего ключа </summary>

>Создать простой индекс BTree для каждого внешнего ключа в нашей базе данных. Шаблон имени должен удовлетворять следующему правилу «idx_{table_name}_{column_name}». Например, индекс имени BTree для столбца pizzeria_id в таблице меню — idx_menu_pizzeria_id.
```sql
CREATE INDEX IF NOT EXISTS idx_menu_pizzeria_id ON menu(pizzeria_id);
CREATE INDEX IF NOT EXISTS idx_person_order_person_id ON person_order(person_id);
CREATE INDEX IF NOT EXISTS idx_person_order_menu_id ON person_order(menu_id);
CREATE INDEX IF NOT EXISTS idx_person_visits_person_id ON person_visits(person_id);
CREATE INDEX IF NOT EXISTS idx_person_visits_pizzeria_id ON person_visits(pizzeria_id);

--DROP INDEX IF EXISTS idx_menu_pizzeria_id;
```

</details>

<details>
<summary> Exercise 01 - Как убедиться, что индекс работает? </summary>


> Перед дальнейшими шагами, пожалуйста, напишите SQL-выражение, которое возвращает названия пицц и соответствующих пиццерий. Пожалуйста, взгляните на пример результата ниже (сортировка не требуется).

| pizza_name | pizzeria_name | 
| ------ | ------ |
| cheese pizza | Pizza Hut |
| ... | ... |

>Давайте предоставим доказательство того, что ваши индексы работают для вашего SQL.
Пример доказательства — вывод команды `EXPLAIN ANALYZE`.
Пожалуйста, посмотрите на пример вывода команды.

    ...
    ->  Index Scan using idx_menu_pizzeria_id on menu m  (...)
    ...

>**Подсказка**: подумайте, почему ваши индексы не работают напрямую и что нам нужно сделать, чтобы это включить?

```sql
SET ENABLE_SEQSCAN TO OFF;

EXPLAIN ANALYZE
SELECT menu.pizza_name AS pizza_name,
      pizzeria.name AS pizzeria_name
FROM menu
JOIN pizzeria  ON pizzeria_id = pizzeria.id
order by 1, 2 DESC
;

SET ENABLE_SEQSCAN TO ON;
```

</details>


<details>
<summary> Exercise 02 - Формула в индексе. Все в порядке? </summary>

> Создайте функциональный индекс B-Tree с именем `idx_person_name` для столбца `name` таблицы `person`. Индекс должен содержать имена людей в верхнем регистре.

> Пожалуйста, напишите и предоставьте любой SQL-код с доказательством (`EXPLAIN ANALYZE`) того, что индекс idx_person_name работает.

```sql
--idx_person_name
CREATE INDEX if not EXISTS idx_person_name ON person (UPPER(name));

--DROP INDEX idx_person_name;

SET ENABLE_SEQSCAN TO OFF;

EXPLAIN ANALYZE
SELECT UPPER(NAME) FROM person ORDER BY 1;

SET ENABLE_SEQSCAN TO ON;
```

</details>


<details>
<summary> Exercise 03 - Индекс на основе нескольких столбцов наша цель </summary>

>Создайте лучший многостолбцовый индекс B-Tree с именем `idx_person_order_multi` для приведенного ниже оператора SQL.
```sql
    SELECT person_id, menu_id,order_date
    FROM person_order
    WHERE person_id = 8 AND menu_id = 19;
```


> Команда `EXPLAIN ANALYZE` должна вернуть следующий шаблон. Будьте внимательны при сканировании "Index Only Scan"!

    Index Only Scan using idx_person_order_multi on person_order ...

> предоставьте любой SQL-код с доказательством (`EXPLAIN ANALYZE`) того, что индекс `idx_person_order_multi` работает.

```sql
--idx_person_order_multi
CREATE INDEX if not EXISTS idx_person_order_multi ON person_order (person_id, menu_id); -- добавить надо бы в чек листе это есть order_date

SET ENABLE_SEQSCAN TO OFF;

EXPLAIN ANALYZE 
SELECT person_id, menu_id, order_date
FROM person_order
WHERE person_id = 8 AND menu_id = 19;

SET ENABLE_SEQSCAN TO ON;
```

</details>

<details>
<summary> Ex04 - уникальность данных </summary>

> Создайте уникальный индекс BTree с именем `idx_menu_unique` в таблице `menu` для столбцов `pizzeria_id` и `pizza_name`.
> напишите и предоставьте любой SQL с доказательством (`EXPLAIN ANALYZE`) того, что индекс `idx_menu_unique` работает.
```sql
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
```

</details>

<details>
<summary> Ex05 - Частичная уникальность данных </summary>

> Создайте частичный уникальный индекс BTree с именем `idx_person_order_order_date` в таблице `person_order` для атрибутов `person_id` и `menu_id` с частичной уникальностью для столбца `order_date` для даты `2022-01-01’.
> Команда `EXPLAIN ANALYZE` должна возвращать следующий шаблон

    Index Only Scan using idx_person_order_order_date on person_order …

```sql
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

```

</details>

<details>
<summary> Ex06 - Давайте улучшим производительность  </summary>


> Взгляните на SQL ниже с технической точки зрения (игнорируйте логическую сторону этого оператора SQL).
```sql
    SELECT
        m.pizza_name AS pizza_name,
        max(rating) OVER (PARTITION BY rating ORDER BY rating ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS k
    FROM  menu m
    INNER JOIN pizzeria pz ON m.pizzeria_id = pz.id
    ORDER BY 1,2;
```
> Создайте новый индекс BTree с именем `idx_1`, который должен улучшить метрику «Время выполнения» этого SQL. Пожалуйста, предоставьте доказательство (`EXPLAIN ANALYZE`), что SQL был улучшен.

**Hint**:
> Это упражнение выглядит как задача «грубой силы» для поиска хорошего покрывающего индекса, поэтому перед новым тестом удалите индекс `idx_1`.

Sample of my improvement:

**Before**:

    Sort  (cost=26.08..26.13 rows=19 width=53) (actual time=0.247..0.254 rows=19 loops=1)
    "  Sort Key: m.pizza_name, (max(pz.rating) OVER (?))"
    Sort Method: quicksort  Memory: 26kB
    ->  WindowAgg  (cost=25.30..25.68 rows=19 width=53) (actual time=0.110..0.182 rows=19 loops=1)
            ->  Sort  (cost=25.30..25.35 rows=19 width=21) (actual time=0.088..0.096 rows=19 loops=1)
                Sort Key: pz.rating
                Sort Method: quicksort  Memory: 26kB
                ->  Merge Join  (cost=0.27..24.90 rows=19 width=21) (actual time=0.026..0.060 rows=19 loops=1)
                        Merge Cond: (m.pizzeria_id = pz.id)
                        ->  Index Only Scan using idx_menu_unique on menu m  (cost=0.14..12.42 rows=19 width=22) (actual time=0.013..0.029 rows=19 loops=1)
                            Heap Fetches: 19
                        ->  Index Scan using pizzeria_pkey on pizzeria pz  (cost=0.13..12.22 rows=6 width=15) (actual time=0.005..0.008 rows=6 loops=1)
    Planning Time: 0.711 ms
    Execution Time: 0.338 ms

**After**:

    Sort  (cost=26.28..26.33 rows=19 width=53) (actual time=0.144..0.148 rows=19 loops=1)
    "  Sort Key: m.pizza_name, (max(pz.rating) OVER (?))"
    Sort Method: quicksort  Memory: 26kB
    ->  WindowAgg  (cost=0.27..25.88 rows=19 width=53) (actual time=0.049..0.107 rows=19 loops=1)
            ->  Nested Loop  (cost=0.27..25.54 rows=19 width=21) (actual time=0.022..0.058 rows=19 loops=1)
                ->  Index Scan using idx_1 on …
                ->  Index Only Scan using idx_menu_unique on menu m  (cost=0.14..2.19 rows=3 width=22) (actual time=0.004..0.005 rows=3 loops=6)
    …
    Planning Time: 0.338 ms
    Execution Time: 0.203 ms


```sql
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
```
</details>

