# Day 06 - Piscine SQL

## _Let's improve customer experience_

Resume: Today you will see how to add a new business feature into our data model

<details>
<summary> Exercise 00 - Discounts, discounts , everyone loves discounts (Скидки, скидки, все любят скидки)</summary>

| Exercise 00: Discounts, discounts , everyone loves discounts |                                                                                                                          |
|---------------------------------------|--------------------------------------------------------------------------------------------------------------------------|
| Turn-in directory                     | ex00                                                                                                                     |
| Files to turn-in                      | `day06_ex00.sql`                                                                                 |
| **Allowed**                               |                                                                                                                          |
| Language                        | SQL, DML, DDL                                                                                              |

Let’s expand our data model to involve a new business feature.
Every person wants to see a personal discount and every business wants to be closer for clients.
> Давайте расширим нашу модель данных, включив в нее новую бизнес-функцию.
> Каждый человек хочет видеть персональную скидку, и каждый бизнес хочет быть ближе к клиентам.

Please think about personal discounts for people from one side and pizzeria restaurants from other. Need to create a new relational table (please set a name `person_discounts`) with the next rules.
>Пожалуйста, подумайте о персональных скидках для людей с одной стороны и пиццерий с другой. Необходимо создать новую реляционную таблицу (задайте имя `person_discounts`) со следующими правилами.

- set id attribute like a Primary Key (please take a look on id column in existing tables and choose the same data type)
  > - установите атрибут id как первичный ключ (пожалуйста, посмотрите на столбец id в существующих таблицах и выберите тот же тип данных)
- set for attributes person_id and pizzeria_id foreign keys for corresponding tables (data types should be the same like for id columns in corresponding parent tables)
  > - задать для атрибутов person_id и pizzeria_id внешние ключи для соответствующих таблиц (типы данных должны быть такими же, как для столбцов id в соответствующих родительских таблицах)
- please set explicit names for foreign keys constraints by pattern fk_{table_name}_{column_name},  for example `fk_person_discounts_person_id`
  > - пожалуйста, задайте явные имена для ограничений внешних ключей по шаблону fk_{table_name}_{column_name}, например `fk_person_discounts_person_id`
- add a discount attribute to store a value of discount in percent. Remember, discount value can be a number with floats (please just use `numeric` data type). So, please choose the corresponding data type to cover this possibility.
  > - добавьте атрибут скидки для хранения значения скидки в процентах. Помните, что значение скидки может быть числом с плавающей точкой (пожалуйста, просто используйте тип данных `numeric`). Поэтому, пожалуйста, выберите соответствующий тип данных, чтобы охватить эту возможность.

</details>

<details>
<summary> Exercise 01 - Let’s set personal discounts </summary>

    

| Exercise 01: Let’s set personal discounts|                                                                                                                          |
|---------------------------------------|--------------------------------------------------------------------------------------------------------------------------|
| Turn-in directory                     | ex01                                                                                                                     |
| Files to turn-in                      | `day06_ex01.sql`                                                                                 |
| **Allowed**                               |                                                                                                                          |
| Language                        | SQL, DML, DDL                                                                                              |

Actually, we created a structure to store our discounts and we are ready to go further and fill our `person_discounts` table with new records.
> На самом деле мы создали структуру для хранения наших скидок и готовы пойти дальше и заполнить нашу таблицу `person_discounts` новыми записями.

So, there is a table `person_order` that stores the history of a person's orders. Please write a DML statement (`INSERT INTO ... SELECT ...`) that makes  inserts new records into `person_discounts` table based on the next rules.
> Итак, есть таблица `person_order`, в которой хранится история заказов человека. Пожалуйста, напишите оператор DML (`INSERT INTO ... SELECT ...`), который вставляет новые записи в таблицу `person_discounts` на основе следующих правил.
- take aggregated state by person_id and pizzeria_id columns
  > - взять агрегированное состояние по столбцам person_id и pizzeria_id
- calculate personal discount value by the next pseudo code:
  > - рассчитать персональную скидку по следующему псевдокоду:


    ```
    if “amount of orders” = 1 then  
        “discount” = 10.5   
    else if “amount of orders” = 2 then   
        “discount” = 22  
    else   
        “discount” = 30
    ```  


- to generate a primary key for the person_discounts table please use  SQL construction below (this construction is from the WINDOW FUNCTION  SQL area).
   >Чтобы сгенерировать первичный ключ для таблицы person_discounts, используйте конструкцию SQL, представленную ниже (эта конструкция взята из раздела SQL WINDOW FUNCTION). 
    
    `... ROW_NUMBER( ) OVER ( ) AS id ...`




</details>

<details>
<summary> Exercise 02 - Let’s recalculate a history of orders </summary>


| Exercise 02: Let’s recalculate a history of orders|                                                                                                                          |
|---------------------------------------|--------------------------------------------------------------------------------------------------------------------------|
| Turn-in directory                     | ex02                                                                                                                     |
| Files to turn-in                      | `day06_ex02.sql`                                                                                 |
| **Allowed**                               |                                                                                                                          |
| Language                        | SQL, DML, DDL                                                                                              |

Please write a SQL statement that returns orders with actual price and price with applied discount for each person in the corresponding pizzeria restaurant and sort by person name, and pizza name. Please take a look at the sample of data below.

