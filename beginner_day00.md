# Day 00 — SQL Bootcamp

## _Relational Data Model and SQL_

Resume: Today you will see how relational model works and how to get needed data based базовые конструкции SQL.

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

- Use this page as your only reference. Do not listen to rumors and speculations about how to prepare your solution.
- Убедись что используешь последнюю версию PostgreSQL (Make sure you are using the latest version of PostgreSQL.)
- Будет просто прекрасно если для написания SQL-скриптов ты будешь испльзовать ИДЕ (It is perfectly fine if you use the IDE to write source code (aka SQL script).)
- To be evaluated, your solution must be in your GIT repository.
- Your solutions will be evaluated by your peers.
- You should not leave any files in your directory other than those explicitly specified by the exercise instructions. It is recommended that you modify your `.gitignore' to avoid accidents.
- Got a question? Ask your neighbor to the right. Otherwise, try your neighbor on the left.
- Your reference manual: mates / Internet / Google. 
- Read the examples carefully. You may need things not specified in the topic.
- And may the SQL-Force be with you!
- Absolutely anything can be represented in SQL!Давай начнем и повеселимся (Let's get started and have fun!)

</details>

<details>
<summary> Rules of the day </summary>


 Please make sure you have your own database and access to it on your PostgreSQL cluster.
- Please download a [script](materials/model.sql) with Database Model here and apply the script to your database (you can use command line with psql or just run it through any IDE, for example DataGrip from JetBrains or pgAdmin from PostgreSQL community). 
- All tasks contain a list of Allowed and Denied sections with listed database options, database types, SQL constructions etc. Please have a look at the section before you start.
- Please have a look at the Logical View of our Database Model. 

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

People's visit(посещения) and people's order(заказы) are different entities and don't contain any correlation between data. For example, a customer can be in a restaurant (just looking at the menu) and at the same time place an order in another restaurant by phone or mobile application. Or another case, just be at home and again make a call with order without any visits.

</details>

<details>
<summary> Exercise(Упражение) 00 — Первые шаги в мире SQL  </summary>



| Упражение 00: First steps into SQL world |                                                                                                                          |
|---------------------------------------|--------------------------------------------------------------------------------------------------------------------------|
| Turn-in directory                     | ex00                                                                                                                     |
| Files to turn-in                      | `day00_ex00.sql`                                                                                 |
| **Allowed**                               |                                                                                                                          |
| Language                        | ANSI SQL                                                                                              |

Давай выполним наше первое задание. Создать выбоку через select в которой будет имена и возраст всех кто живет в городе Казань.
Please make a select statement which returns all person's names and person's ages from the city ‘Kazan’.  


</details>

<details>
<summary> Exercise 01 — Первые шаги в мире SQL   </summary> 


| Упражение 01: First steps into SQL world |                                                                                                                          |
|---------------------------------------|--------------------------------------------------------------------------------------------------------------------------|
| Turn-in directory                     | ex01                                                                                                                     |
| Files to turn-in                      | `day00_ex01.sql`                                                                                 |
| **Allowed**                               |                                                                                                                          |
| Language                        | ANSI SQL                                                                                              |

Через оператор select  который должен вернуть names, ages всех женщин из города ‘Kazan’. Результат должен быть **отсортирован** по имени.  
(statement - оператор, заявление)  


</details>

<details>
<summary>  Exercise 02 — Первые шаги в мире SQL     </summary> 


| Упражение 02: Первые шаги в мире SQL |                                                                                                                          |
|---------------------------------------|--------------------------------------------------------------------------------------------------------------------------|
| Turn-in directory                     | ex02                                                                                                                     |
| Files to turn-in                      | `day00_ex02.sql`                                                                                 |
| **Allowed**                               |                                                                                                                          |
| Language                        | ANSI SQL                                                                                              |

Please make 2 syntax different select запроса которые вернет список из таблицы `pizzeria` (pizzeria name and rating) с рейтингом от 3.5 до 5 (включительно) и **отсортировать результат** по рейтингу.
- the 1st select должен бытть основан на неравенствах  (<=, >=);
- the 2nd select с ключевым словом `BETWEEN`.  


</details>

<details>
<summary>  Exercise 03 — Первые шаги в мире SQL      </summary> 


| Упражение 03: Первые шаги в мире SQL |                                                                                                                          |
|---------------------------------------|--------------------------------------------------------------------------------------------------------------------------|
| Turn-in directory                     | ex03                                                                                                                     |
| Files to turn-in                      | `day00_ex03.sql`                                                                                 |
| **Allowed**                               |                                                                                                                          |
| Language                        | ANSI SQL                                                                                              |

Please make a select запрос который возвращает the person identifiers (без дублей) тех кто посетил пиццерию в период с 6 января 2022 по 9 января 2022 (включительно) или посетил пиццерию с индетификатором 2. Also включите сортировку clause by person identifier in **descending** mode(по убыванию).  


</details>

<details>
<summary>  Exercise 04 — Первые шаги в мире SQL     </summary> 


| Упражение 04: Первые шаги в мире SQL |                                                                                                                          |
|---------------------------------------|--------------------------------------------------------------------------------------------------------------------------|
| Turn-in directory                     | ex04                                                                                                                     |
| Files to turn-in                      | `day00_ex04.sql`                                                                                 |
| **Allowed**                               |                                                                                                                          |
| Language                        | ANSI SQL                                                                                              |

Please make a select запрос который вернет одно вычисленное поле которые называется   ‘person_information’ in one string like described (описываемый) in the next sample:

`Anna (age:16,gender:'female',address:'Moscow')`

Finally, please add the ordering clause by calculated column in **ascending** mode.
Please pay attention to the **quotation** marks in your formula! (обратите внимание на то что в формуле должны быть кавычки)  


</details>

<details>
<summary> Exercise 05 — Первые шаги в мире SQL       </summary> 


| Управжнение 05: Первые шаги в мире SQL |                                                                                                                          |
|---------------------------------------|--------------------------------------------------------------------------------------------------------------------------|
| Turn-in directory                     | ex05                                                                                                                     |
| Files to turn-in                      | `day00_ex05.sql`                                                                                 |
| **Allowed**                               |                                                                                                                          |
| Language                        | ANSI SQL                                                                                              |
| **Denied**   (запрещено использовать)                            |                                           
| SQL Syntax Construction                        | `IN`, any types of `JOINs`                                                                                              |

Напиши селект запрос который вернет имена людей () которые сделали заказ из меню с идентификаторами 13, 14 и 18, дата заказа должна быть 7 января 2022 года. 
Write a select statement that returns the names of people (based on an internal query in the `SELECT` clause) who placed orders for the menu with identifiers 13, 14, and 18, and the date of the orders should be January 7, 2022. Be careful with "Denied Section"(запрещенный раздел) before your work.

Please take a look at the pattern of internal query.

    SELECT 
	    (SELECT ... ) AS NAME  -- this is an internal query in a main SELECT clause
    FROM ...
    WHERE ...
    


</details>

<details>
<summary> Exercise 06 — Первые шаги в мире SQL      </summary> 



| Упражение 06:  |       First steps into SQL world                                                                                                                   |
|---------------------------------------|--------------------------------------------------------------------------------------------------------------------------|
| Turn-in directory                     | ex06                                                                                                                     |
| Files to turn-in                      | `day00_ex06.sql`                                                                                 |
| **Allowed**                               |                                                                                                                          |
| Language                        | ANSI SQL                                                                                              |
| **Denied**       (не используй)                        |                                           
| SQL Syntax Construction                        | `IN`, any types of `JOINs`                                                                                              |

Используя SQL-конструкцию из упражениия 05 и добавь новый вычисляемый столбец (назови его ‘check_name’) проверяющий запрос в пвсевдокоде в предложении `SELECT`   
Use the SQL construction from Exercise 05 and add a new calculated column (use column name ‘check_name’) with a check statement a pseudocode for this check is given below(ниже)) in the `SELECT` clause(предложении).

    if (person_name == 'Denis') then return true
        else return false


</details>

<details>
<summary>  Exercise 07 — Первые шаги в мире SQL    </summary> 



| Упражение 07: First steps into SQL world |                                                                                                                          |
|---------------------------------------|--------------------------------------------------------------------------------------------------------------------------|
| Turn-in directory                     | ex07                                                                                                                     |
| Files to turn-in                      | `day00_ex07.sql`                                                                                 |
| **Allowed**                               |                                                                                                                          |
| Language                        | ANSI SQL                                                                                              |

Let's apply data intervals to the `person` table.  
((*apply*)применение интервалов к таблице `person`  )
Please make an SQL statement that returns the identifiers of a person, the person's names, and the interval of the person's ages (set a name of a new calculated column as 'interval_info') based on the pseudo code below(базовый псевдокод представлен ниже).



    if (age >= 10 and age <= 20) then return 'interval #1'
    else if (age > 20 and age < 24) then return 'interval #2'
    else return 'interval #3'

And yes... please sort a result by ‘interval_info’ column in ascending mode.
И да... пожалуйтса отсортируй результат по столбцу ‘interval_info’ по возрастанию


</details>

<details>
<summary> Упражение 08: Первые шаги в мире SQL   </summary> 

| Упражение 08: Первые шаги в мире SQL |                                                                                                                          |
|---------------------------------------|--------------------------------------------------------------------------------------------------------------------------|
| Turn-in directory                     | ex08                                                                                                                     |
| Files to turn-in                      | `day00_ex08.sql`                                                                                 |
| **Allowed**                               |                                                                                                                          |
| Language                        | ANSI SQL                                                                                              |

Create an SQL statement that returns all columns from the `person_order` table with rows whose identifier is an even number. The result must be ordered by the returned identifier.  

Создать запрос который вернет все столбцы из таблицы `person_order` в чьих строках identifier это четное число.  Рузультат должен быть отсортирован по возрвращаемуму идентификатору


</details>

<details>
<summary> Упражение 09: Первые шаги в мире SQL   </summary> 

| Exercise 09: First steps into SQL world |                                                                                                                          |
|---------------------------------------|--------------------------------------------------------------------------------------------------------------------------|
| Turn-in directory                     | ex09                                                                                                                     |
| Files to turn-in                      | `day00_ex09.sql`                                                                                 |
| **Allowed**                               |                                                                                                                          |
| Language                        | ANSI SQL                                                                                              |
| **Denied**                               |                                           
| SQL Syntax Construction                        | any types of `JOINs`                                                                                              |


Please make a select statement that returns person names and pizzeria names based on the `person_visits` table with a visit date in a period from January 07 to January 09, 2022 (including all days) (based on an internal(внутренний) query in the `FROM' clause (предложении)).

Пожалуйста сделайте select запрос который вернет имена и названия пиццерий из таблицы `person_visits` где дата визита была в период с 7 января по 9 января 2022(включая эти дни) (основной  внутренний запрос в предложении `FROM')

Please take a look at the pattern of the final query.

```
    SELECT (...) AS person_name ,  -- this is an internal query in a main SELECT clause
            (...) AS pizzeria_name  -- this is an internal query in a main SELECT clause
    FROM (SELECT … FROM person_visits WHERE …) AS pv -- this is an internal query in a main FROM clause
    ORDER BY ...
```

Please add a **ordering** clause by person name in ascending mode and by pizzeria name in descending mode.

</details>

[D00_ex00](src/day00.sql)
