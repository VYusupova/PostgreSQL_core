# SQL Bootcamp 

<details>
<summary>  Preamble  </summary>

![D01_01](misc/images/D01_01.png)

Standards are everywhere, and Relational Databases are also under control as well :-). To be honest between us, more restricted SQL standards were at the beginning of 2000 years. Actually when the “Big Data” pattern was born, Relational Databases had their own way to realize this pattern and therefore standards are more... lightweight right now. 

![D01_02](misc/images/D01_02.png)

Please take a look at some SQL standards below and try to think about the future of Relational Databases.

|  |  |
| ------ | ------ |
| ![D01_03](misc/images/D01_03.png) | ![D01_04](misc/images/D01_04.png) |
| ![D01_05](misc/images/D01_05.png) | ![D01_06](misc/images/D01_06.png) |
| ![D01_07](misc/images/D01_07.png) | ![D01_08](misc/images/D01_08.png) |


</details>

<details>
<summary> General Rules </summary>

- Убедись что используешь последнюю версию PostgreSQL (Make sure you are using the latest version of PostgreSQL.)
- Use this page as the only reference. Do not listen to any rumors and speculations on how to prepare your solution.
- That is completely OK if you are using IDE to write a source code (aka SQL script).
- To be assessed your solution must be in your GIT repository.
- Your solutions will be evaluated by your piscine mates.
- You should not leave in your directory any other file than those explicitly specified by the exercise instructions. It is recommended that you modify your `.gitignore` to avoid accidents.
- Do you have a question? Ask your neighbor on the right. Otherwise, try with your neighbor on the left.
- Your reference manual: mates / Internet / Google. 
- Read the examples carefully. They may require things that are not otherwise specified in the subject.
- And may the SQL-Force be with you!
- Absolutely everything can be presented in SQL! Let’s start and have fun!


</details>

</details>


<details>
<summary>## Rules of the day</summary> 




![schema](misc/images/schema.png)

</details>

<details>
<summary> Rules of the day </summary>

 Please make sure you have an own(собственный) database and access to it on your PostgreSQL cluster.
- Please download a [script](model.sql) with Database Model here and apply the script to your database (you can use command line with psql or just run it through any IDE, for example DataGrip from JetBrains or pgAdmin from PostgreSQL community). 
- All tasks contain a list of Allowed and Denied sections with listed database options, database types, SQL constructions etc. Please have a look at the section before you start.
- посмотрите логическое представление модели базы данных ниже 

![schema](misc/images/schema.png)


1. **pizzeria** table (Dictionary Table with available pizzerias)
- field **id** — primary key 
- field **name** — название пиццерии  
- field **rating** — average(средний) рейтинг пицерии (от 0 до 5)
2. **person** table (Dictionary Table with persons who loves pizza)
- field **id** — primary key
- field **name** — Имя  
- field **age** — возраст  
- field **gender** — пол  
- field **address** — адресс  
3. **menu** table (Dictionary Table with available menu and price for concrete pizza)
- field id — primary key
- field pizzeria_id — foreign key to pizzeria
- field pizza_name — name of pizza in pizzeria
- field price — price of concrete pizza
4. **person_visits** table (Operational Table with information about visits of pizzeria)
- field id — primary key
- field person_id — foreign key to person
- field pizzeria_id — foreign key to pizzeria
- field visit_date — date (for example 2022-01-01) of person visit 
5. **person_order** table (Operational Table with information about persons orders)
- field id — primary key
- field person_id — foreign key to person
- field menu_id — foreign key to menu
- field order_date — date (for example 2022-01-01) of person order 

People's visit(посещения) and people's order(заказы) are different entities and don't contain any correlation between data. 
>в заданиях клиенты могут быть в одном ресторане (только посмотреть меню) и в это время делать заказ в другом по телефону или из мобильного приложения.
Or another case,  just be at home and again make a call with order without any visits.
</details>

<details>
	
<summary> day 00 - базовые конструкции SQL.  </summary>

[] Упражение 00:  Создать выбоку через `SELECT` в которой будет имена и возраст всех кто живет в городе Казань.  
[]  Упражение 01: Через оператор `SELECT`  который должен вернуть names, ages всех женщин из города ‘Kazan’. Результат должен быть **отсортирован** по имени.  
[] Упражение 02:
Please make 2 syntax different `SELECT` запроса которые вернет список из таблицы `pizzeria` (pizzeria name and rating) с рейтингом от 3.5 до 5 (включительно) и **отсортировать результат** по рейтингу.
- the 1st `SELECT` должен бытть основан на неравенствах  (<=, >=);
- the 2nd `SELECT` с ключевым словом `BETWEEN`.  

