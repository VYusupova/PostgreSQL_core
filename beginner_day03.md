# Day 03 - Piscine SQL

## _Continuing to JOIN and make change in data_

Resume: Today you will see how to change data based on DML language

<details>
<summary>Contents</summary>
1. [Chapter I](#chapter-i) \[Preamble](#preamble)
2. [Chapter II](#chapter-ii) \ [General Rules](#general-rules)
3. [Chapter III](#chapter-iii) \ [Rules of the day](#rules-of-the-day)  
4. [Chapter IV](#chapter-iv) [Exercise 00 - Let’s find appropriate prices for Kate](#exercise-00-lets-find-appropriate-prices-for-kate)  
[Exercise 01 - Let’s find forgotten menus](#exercise-01-lets-find-forgotten-menus)  
 [Exercise 02 - Let’s find forgotten pizza and pizzerias](#exercise-02-lets-find-forgotten-pizza-and-pizzerias)  
 [Exercise 03 - Let’s compare visits](#exercise-03-lets-compare-visits)  
[Exercise 04 - Let’s compare orders](#exercise-04-lets-compare-orders)
[Exercise 05 - Visited but did not make any order (*Посетили но не сделали ни один заказ*)](#exercise-05-visited-but-did-not-make-any-order)
[Exercise 06 - Find price-similarity pizzas](#exercise-06-find-price-similarity-pizzas)
[Exercise 07 - Let’s cook a new type of pizza](#exercise-07-lets-cook-a-new-type-of-pizza)
[Exercise 08 - Let’s cook a new type of pizza with more dynamics](#exercise-08-lets-cook-a-new-type-of-pizza-with-more-dynamics)
[Exercise 09 - New pizza means new visits](#exercise-09-new-pizza-means-new-visits)
[Exercise 10 - New visits means new orders](#exercise-10-new-visits-means-new-orders)
15. [Chapter XV](#chapter-xv) \ [Exercise 11 - “Improve” a price for clients](#exercise-11-improve-a-price-for-clients)    
16. [Chapter XVI](#chapter-xvi) \[Exercise 12 - New orders are coming!](#exercise-12-new-orders-are-coming)
17. [Chapter XVII](#chapter-xvii) \ [Exercise 13 - Money back to our customers](#exercise-13-money-back-to-our-customers)
  </details>
  


<details>
<summary> ## Chapter I Preamble</summary>
    
![D03_01](misc/images/D03_01.png)

Relation Theory is a mathematical foundation for modern(современный) Relational Databases. Every databases’ aspect has corresponding mathematical and logical justification(обоснование). Including INSERT / UPDATE / DELETE operators. (Dr. Edgar Frank Codd is on the picture).

> Реляционная теория это математическая основа для соверменных реляционной базы данных. Любой аспект базы данных имеет соответсвующую математичесое и логическое обоснование. Включая операторы вставки / обновления / удаления.  ( доктор Эдгар Франк Кодд на снимке) 

How the INSERT operator works from a mathematical point of view.

|  |  |
| ------ | ------ |
|`INSERT rel RELATION {TUPLE {A INTEGER(4),B INTEGER(4),C STRING ('Hello') }};` | You can use mathematical INSERT statements and integrate “tuple”(кортеж) construction to convert an incoming data to row. |
| From the other side, you can use explicit assignment(явное присвоение) with the UNION operator. | `rel:=rel UNION RELATION {TUPLE {A INTEGER(4), B INTEGER (7), C STRING ('Hello')}};` |

What’s about the DELETE statement?

|  |  |
| ------ | ------ |
|`DELETE rel WHERE A = 1;` | If you want to delete a row for A = 1, you can do it in a direct way. |
| ... or by using a new assignment without key A = 1 | `rel:=rel WHERE NOT (A = 1);` |

... and finally UPDATE statement. Also there are 2 cases.

|  |  |
| ------ | ------ |
|`UPDATE rel WHERE A = 1 {B:= 23*A, C:='String #4'};` | Update statement from mathematical point of view |
| New assignment for relation variable rel based on CTE and working with Sets | `rel:=WITH (rel WHERE A = 1) AS T1, (EXTEND T1 ADD (23*A AS NEW_B, 'String #4' AS NEW_C)) AS T2, T2 {ALL BUT B,C} AS T3, (T3 RENAME (NEW _B AS B, NEW _C AS C)) AS T4: (S MINUS T1) UNION T4;` |

The last case with UPDATE statement is really interesting, because in other words you add a new tuple and after that make a MINUS of the old row. The same behavior in physical implementation! Actually, `UPDATE = DELETE + INSERT` and there is a special term “Tombstone” status for a particular deleted/updated row.  Then if you have a lot of Tombstones then you have a bad TPS metric and you need to control your dead data!

![D03_02](misc/images/D03_02.png)

Let’s make a cheese of our data! :-)

  </details>
  


<details>
<summary> ## Chapter II General Rules</summary>

- Use this page as the only reference. Do not listen to any rumors and speculations on how to prepare your solution.
 > Используйте эту страницу как единственную ссылку. Не слушайте никаких слухов и домыслов о том, как подготовить свое решение.  
- Please make sure you are using the latest version of PostgreSQL.
- That is completely OK if you are using IDE to write a source code (aka SQL script).
- To be assessed your solution must be in your GIT repository.
  > Для оценки ваше решение должно находиться в вашем репозитории GIT.
- Your solutions will be evaluated(оценивается) by your piscine mates.
 >  Ваши решения будут оценены вашими товарищами по бассейну
- You should not leave in your directory any other file than those explicitly specified by the exercise instructions. It is recommended that you modify your `.gitignore` to avoid accidents.
- Do you have a question? Ask your neighbor on the right. Otherwise, try with your neighbor on the left.
- Your reference manual: mates / Internet / Google. 
- Read the examples carefully. They may require things that are not otherwise specified in the subject.
- And may the SQL-Force be with you!
- Absolutely everything can be presented in SQL! Let’s start and have fun!
  </details>
  
 

<details>
<summary> ## Chapter III Rules of the day</summary>

- Please make sure you have an own database and access for it on your PostgreSQL cluster. 
- Please download a [script](materials/model.sql) with Database Model here and apply the script to your database (you can use command line with psql or just run it through any IDE, for example DataGrip from JetBrains or pgAdmin from PostgreSQL community). 
- All tasks contain a list of Allowed and Denied sections with listed database options, database types, SQL constructions etc. Please have a look at the section before you start.
- Please take a look at the Logical View of our Database Model. 

![schema](misc/images/schema.png)


1. **pizzeria** table (Dictionary Table with available pizzerias)
- field id - primary key
- field name - name of pizzeria
- field rating - average rating of pizzeria (from 0 to 5 points)
2. **person** table (Dictionary Table with persons who loves pizza)
- field id - primary key
- field name - name of person
- field age - age of person
- field gender - gender of person
- field address - address of person
3. **menu** table (Dictionary Table with available menu and price for concrete pizza)
- field id - primary key
- field pizzeria_id - foreign key to pizzeria
- field pizza_name - name of pizza in pizzeria
- field price - price of concrete pizza
4. **person_visits** table (Operational Table with information about visits of pizzeria)
- field id - primary key
- field person_id - foreign key to person
- field pizzeria_id - foreign key to pizzeria
- field visit_date - date (for example 2022-01-01) of person visit 
5. **person_order** table (Operational Table with information about persons orders)
- field id - primary key
- field person_id - foreign key to person
- field menu_id - foreign key to menu
- field order_date - date (for example 2022-01-01) of person order 

Persons' visit and persons' order are different entities and don't contain any correlation between data. For example, a client can be in one restraunt (just looking at menu) and in this time make an order in different one by phone or by mobile application. Or another case,  just be at home and again make a call with order without any visits.
  </details>
  

<details>
<summary>Exercise 00 - Let’s find appropriate(Подходящий) prices for Kate</summary>


| Exercise 00: Let’s find appropriate prices for Kate |                                                                                                                          |
|---------------------------------------|--------------------------------------------------------------------------------------------------------------------------|
| Turn-in directory                     | ex00                                                                                                                     |
| Files to turn-in                      | `day03_ex00.sql`                                                                                 |
| **Allowed**                               |                                                                                                                          |
| Language                        | ANSI SQL                                                                                              |

Please write a SQL statement which returns a list of pizza names, pizza prices, pizzerias names and dates of visit for Kate and for prices in range from 800 to 1000 rubles. Please sort by pizza, price and pizzeria names. Take a look at the sample of data below.

> вернуть список наименование пиццы, цена, название пиццерии и в дату визита Кати и цена пиццы от 800 до 1000. Отсоритируйте по названию цены и названию пиццерии. Посмотрите на пример данных ниже
> В дни когда Катя посещала пиццерию, вывести список пицц, их цену и названия пиццерий с ценой от 800 до 1000. Результат должен быть отсортирован сначала по названию пиццы потом по цене и затем по названию пиццерий. Ниже представлен вывод

| pizza_name | price | pizzeria_name | visit_date |
| ------ | ------ | ------ | ------ |
| cheese pizza | 950 | DinoPizza | 2022-01-04 |
| pepperoni pizza | 800 | Best Pizza | 2022-01-03 |
| pepperoni pizza | 800 | DinoPizza | 2022-01-04 |
| ... | ... | ... | ... |

[D03_ex00](src/day03_ex00.sql)

  </details>


<details>
<summary>Exercise 01 - Let’s find forgotten(забытый) menus</summary>


| Exercise 01: Let’s find forgotten menus|                                                                                                                          |
|---------------------------------------|--------------------------------------------------------------------------------------------------------------------------|
| Turn-in directory                     | ex01                                                                                                                     |
| Files to turn-in                      | `day03_ex01.sql`                                                                                 |
| **Allowed**                               |                                                                                                                          |
| Language                        | ANSI SQL                                                                                              |
| **Denied**                               |                                                                                                                          |
| SQL Syntax Construction                        | any type of `JOINs`                                                                                              |

Please find all menu identifiers which are not ordered by anyone. The result should be sorted by identifiers. The sample of output data is presented below.

> найдите все идентификаторы в меню? которые никто не заказывал. Результат должен быть отсортирован. Простой вывод представлен ниже. 
 
| menu_id |
| ------ |
| 5 |
| 10 |
| ... |

[D03_ex01](src/day03_ex01.sql)
  </details>
  


<details>
<summary>Exercise 02 - Let’s find forgotten pizza and pizzerias</summary>


| Exercise 02: Let’s find forgotten pizza and pizzerias|                                                                                                                          |
|---------------------------------------|--------------------------------------------------------------------------------------------------------------------------|
| Turn-in directory                     | ex02                                                                                                                     |
| Files to turn-in                      | `day03_ex02.sql`                                                                                 |
| **Allowed**                               |                                                                                                                          |
| Language                        | ANSI SQL                                                                                              |

Please use SQL statement from Exercise #01 and show pizza names from pizzeria which are not ordered by anyone, including corresponding prices also. The result should be sorted by pizza name and price. The sample of output data is presented below.

> Используя запрос из упраженния 1 и покажите названия пицц из пиццерий которые никто никогда не заказывал, включая соответвующую цену. Результат должен быть отсортирован по названию пиццы и цене. Простой вывод данных представлен ниже.

| pizza_name | price | pizzeria_name |
| ------ | ------ | ------ |
| cheese pizza | 700 | Papa Johns |
| cheese pizza | 780 | DoDo Pizza |
| ... | ... | ... |

[D03_ex02](src/day03_ex02.sql)

</details>
  
<details>
<summary> Exercise 03 - Let’s compare(сравнивать) visits</summary>

| Exercise 03: Let’s compare visits |                                                                                                                          |
|---------------------------------------|--------------------------------------------------------------------------------------------------------------------------|
| Turn-in directory                     | ex03                                                                                                                     |
| Files to turn-in                      | `day03_ex03.sql`                                                                                 |
| **Allowed**                               |                                                                                                                          |
| Language                        | ANSI SQL                                                                                              |

Please find pizzerias that have been visited more often(часто) by women or by men. For any SQL operators with sets save duplicates (UNION ALL, EXCEPT ALL, INTERSECT ALL constructions). Please sort a result by the pizzeria name. The data sample is provided below.

> найти пиццерии которые часто посещали мужчины или женщины. для любого оператора множестово вывода должно сохранять дубликаты (UNION ALL, EXCEPT ALL, INTERSECT ALL constructions). Результат отсортируйте по назанию пиццерий. пример вывода : 

| pizzeria_name | 
| ------ | 
| Best Pizza | 
| Dominos |
| ... |

[D03_ex03](src/day03_ex03.sql)
  </details>
  

<details>
<summary>Exercise 04 - Let’s compare orders</summary>

| Exercise 04: Let’s compare orders |                                                                                                                          |
|---------------------------------------|--------------------------------------------------------------------------------------------------------------------------|
| Turn-in directory                     | ex04                                                                                                                     |
| Files to turn-in                      | `day03_ex04.sql`                                                                                 |
| **Allowed**                               |                                                                                                                          |
| Language                        | ANSI SQL                                                                                              |

Please find a union of pizzerias that have orders either from women or  from men. Other words, you should find a set of pizzerias names have been ordered by females only and make "UNION" operation with set of pizzerias names have been ordered by males only. Please be aware(осведомленный) with word “only” for both genders. For any SQL operators with sets don’t save duplicates (`UNION`, `EXCEPT`, `INTERSECT`).  Please sort a result by the pizzeria name. The data sample is provided below.

> найти пиццерий в которыйх были заказы как мужчин так и женщин. Другими словами, вам надо найти множество названий пиццерий в который заказывали только женщины и обеденить с множеством пиццерий где заказывали только мужчины. Пожалуйста убедитесь со словом "только" для обеих полов. Для любых операторова SQL в множестве не должно быть дублей  (`UNION`, `EXCEPT`, `INTERSECT`). Результат отсортируйте. Пример  вывода ниже :

| pizzeria_name | 
| ------ | 
| Papa Johns | 

[D03_ex04](src/day03_ex04.sql)
  </details>


<details>
<summary>Exercise 05 - Visited but did not make any order</summary>


| Exercise 05: Visited but did not make any order |                                                                                                                          |
|---------------------------------------|--------------------------------------------------------------------------------------------------------------------------|
| Turn-in directory                     | ex05                                                                                                                     |
| Files to turn-in                      | `day03_ex05.sql`                                                                                 |
| **Allowed**                               |                                                                                                                          |
| Language                        | ANSI SQL                                                                                              |

Please write a SQL statement which returns a list of pizzerias which Andrey visited but did not make any orders. Please order by the pizzeria name. The sample of data is provided below.

> Вернуть список пиццерй с визитом Андрея но в которых он не сделал заказ. Сортируйте по названию. пример вывода ниже :

| pizzeria_name | 
| ------ | 
| Pizza Hut | 


[D03_ex05](src/day03_ex05.sql)

  </details>


<details>
<summary>Exercise 06 - Find price-similarity pizzas</summary>


| Exercise 06: Find price-similarity pizzas |                                                                                                                          |
|---------------------------------------|--------------------------------------------------------------------------------------------------------------------------|
| Turn-in directory                     | ex06                                                                                                                     |
| Files to turn-in                      | `day03_ex06.sql`                                                                                 |
| **Allowed**                               |                                                                                                                          |
| Language                        | ANSI SQL                                                                                              |

Please find the same pizza names who have the same price, but from different pizzerias. Make sure that the result is ordered by pizza name. The sample of data is presented below. Please make sure your column names are corresponding column names below.

> Найти несколько пиц названия которых имеют одинаковую стоимость но в разных пицериях. Убедитесь что результат отсортирован по названию пицц. Простоой вывод представлен ниже. Пожалуйста проверьте что названия столбцов такие же как ниже. 

| pizza_name | pizzeria_name_1 | pizzeria_name_2 | price |
| ------ | ------ | ------ | ------ |
| cheese pizza | Best Pizza | Papa Johns | 700 |
| ... | ... | ... | ... |
 
  [D03_ex06](src/day03_ex06.sql)
  
  </details>


<details>
<summary>Exercise 07 - Let’s cook a new type of pizza</summary>


| Exercise 07: Let’s cook a new type of pizza |                                                                                                                          |
|---------------------------------------|--------------------------------------------------------------------------------------------------------------------------|
| Turn-in directory                     | ex07                                                                                                                     |
| Files to turn-in                      | `day03_ex07.sql`                                                                                 |
| **Allowed**                               |                                                                                                                          |
| Language                        | ANSI SQL                                                                                              |

Please register a new pizza with name “greek pizza” (use id = 19) with price 800 rubles in “Dominos” restaurant (pizzeria_id = 2).  
**Warning**: this exercise will probably(вероятно) be the cause  of changing data in the wrong way. Actually, you can restore the initial database model with data from the link in the “Rules of the day” section.

> ** Внимание**: это упражнение, вероятно, приведет к неправильному изменению данных. На самом деле, вы можете восстановить исходную модель базы данных, используя данные по ссылке в разделе “Правила дня”.

 
  [D03_ex07](src/day03_ex07.sql)
  
  </details>


<details>
<summary>Exercise 08 - Let’s cook a new type of pizza with more dynamics</summary>

| Exercise 08: Let’s cook a new type of pizza with more dynamics |                                                                                                                          |
|---------------------------------------|--------------------------------------------------------------------------------------------------------------------------|
| Turn-in directory                     | ex08                                                                                                                     |
| Files to turn-in                      | `day03_ex08.sql`                                                                                 |
| **Allowed**                               |                                                                                                                          |
| Language                        | ANSI SQL                                                                                              |           
| **Denied**                               |                                                                                                                          |
| SQL Syntax Pattern                        | Don’t use direct numbers for identifiers of Primary Key and pizzeria  
>Не используйте прямые цифры для идентификаторов первичного ключа и меню|       

Please register a new pizza with name “sicilian pizza” (whose id should be calculated by formula is “maximum id value + 1”) with a price of 900 rubles in “Dominos” restaurant (please use internal query to get identifier of pizzeria).  
**Warning**: this exercise will probably be the cause  of changing data in the wrong way. Actually, you can restore the initial database model with data from the link in the “Rules of the day” section and replay script from Exercise 07.

> Пожалуйста, зарегистрируйте новую пиццу с названием “сицилийская пицца” (идентификатор которой должен быть рассчитан по формуле “максимальное значение идентификатора + 1”) стоимостью 900 рублей в ресторане “Доминос” (пожалуйста, используйте внутренний запрос для получения идентификатора пиццерии).
>** Внимание**: это упражнение, вероятно, приведет к неправильному изменению данных. На самом деле, вы можете восстановить исходную модель базы данных, используя данные по ссылке в разделе “Правила дня” и воспроизвести сценарий из упражнения 07.

  [D03_ex08](src/day03_ex08.sql)

  </details>


<details>
<summary>Exercise 09 - New pizza means new visits</summary>

| Exercise 09: New pizza means new visits |                                                                                                                          |
|---------------------------------------|--------------------------------------------------------------------------------------------------------------------------|
| Turn-in directory                     | ex09                                                                                                                     |
| Files to turn-in                      | `day03_ex09.sql`                                                                                 |
| **Allowed**                               |                                                                                                                          |
| Language                        | ANSI SQL                                                                                              |
| **Denied**                               |                                                                                                                          |
| SQL Syntax Pattern                        | Don’t use direct numbers for identifiers of Primary Key and pizzeria                                                                                               |       

Please register new visits into Dominos restaurant from Denis and Irina on 24th of February 2022.
**Warning**: this exercise will probably be the cause  of changing data in the wrong way. Actually, you can restore the initial database model with data from the link in the “Rules of the day” section and replay script from Exercises 07 and 08..

> ** Внимание**: это упражнение, вероятно, приведет к неправильному изменению данных. На самом деле, вы можете восстановить исходную модель базы данных, используя данные по ссылке в разделе “Правила дня” и воспроизвести сценарий из упражнения 07 и 08 .  

[D03_ex09](src/day03_ex09.sql)

  </details>


<details>
<summary>Exercise 10 - New visits means new orders</summary>


| Exercise 10: New visits means new orders |                                                                                                                          |
|---------------------------------------|--------------------------------------------------------------------------------------------------------------------------|
| Turn-in directory                     | ex10                                                                                                                     |
| Files to turn-in                      | `day03_ex10.sql`                                                                                 |
| **Allowed**                               |                                                                                                                          |
| Language                        | ANSI SQL                                                                                              |
| **Denied**                               |                                                                                                                          |
| SQL Syntax Pattern                        | Don’t use direct numbers for identifiers of Primary Key and pizzeria                                                                                               |     


Please register new orders from Denis and Irina on 24th of February 2022 for the new menu with “sicilian pizza”.
**Warning**: this exercise will probably be the cause  of changing data in the wrong way. Actually, you can restore the initial database model with data from the link in the “Rules of the day” section and replay script from Exercises 07 , 08 and 09.

** Внимание**: это упражнение, вероятно, приведет к неправильному изменению данных. На самом деле, вы можете восстановить исходную модель базы данных, используя данные по ссылке в разделе “Правила дня” и воспроизвести сценарий из упражнения 07.

[D03_ex10](src/day03_ex10.sql)

  </details>


<details>
<summary>Exercise 11 - “Improve” a price for clients</summary>
## 


| Exercise 11: “Improve” a price for clients|                                                                                                                          |
|---------------------------------------|--------------------------------------------------------------------------------------------------------------------------|
| Turn-in directory                     | ex11                                                                                                                     |
| Files to turn-in                      | `day03_ex11.sql`                                                                                 |
| **Allowed**                               |                                                                                                                          |
| Language                        | ANSI SQL                                                                                              |
    
Please change the price for “greek pizza” on -10% from the current value.
**Warning**: this exercise will probably be the cause  of changing data in the wrong way. Actually, you can restore the initial database model with data from the link in the “Rules of the day” section and replay script from Exercises 07 , 08 ,09 and 10.

** Внимание**: это упражнение, вероятно, приведет к неправильному изменению данных. На самом деле, вы можете восстановить исходную модель базы данных, используя данные по ссылке в разделе “Правила дня” и воспроизвести сценарий из упражнения 07.

[D03_ex11](src/day03_ex11.sql)

  </details>


<details>
<summary>Exercise 12 - New orders are coming!</summary>



| Exercise 12: New orders are coming!|                                                                                                                          |
|---------------------------------------|--------------------------------------------------------------------------------------------------------------------------|
| Turn-in directory                     | ex12                                                                                                                     |
| Files to turn-in                      | `day03_ex12.sql`                                                                                 |
| **Allowed**                               |                                                                                                                          |
| Language                        | ANSI SQL                                                                                              |
| SQL Syntax Construction                        | `generate_series(...)`                                                                                              |
| SQL Syntax Patten                        | Please use “insert-select” pattern
`INSERT INTO ... SELECT ...`|
| **Denied**                               |                                                                                                                          |
| SQL Syntax Patten                        | - Don’t use direct numbers for identifiers of Primary Key, and menu 
- Don’t use window functions like `ROW_NUMBER( )`
- Don’t use atomic `INSERT` statements |

Please register new orders from all persons for “greek pizza” on 25th of February 2022.
**Warning**: this exercise will probably be the cause  of changing data in the wrong way. Actually, you can restore the initial database model with data from the link in the “Rules of the day” section and replay script from Exercises 07 , 08 ,09 , 10 and 11.
** Внимание**: это упражнение, вероятно, приведет к неправильному изменению данных. На самом деле, вы можете восстановить исходную модель базы данных, используя данные по ссылке в разделе “Правила дня” и воспроизвести сценарий из упражнения 07.

[D03_ex12](src/day03_ex12.sql)

  </details>



<details>
<summary>Exercise 13 - Money back to our customers</summary>


| Exercise 13: Money back to our customers|                                                                                                                          |
|---------------------------------------|--------------------------------------------------------------------------------------------------------------------------|
| Turn-in directory                     | ex13                                                                                                                     |
| Files to turn-in                      | `day03_ex13.sql`                                                                                 |
| **Allowed**                               |                                                                                                                          |
| Language                        | ANSI SQL                                                                                              |
    
Please write 2 SQL (DML) statements that delete all new orders from exercise #12 based on order date. Then delete “greek pizza” from the menu. 
**Warning**: this exercise will probably be the cause  of changing data in the wrong way. Actually, you can restore the initial database model with data from the link in the “Rules of the day” section and replay script from Exercises 07 , 08 ,09 , 10 , 11, 12 and 13.
** Внимание**: это упражнение, вероятно, приведет к неправильному изменению данных. На самом деле, вы можете восстановить исходную модель базы данных, используя данные по ссылке в разделе “Правила дня” и воспроизвести сценарий из упражнения 07 , 08 ,09 , 10 , 11, 12 and 13.

  [D03_ex13](src/day03_ex13.sql)
  
  </details>