| name | pizza_name | price | discount_price | pizzeria_name | 
| ------ | ------ | ------ | ------ | ------ |
| Andrey | cheese pizza | 800 | 624 | Dominos |
| Andrey | mushroom pizza | 1100 | 858 | Dominos |
| ... | ... | ... | ... | ... |

</details>

<details>
<summary> Exercise 03 - Improvements are in a way </summary>


| Exercise 03: Improvements are in a way |                                                                                                                          |
|---------------------------------------|--------------------------------------------------------------------------------------------------------------------------|
| Turn-in directory                     | ex03                                                                                                                     |
| Files to turn-in                      | `day06_ex03.sql`                                                                                 |
| **Allowed**                               |                                                                                                                          |
| Language                        | SQL, DML, DDL                                                                                              |


Actually, we have to make improvements to data consistency from one side and performance tuning from the other side. Please create a multicolumn unique index (with name `idx_person_discounts_unique`) that prevents duplicates of pair values person and pizzeria identifiers.

> На самом деле, нам нужно улучшить согласованность данных с одной стороны и производительность с другой. Создайте уникальный индекс с несколькими столбцами (с именем idx_person_discounts_unique), который предотвращает дубликаты парных значений идентификаторов персон и пиццерий.
> 
After creation of a new index, please provide any simple SQL statement that shows proof of index usage (by using `EXPLAIN ANALYZE`).
The example of “proof” is below

>После создания нового индекса предоставьте любой простой оператор SQL, который показывает доказательство использования индекса (с помощью EXPLAIN ANALYZE). Пример «доказательства» приведен ниже.
    ...
    Index Scan using idx_person_discounts_unique on person_discounts
    ...


</details>

<details>
<summary> Exercise 04 - We need more Data Consistency </summary>


| Exercise 04: We need more Data Consistency |                                                                                                                          |
|---------------------------------------|--------------------------------------------------------------------------------------------------------------------------|
| Turn-in directory                     | ex04                                                                                                                     |
| Files to turn-in                      | `day06_ex04.sql`                                                                                 |
| **Allowed**                               |                                                                                                                          |
| Language                        | SQL, DML, DDL                                                                                              |

Please add the following constraint rules for existing columns of the `person_discounts` table.
- person_id column should not be NULL (use constraint name `ch_nn_person_id`)
- pizzeria_id column should not be NULL (use constraint name `ch_nn_pizzeria_id`)
- discount column should not be NULL (use constraint name `ch_nn_discount`)
- discount column should be 0 percent by default
- discount column should be in a range values from 0 to 100 (use constraint name `ch_range_discount`)

</details>

<details>
<summary> Exercise 05 - Data Governance Rules </summary>


| Exercise 05: Data Governance Rules|                                                                                                                          |
|---------------------------------------|--------------------------------------------------------------------------------------------------------------------------|
| Turn-in directory                     | ex05                                                                                                                     |
| Files to turn-in                      | `day06_ex05.sql`                                                                                 |
| **Allowed**                               |                                                                                                                          |
| Language                        |  SQL, DML, DDL                                                                                              |

To satisfy Data Governance Policies need to add comments for the table and table's columns. Let’s apply this policy for the `person_discounts` table. Please add English or Russian comments (it's up to you) that explain what is a business goal of a table and all included attributes. 

> Для соответствия политикам управления данными необходимо добавить комментарии для таблицы и столбцов таблицы. Давайте применим эту политику для таблицы `person_discounts`. Пожалуйста, добавьте комментарии на английском или русском языке (на ваше усмотрение), которые объясняют, какова бизнес-цель таблицы и все включенные атрибуты.

</details>

<details>
<summary> Exercise 06 - Let’s automate Primary Key generation </summary>


| Exercise 06: Let’s automate Primary Key generation|                                                                                                                          |
|---------------------------------------|--------------------------------------------------------------------------------------------------------------------------|
| Turn-in directory                     | ex06                                                                                                                     |
| Files to turn-in                      | `day06_ex06.sql`                                                                                 |
| **Allowed**                               |                                                                                                                          |
| Language                        | SQL, DML, DDL                                                                                              |
| **Denied**                               |                                                                                                                          |
| SQL Syntax Pattern                        | Don’t use hard-coded value for amount of rows to set a right value for sequence                                                                                              |
| SQL Syntax Pattern                        | > Не используйте жестко заданное значение количества строк, чтобы задать правильное значение последовательности.                                                                                             |

Let’s create a Database Sequence with the name `seq_person_discounts` (starting from 1 value) and set a default value for id attribute of `person_discounts` table to take a value from `seq_person_discounts` each time automatically. 
Please be aware that your next sequence number is 1, in this case please set an actual value for database sequence based on formula “amount of rows in person_discounts table” + 1. Otherwise you will get errors about Primary Key violation constraint.

> Давайте создадим последовательность базы данных с именем `seq_person_discounts` (начиная с 1 значения) и установим значение по умолчанию для атрибута id таблицы `person_discounts`, чтобы автоматически брать значение из `seq_person_discounts` каждый раз.
Обратите внимание, что ваш следующий номер последовательности равен 1, в этом случае, пожалуйста, установите фактическое значение для последовательности базы данных на основе формулы «количество строк в таблице person_discounts» + 1. В противном случае вы получите ошибки о нарушении ограничения первичного ключа.

</details>

[D06_Exercise 00, 01, 02, 03, 04, 05](src/day06.sql)