[] Упражение 03: 
Please make a `SELECT` запрос который возвращает the person identifiers (без дублей) тех кто посетил пиццерию в период с 6 января 2022 по 9 января 2022 (включительно) или посетил пиццерию с индетификатором 2. Also включите сортировку clause by person identifier in **descending** mode(по убыванию).  

[] Упражение 04: 
Please make a `SELECT` запрос который вернет одно вычисленное поле которые называется   ‘person_information’ in one string like described (описываемый) in the next sample:

`Anna (age:16,gender:'female',address:'Moscow')`

Finally, please add the ordering clause by calculated column in **ascending** mode.
Please pay attention to the **quotation** marks in your formula! (обратите внимание на то что в формуле должны быть кавычки)  

[]  Управжнение 05: 
Напиши селект запрос который вернет имена людей () которые сделали заказ из меню с идентификаторами 13, 14 и 18, дата заказа должна быть 7 января 2022 года. 
Write a `SELECT` statement that returns the names of people (based on an internal query in the ``SELECT`` clause) who placed orders for the menu with identifiers 13, 14, and 18, and the date of the orders should be January 7, 2022. Be careful with "Denied Section"(запрещенный раздел) before your work.

Please take a look at the pattern of internal query.

    `SELECT` 
	    (`SELECT` ... ) AS NAME  -- this is an internal query in a main `SELECT` clause
    FROM ...
    WHERE ...
    

| Упражение 06: 
Используя SQL-конструкцию из упражениия 05 и добавь новый вычисляемый столбец (назови его ‘check_name’) проверяющий запрос в пвсевдокоде в предложении ``SELECT``   
Use the SQL construction from Exercise 05 and add a new calculated column (use column name ‘check_name’) with a check statement a pseudocode for this check is given below(ниже)) in the ``SELECT`` clause(предложении).

    if (person_name == 'Denis') then return true
        else return false

| Управжнение 07: 
Let's apply data intervals to the `person` table.  
((*apply*)применение интервалов к таблице `person`  )
Please make an SQL statement that returns the identifiers of a person, the person's names, and the interval of the person's ages (set a name of a new calculated column as 'interval_info') based on the pseudo code below(базовый псевдокод представлен ниже).



    if (age >= 10 and age <= 20) then return 'interval #1'
    else if (age > 20 and age < 24) then return 'interval #2'
    else return 'interval #3'

And yes... please sort a result by ‘interval_info’ column in ascending mode.
И да... пожалуйтса отсортируй результат по столбцу ‘interval_info’ по возрастанию

| Упражение 08: 
Create an SQL statement that returns all columns from the `person_order` table with rows whose identifier is an even number. The result must be ordered by the returned identifier.  

Создать запрос который вернет все столбцы из таблицы `person_order` в чьих строках identifier это четное число.  Рузультат должен быть отсортирован по возрвращаемуму идентификатору

| Exercise 09:

Please make a `SELECT` statement that returns person names and pizzeria names based on the `person_visits` table with a visit date in a period from January 07 to January 09, 2022 (including all days) (based on an internal(внутренний) query in the `FROM' clause (предложении)).

Пожалуйста сделайте `SELECT` запрос который вернет имена и названия пиццерий из таблицы `person_visits` где дата визита была в период с 7 января по 9 января 2022(включая эти дни) (основной  внутренний запрос в предложении `FROM')

Please take a look at the pattern of the final query.

```
    `SELECT` (...) AS person_name ,  -- this is an internal query in a main `SELECT` clause
            (...) AS pizzeria_name  -- this is an internal query in a main `SELECT` clause
    FROM (`SELECT` … FROM person_visits WHERE …) AS pv -- this is an internal query in a main FROM clause
    ORDER BY ...
```

Please add a **ordering** clause by person name in ascending mode and by pizzeria name in descending mode.

</details>

[D00_ex00](src/day00.sql)

<details>
	
<summary> day 01 - UNION  </summary>

<details>
<summary> Введение </summary> 

![D01_01](misc/images/D01_01.png)

In many aspects, sets are used in Relational Databases. Not just, make UNION or find MINUS between sets. Sets are also good candidates to make recursive queries.  
>(Во многих аспектах, множества используются в реляционных базах данных. Не только для объединения или поиска отрицательных значений между множествами. Множества также хороши для выполнения рекурсивных запросов)

There are the next set operators in PostgreSQL. 
- UNION [ALL]
- EXCEPT [ALL] 
- INTERSECT [ALL]
 
> ключевое слово “ALL” выведет в результат строки с дублями  
основные правила для работы с множествами :
- The main SQL provides a final names of attributes for whole query
> 
- The attributes of controlled SQL should satisfied number of columns and corresponding family types of main SQL

![D01_02](misc/images/D01_02.png)

Moreover, SQL sets are useful  to calculate some specific Data Science metrics, for example Jaccard distance between 2 objects based on existing data features.

</details>




<details>
<summary>Exercise 00: Let’s make UNION dance  </summary> 
  
| Exercise 00: Let’s make UNION dance |                                                                                                                          |
|---------------------------------------|--------------------------------------------------------------------------------------------------------------------------|
| Turn-in directory                     | ex00                                                                                                                     |
| Files to turn-in                      | `day01_ex00.sql`                                                                                 |
| **Allowed**                               |                                                                                                                          |
| Language                        | ANSI SQL                                                                                              |


(Напишите SQL запрос который вернет id меню и название пицы из таблицы `menu` и id человека и его имя из таблицы `person` в одном списке вывода (с названием столбцов как показано ниже) отсортируйте сначала по object_id а затем по object_name

| object_id | object_name |
| ------ | ------ |
| 1 | Anna |
| 1 | cheese pizza |
| ... | ... |

</details>

<details>
<summary> Exercise 01: UNION dance with subquery</summary> 

| Exercise 01: UNION dance with subquery|                                                                                                                          |
|---------------------------------------|--------------------------------------------------------------------------------------------------------------------------|
| Turn-in directory                     | ex01                                                                                                                     |
| Files to turn-in                      | `day01_ex01.sql`                                                                                 |
| **Allowed**                               |                                                                                                                          |
| Language                        | ANSI SQL                                                                                              |

Please modify a SQL statement from “exercise 00” by removing the object_id column. Then change ordering by object_name for part of data from the `person` table and then from `menu` table (like presented on a sample below). Please save duplicates!  

(Измените SQL запрос из прошлого упражнения уберите столбец object_id. Затем измените сортировку по object_name сначало сортируйте значения из таблицы  `person` и затем только из таблицы `menu`(как поаказано ниже). Записи могут дублироваться!

| object_name |
| ------ |
| Andrey |
| Anna |
| ... |
| cheese pizza |
| cheese pizza |
| ... |



</details>

<details>
<summary> Exercise 02: Duplicates or not duplicates</summary> 

| Exercise 02: Duplicates or not duplicates|                                                                                                                          |
|---------------------------------------|--------------------------------------------------------------------------------------------------------------------------|
| Turn-in directory                     | ex02                                                                                                                     |
| Files to turn-in                      | `day01_ex02.sql`                                                                                 |
| **Allowed**                               |                                                                                                                          |
| Language                        | ANSI SQL                                                                                              |
| **Denied**                               |                                                                                                                          |
| SQL Syntax Construction                        | `DISTINCT`, `GROUP BY`, `HAVING`, any type of `JOINs`                                                                                              |

Please write a SQL statement which returns unique pizza names from the `menu` table and orders by pizza_name column in descending mode. Please pay attention to the Denied section.  

(напишите SQL запрос который возвращает только уникальные названия пицц из таблицы `menu` и сортирует по названию пицц в убывающем порядке. обратите внимание некоторые конструкции запрещены )

</details>

<details>
<summary> Exercise 03 - “Hidden” Insights</summary> 


| Exercise 03: “Hidden” Insights |                                                                                                                          |
|---------------------------------------|--------------------------------------------------------------------------------------------------------------------------|
| Turn-in directory                     | ex03                                                                                                                     |
| Files to turn-in                      | `day01_ex03.sql`                                                                                 |
| **Allowed**                               |                                                                                                                          |
| Language                        | ANSI SQL                                                                                              |
| **Denied**                               |                                                                                                                          |
| SQL Syntax Construction                        |  any type of `JOINs`                                                                                              |

Please write a SQL statement which returns common rows for attributes order_date, person_id from `person_order` table from one side and visit_date, person_id from `person_visits` table from the other side (please see a sample below). In other words, let’s find identifiers of persons, who visited and ordered some pizza on the same day. Actually, please add ordering by action_date in ascending mode and then by person_id in descending mode.  
который возвращает строки из атрибутов даты заказа, персон_ид из таблицы `person_order` с одной стороны и дата визита из `person_visits` таблицы из сдругой стороны (пожалуйста смотрите пример ниже). в других словах, давай найдем идентификаторы людей, кто посещал и заказывал 

| action_date | person_id |
| ------ | ------ |
| 2022-01-01 | 6 |
| 2022-01-01 | 2 |
| 2022-01-01 | 1 |
| 2022-01-03 | 7 |
| 2022-01-04 | 3 |
| ... | ... |

</details>

<details>
<summary> Exercise 04: Difference? Yep, let's find the difference between multisets.</summary> 


| Exercise 04: Difference? Yep, let's find the difference between multisets. |                                                                                                                          |
|---------------------------------------|--------------------------------------------------------------------------------------------------------------------------|
| Turn-in directory                     | ex04                                                                                                                     |
| Files to turn-in                      | `day01_ex04.sql`                                                                                 |
| **Allowed**                               |                                                                                                                          |
| Language                        | ANSI SQL                                                                                              |
| **Denied**                               |                                                                                                                          |
| SQL Syntax Construction                        |  any type of `JOINs`                                                                                              |

Please write a SQL statement which returns a difference (minus) of person_id column values with saving duplicates between `person_order` table and `person_visits` table for order_date and visit_date are for 7th of January of 2022  
> вернуть разницу значения столбца  person_id с дублями  между  `person_order` и  `person_visits` таблицами дата заказа и дата визита 7  января 2022  

</details>

<details>
<summary>Exercise 05 - Did you hear about Cartesian Product? (Вы слышали о Декартовом произведении)</summary> 


| Exercise 05: Декартово произведение |                                                                                                                          |
|---------------------------------------|--------------------------------------------------------------------------------------------------------------------------|
| Turn-in directory                     | ex05                                                                                                                     |
| Files to turn-in                      | `day01_ex05.sql`                                                                                 |
| **Allowed**                               |                                                                                                                          |
| Language                        | ANSI SQL                                                                                              |

Please write a SQL statement which returns all possible combinations between `person` and `pizzeria` tables and please set ordering by person identifier and then by pizzeria identifier columns. Please take a look at the result sample below. Please be aware column's names can be different for you.  
> вернуть все возможные комбинации между таблицами `person` и `pizzeria` и отсортируйте по идентификатору персоны и затем по идентификатору пиццерии. посмотрите на пример результата ниже. Ознакомьтесь с названиями столбцов 

| person.id | person.name | age | gender | address | pizzeria.id | pizzeria.name | rating |
| ------ | ------ | ------ | ------ | ------ | ------ | ------ | ------ |
| 1 | Anna | 16 | female | Moscow | 1 | Pizza Hut | 4.6 |
| 1 | Anna | 16 | female | Moscow | 2 | Dominos | 4.3 |
| ... | ... | ... | ... | ... | ... | ... | ... |


</details>

<details>
<summary> Exercise 06 - Lets see on “Hidden” Insights</summary> 

| Exercise 06: Lets see on “Hidden” Insights |                                                                                                                          |
|---------------------------------------|--------------------------------------------------------------------------------------------------------------------------|
| Turn-in directory                     | ex06                                                                                                                     |
| Files to turn-in                      | `day01_ex06.sql`                                                                                 |
| **Allowed**                               |                                                                                                                          |
| Language                        | ANSI SQL                                                                                              |

Let's return our mind back to exercise #03 and change our SQL statement to return person names instead(вместо) of person identifiers and change ordering by action_date in ascending(возрастающем) mode and then by person_name in descending mode. Please take a look at a data sample below.

> Давай вернемся к нашему решению из упражнения #03 и изменим запрос так что бы он возвращал имена вместо идентификаторов персон и изменим сортирувоку по action_date в возрастающем порядке а затем по именам в убывающем порядке. посмотри на данные из примера ниже.  


| action_date | person_name |
| ------ | ------ |
| 2022-01-01 | Irina |
| 2022-01-01 | Anna |
| 2022-01-01 | Andrey |
| ... | ... |



</details>


| Exercise 08: Migrate JOIN to NATURAL JOIN |                                                                                                                          |
|---------------------------------------|--------------------------------------------------------------------------------------------------------------------------|
| Описание                   | NATURAL JOIN (естественное соединение) — это тип соединения в SQL, который автоматически объединяет таблицы на основе столбцов с одинаковыми именами и совместимыми типами данных                                                                                                                  |
| Как работает                    | Идентифицирует все столбцы, которые есть в обеих таблицах и имеют одинаковые имена и типы данных Для каждой такой пары выполняет проверку на равенство значений. В результирующей таблице каждый из этих общих столбцов появляется только один раз (дубликаты имён устраняются).                                                                                 |
| Опасность 1                               |   Неявность — это риск. Главная опасность NATURAL JOIN в том, что он сопоставляет столбцы только по имени, а не по смыслу (например, если в обеих таблицах есть столбец id, это не значит, что их нужно объединять                                                                                                                       |
| Опасность 2                        |Изменение схемы ломает запрос. Если позже в одну из таблиц добавят новый столбец с именем, которое уже есть в другой таблице, NATURAL JOIN начнёт соединять и этот новый столбец, даже если он не имеет отношения к задаче                                                                                          |
| Опасность 3                        |Не все СУБД поддерживают. Например, SQL Server не поддерживает синтаксис NATURAL JOIN                                                                                              |
| Когда использовать                             |   Я рекомендую прибегать к NATURAL JOIN только в очень специфических, хорошо продуманных сценариях, когда вы абсолютно уверены, что столбцы с одинаковыми именами действительно логически связаны (например, это первичные и внешние ключи в чётко спроектированной схеме)                                                                                                                       |
| SQL Syntax Construction                        |                                                                                        |
 ```sql
      SELECT order_date,
              person_information 
         FROM person_order
 NATURAL JOIN (SELECT id AS person_id,
                      CONCAT(person.NAME, ' (age:', person.age, ')') AS  person_information 
                 FROM person)
 ORDER BY 1,2
```  




[D01_задания](src/day01.sql)

</details>

<details>
	
<summary> day 02 -Глубокое погружение в JOIN.  </summary>

![D02_01](misc/images/D02_01.png)

In the picture, you can see a Relational Expression in Tree View. This expression corresponds the next SQL query 

    SELECT *
        FROM R CROSS JOIN S
    WHERE clause

So, in other words we can describe any SQL in mathematical terms of Relational Algebra.

The main question (which I hear from my students) is why do we need to learn Relational Algebra in a course, if we can write a SQL in a first attempt? My answer is yes and no in one time. “Yes” means you can write a SQL from the first attempt, that’s right , “No” means you have to know the main aspects of Relational Algebra, because this knowledge is in use for optimization plans and for semantic queries. 
Which type of joins are existing in Relational Algebra?
Actually, “Cross Join” is a primitive operator and it is an ancestor for other types of joins.
- Natural Join
- Theta Join
- Semi Join
- Anti Join
- Left / Right / Full Joins 

But what does a join operation between 2 tables mean? Let me present a part of pseudo code, how join operation works without indexing. 

    FOR r in R LOOP
        FOR s in S LOOP
        if r.id = s.r_id then add(r,s)
        …
        END;
    END;

It’s just a set of loops ... Not magic at all

</details>



<details>
<summary> Exercise 00 - Move to the LEFT, move to the RIGHT </summary>  

| Exercise 00 |       необходимо вернуть список названий пиццерий с рейтингом которые никто не посещал                                                                                                                  |
|---------------------------------------|--------------------------------------------------------------------------------------------------------------------------|
| | [Нельзя использовать `NOT IN`, `IN`, `NOT EXISTS`, `EXISTS`, `UNION`, `EXCEPT`, `INTERSECT`] |



| Exercise 01: Find data gaps|                                                                                                                          |
|---------------------------------------|--------------------------------------------------------------------------------------------------------------------------|
| Turn-in directory                     | ex01                                                                                                                     |
| Files to turn-in                      | `day02_ex01.sql`                                                                                 |
| **Allowed**                               |                                                                                                                          |
| Language                        | ANSI SQL                                                                                              |
| SQL Syntax Construction                        | `generate_series(...)`                                                                                              |
| **Denied**                               |                                                                                                                          |
| SQL Syntax Construction                        | `NOT IN`, `IN`, `NOT EXISTS`, `EXISTS`, `UNION`, `EXCEPT`, `INTERSECT`                                                                                              |

Please write a SQL statement which returns the missing days from 1st to 10th of January 2022 (including all days) for visits  of persons with identifiers 1 or 2 (it means days missed by both). Please order by visiting days in ascending mode. The sample of data with column name is presented below.  
> вернуть потерянные даты с 1 по 10  января 2022 (включительно) посещений с идентификатором 1 или 2 (это значит дней дней утеряно оба) отсортируйте дни посещений по возрастанию. Пример с названием поля ниже.

| missing_date |
| ------ |
| 2022-01-03 |
| 2022-01-04 |
| 2022-01-05 |
| ... |





| Exercise 02: FULL means ‘completely filled’|                                                                                                                          |
|---------------------------------------|--------------------------------------------------------------------------------------------------------------------------|
| Turn-in directory                     | ex02                                                                                                                     |
| Files to turn-in                      | `day02_ex02.sql`                                                                                 |
| **Allowed**                               |                                                                                                                          |
| Language                        | ANSI SQL                                                                                              |
| **Denied**                               |                                                                                                                          |
| SQL Syntax Construction                        | `NOT IN`, `IN`, `NOT EXISTS`, `EXISTS`, `UNION`, `EXCEPT`, `INTERSECT`                                                                                              |

Please write a SQL statement that returns a whole list of person names visited (or not visited) pizzerias during(в течении) the period from 1st to 3rd of January 2022 from one side and the whole list of pizzeria names which have been visited (or not visited) from the other side. The data sample with needed column names is presented below. Please pay attention to (рьпатите внимание на) the substitution value ‘-’ for `NULL` values in `person_name` and `pizzeria_name` columns. Please also add ordering for all 3 columns.  
> вернуть весь список имен посетителей( или не посетителей) пиццерий за период с 1 по 3 января 2022 с одной стороны и весь список названий пиццерий который имеет и не имет посетителй с другой стороны. Пример с нужными названими колонок представлен ниже. Обратите внимание на замену ‘-’ for `NULL` значений в столбцах.

| person_name | visit_date | pizzeria_name |
| ------ | ------ | ------ |
| - | null | DinoPizza |
| - | null | DoDo Pizza |
| Andrey | 2022-01-01 | Dominos |
| Andrey | 2022-01-02 | Pizza Hut |
| Anna | 2022-01-01 | Pizza Hut |
| Denis | null | - |
| Dmitriy | null | - |
| ... | ... | ... |



| Exercise 03: Reformat to CTE |                                                                                                                          |
|---------------------------------------|--------------------------------------------------------------------------------------------------------------------------|
| Turn-in directory                     | ex03                                                                                                                     |
| Files to turn-in                      | `day02_ex03.sql`                                                                                 |
| **Allowed**                               |                                                                                                                          |
| Language                        | ANSI SQL                                                                                              |
| SQL Syntax Construction                        | `generate_series(...)`                                                                                              |
| **Denied**                               |                                                                                                                          |
| SQL Syntax Construction                        | `NOT IN`, `IN`, `NOT EXISTS`, `EXISTS`, `UNION`, `EXCEPT`, `INTERSECT`                                                                                              |

Let’s return back to Exercise #01, please rewrite your SQL by using the CTE (Common Table Expression) pattern. Please move into the CTE part of your "day generator". The result should be similar like in Exercise #01  
> вернемся к упраженению 1 перепешите ваш SQL с использованием СТЕ паттерна. перемести в часть СТЕ ваш "генератор дней". Вывод должен быть таким же как в упражнениии 1

| missing_date | 
| ------ | 
| 2022-01-03 | 
| 2022-01-04 | 
| 2022-01-05 | 
| ... |






| Exercise 04: Find favourite pizzas |                                                                                                                          |
|---------------------------------------|--------------------------------------------------------------------------------------------------------------------------|
| Turn-in directory                     | ex04                                                                                                                     |
| Files to turn-in                      | `day02_ex04.sql`                                                                                 |
| **Allowed**                               |                                                                                                                          |
| Language                        | ANSI SQL                                                                                              |

Find full information about all possible pizzeria names and prices to get mushroom or pepperoni pizzas. Please sort the result by pizza name and pizzeria name then. The result of sample data is below (please use the same column names in your SQL statement).

| pizza_name | pizzeria_name | price |
| ------ | ------ | ------ |
| mushroom pizza | Dominos | 1100 |
| mushroom pizza | Papa Johns | 950 |
| pepperoni pizza | Best Pizza | 800 |
| ... | ... | ... |




| Exercise 05: Investigate Person Data |                                                                                                                          |
|---------------------------------------|--------------------------------------------------------------------------------------------------------------------------|
| Turn-in directory                     | ex05                                                                                                                     |
| Files to turn-in                      | `day02_ex05.sql`                                                                                 |
| **Allowed**                               |                                                                                                                          |
| Language                        | ANSI SQL                                                                                              |

Find names of all female persons older than 25 and order the result by name. The sample of output is presented below.

| name | 
| ------ | 
| Elvira | 
| ... |






| Exercise 06: favourite pizzas for Denis and Anna |                                                                                                                          |
|---------------------------------------|--------------------------------------------------------------------------------------------------------------------------|
| Turn-in directory                     | ex06                                                                                                                     |
| Files to turn-in                      | `day02_ex06.sql`                                                                                 |
| **Allowed**                               |                                                                                                                          |
| Language                        | ANSI SQL                                                                                              |

Please find all pizza names (and corresponding pizzeria names using `menu` table) that Denis or Anna ordered. Sort a result by both columns. The sample of output is presented below.

| pizza_name | pizzeria_name |
| ------ | ------ |
| cheese pizza | Best Pizza |
| cheese pizza | Pizza Hut |
| ... | ... |





| Exercise 07: Cheapest pizzeria for Dmitriy |                                                                                                                          |
|---------------------------------------|--------------------------------------------------------------------------------------------------------------------------|
| Turn-in directory                     | ex07                                                                                                                     |
| Files to turn-in                      | `day02_ex07.sql`                                                                                 |
| **Allowed**                               |                                                                                                                          |
| Language                        | ANSI SQL                                                                                              |

Please find the name of pizzeria Dmitriy visited on January 8, 2022 and could eat pizza for less than 800 rubles.






| Exercise 08: Continuing to research data |                                                                                                                          |
|---------------------------------------|--------------------------------------------------------------------------------------------------------------------------|
| Turn-in directory                     | ex08                                                                                                                     |
| Files to turn-in                      | `day02_ex08.sql`                                                                                 |
| **Allowed**                               |                                                                                                                          |
| Language                        | ANSI SQL                                                                                              |           


Please find the names of all males from Moscow or Samara cities who orders either pepperoni or mushroom pizzas (or both) . Please order the result by person name in descending mode. The sample of output is presented below.

| name | 
| ------ | 
| Dmitriy | 
| ... |






| Exercise 09: Who loves cheese and pepperoni? |                                                                                                                          |
|---------------------------------------|--------------------------------------------------------------------------------------------------------------------------|
| Turn-in directory                     | ex09                                                                                                                     |
| Files to turn-in                      | `day02_ex09.sql`                                                                                 |
| **Allowed**                               |                                                                                                                          |
| Language                        | ANSI SQL                                                                                              |

Please find the names of all females who ordered both pepperoni and cheese pizzas (at any time and in any pizzerias). Make sure that the result is ordered by person name. The sample of data is presented below.

| name | 
| ------ | 
| Anna | 
| ... |





| Exercise 10: Find persons from one city |                                                                                                                          |
|---------------------------------------|--------------------------------------------------------------------------------------------------------------------------|
| Turn-in directory                     | ex10                                                                                                                     |
| Files to turn-in                      | `day02_ex10.sql`                                                                                 |
| **Allowed**                               |                                                                                                                          |
| Language                        | ANSI SQL                                                                                              |

Please find the names of persons who live on the same address. Make sure that the result is ordered by 1st person, 2nd person's name and common address. The  data sample is presented below. Please make sure your column names are corresponding column names below.
> Найти все людей, которые живут по одному адресу. Результат должен быть отсортирован по имени первого человека, затем по имени второго человека  и затем по адресу. Пример ниже , названия столбцов должны быть такиме же как ниже в примере

| person_name1 | person_name2 | common_address | 
| ------ | ------ | ------ |
| Andrey | Anna | Moscow |
| Denis | Kate | Kazan |
| Elvira | Denis | Kazan |
| ... | ... | ... |

</details>

[D02_Exercise](src/day02.sql)
