# Day 07 - Piscine SQL

## _Aggregated data is more informative, isn't it?_(Агрегированные данные более информативны, не правда ли?)

Resume: Today you will see how to use specific OLAP constructions to get a "Value" from data.
> Сегодня вы познакомитесь со специальными OLAP конструкциями для получения "значений" из данных

<details>
<summary>  Exercise 00 - Simple aggregated information</summary>

| Exercise 00: Simple aggregated information |                                                                                                                          |
|---------------------------------------|--------------------------------------------------------------------------------------------------------------------------|
| Turn-in directory                     | ex00                                                                                                                     |
| Files to turn-in                      | `day07_ex00.sql`                                                                                 |
| **Allowed**                               |                                                                                                                          |
| Language                        | ANSI SQL|

Let's make a simple aggregation, please write a SQL statement that returns person identifiers and corresponding number of visits in any pizzerias and sorts by number of visits in descending mode and sorts by `person_id` in ascending mode. Please take a look at the sample of data below.
> Давайте сделаем простую агрегацию, пожалуйста, напишите SQL-выражение, которое возвращает идентификаторы людей и соответствующее количество посещений в любых пиццериях и сортирует по количеству посещений по убыванию и сортирует по `person_id` по возрастанию. Пожалуйста, взгляните на пример данных ниже.

| person_id | count_of_visits |
| ------ | ------ |
| 9 | 4 |
| 4 | 3 |
| ... | ... | 


</details>

<details>
<summary> Exercise 01 - Let’s see real names </summary>

| Exercise 01: Let’s see real names|                                                                                                                          |
|---------------------------------------|--------------------------------------------------------------------------------------------------------------------------|
| Turn-in directory                     | ex01                                                                                                                     |
| Files to turn-in                      | `day07_ex01.sql`                                                                                 |
| **Allowed**                               |                                                                                                                          |
| Language                        | ANSI SQL                                                                                              |

Please modify an SQL statement from Exercise 00 and return a person name (not an identifier). Additional clause(дополнительным условием) is we need to see only top 4 people with maximum visits in each pizzerias and sorted by a person name. See the example of output data below.

>Измените SQL-выражение из упражнения 00 и верните имя человека (не идентификатор). Дополнительным условием является то, что нам нужно увидеть только 4 лучших человека с максимальным количеством посещений в каждой пиццерии и отсортировать по имени человека. Смотрите пример выходных данных ниже.

| name | count_of_visits |
| ------ | ------ |
| Dmitriy | 4 |
| Denis | 3 |
| ... | ... | 



</details>

<details>
<summary> Exercise 02 - Restaurants statistics </summary>

| Exercise 02: Restaurants statistics|                                                                                                                          |
|---------------------------------------|--------------------------------------------------------------------------------------------------------------------------|
| Turn-in directory                     | ex02                                                                                                                     |
| Files to turn-in                      | `day07_ex02.sql`                                                                                 |
| **Allowed**                               |                                                                                                                          |
| Language                        | ANSI SQL                                                                                              |

Please write a SQL statement to see 3 favorite restaurants by visits and by orders in a list (please add an action_type column with values 'order' or 'visit', it depends on the data from the corresponding table). Please have a look at the example data below. The result should be sorted in ascending order by the action_type column and in descending order by the count column.

> Напишите SQL-выражение, чтобы увидеть 3 любимых ресторана по посещениям и по заказам в списке (добавьте столбец action_type со значениями «order» или «visit», это зависит от данных из соответствующей таблицы). Посмотрите на пример данных ниже. Результат должен быть отсортирован в порядке возрастания по столбцу action_type и в порядке убывания по столбцу count.

| name | count | action_type |
| ------ | ------ | ------ |
| Dominos | 6 | order |
| ... | ... | ... |
| Dominos | 7 | visit |
| ... | ... | ... |

</details>

<details>
<summary> Exercise 03 - Restaurants statistics #2 </summary>

| Exercise 03: Restaurants statistics #2 |                                                                                                                          |
|---------------------------------------|--------------------------------------------------------------------------------------------------------------------------|
| Turn-in directory                     | ex03                                                                                                                     |
| Files to turn-in                      | `day07_ex03.sql`                                                                                 |
| **Allowed**                               |                                                                                                                          |
| Language                        | ANSI SQL                                                                                              |

Write an SQL statement to see how restaurants are grouped by visits and by orders, and joined together by restaurant name.  
You can use the internal SQL from Exercise 02 (Restaurants by Visits and by Orders) without any restrictions on the number of rows.
> Напишите SQL-выражение, чтобы увидеть, как рестораны группируются по посещениям и по заказам, а также объединяются по названию ресторана.
Вы можете использовать внутренний SQL из упражнения 02 (Рестораны по посещениям и по заказам) без каких-либо ограничений на количество строк.

In addition, add the following rules.
- Compute a sum of orders and visits for the corresponding pizzeria (note that not all pizzeria keys are represented in both tables).
- Sort the results by the `total_count` column in descending order and by the `name` column in ascending order.

>Кроме того, добавьте следующие правила.
>- Вычислите сумму заказов и посещений для соответствующей пиццерии (обратите внимание, что не все ключи пиццерии представлены в обеих таблицах).
>- Отсортируйте результаты по столбцу `total_count` в порядке убывания и по столбцу `name` в порядке возрастания.

Take a look at the example data below.
>Посмотрите на пример данных ниже.

| name | total_count |
| ------ | ------ |
| Dominos | 13 |
| DinoPizza | 9 |
| ... | ... | 


</details>

<details>
<summary> Exercise 04 - Clause for groups </summary>

| Exercise 04: Clause for groups |                                                                                                                          |
|---------------------------------------|--------------------------------------------------------------------------------------------------------------------------|
| Turn-in directory                     | ex04                                                                                                                     |
| Files to turn-in                      | `day07_ex04.sql`                                                                                 |
| **Allowed**                               |                                                                                                                          |
| Language                        | ANSI SQL                                                                                              |
| **Denied**                               |                                                                                                                          |
| Syntax construction                        | `WHERE`                                                                                              |

Please write a SQL statement that returns the person's name and the corresponding number of visits to any pizzerias if the person has visited more than 3 times (> 3). Please take a look at the sample data below.
>Пожалуйста, напишите SQL-выражение, которое возвращает имя человека и соответствующее количество посещений любой пиццерии, если человек посетил ее более 3 раз (> 3). Пожалуйста, взгляните на пример данных ниже.

| name | count_of_visits |
| ------ | ------ |
| Dmitriy | 4 |



</details>

<details>
<summary> Exercise 05 - Person's uniqueness </summary>


| Exercise 05: Person's uniqueness|                                                                                                                          |
|---------------------------------------|--------------------------------------------------------------------------------------------------------------------------|
| Turn-in directory                     | ex05                                                                                                                     |
| Files to turn-in                      | `day07_ex05.sql`                                                                                 |
| **Allowed**                               |                                                                                                                          |
| Language                        |  ANSI SQL                                                                                              |
| **Denied**                               |                                                                                                                          |
| Syntax construction                        |  `GROUP BY`, any type (`UNION`,...) working with sets                                                                                              |

Please write a simple SQL query that returns a list of unique person names who have placed orders at any pizzerias. The result should be sorted by person name. Please see the example below.

> Напишите простой SQL-запрос, который возвращает список уникальных имен людей, которые делали заказы в любой пиццерии. Результат должен быть отсортирован по имени человека. Смотрите пример ниже.

| name | 
| ------ |
| Andrey |
| Anna | 
| ... | 

</details>

<details>
<summary> Exercise 06 - Restaurant metrics </summary>

| Exercise 06: Restaurant metrics|                                                                                                                          |
|---------------------------------------|--------------------------------------------------------------------------------------------------------------------------|
| Turn-in directory                     | ex06                                                                                                                     |
| Files to turn-in                      | `day07_ex06.sql`                                                                                 |
| **Allowed**                               |                                                                                                                          |
| Language                        | ANSI SQL                                                                                              |

Please write a SQL statement that returns the number of orders, the average price, the maximum price and the minimum price for pizzas sold by each pizzeria restaurant. The result should be sorted by pizzeria name. See the sample data below. 
Round the average price to 2 floating numbers.

>Напишите SQL-выражение, которое возвращает количество заказов, среднюю цену, максимальную цену и минимальную цену пиццы, проданной каждой пиццерией. Результат должен быть отсортирован по названию пиццерии. См. пример данных ниже.
Округлите среднюю цену до 2 плавающих чисел.

| name | count_of_orders | average_price | max_price | min_price |
| ------ | ------ | ------ | ------ | ------ |
| Best Pizza | 5 | 780 | 850 | 700 |
| DinoPizza | 5 | 880 | 1000 | 800 |
| ... | ... | ... | ... | ... |


</details>

<details>
<summary> Exercise 07 - Average global rating</summary>

| Exercise 07: Average global rating|                                                                                                                          |
|---------------------------------------|--------------------------------------------------------------------------------------------------------------------------|
| Turn-in directory                     | ex07                                                                                                                     |
| Files to turn-in                      | `day07_ex07.sql`                                                                                 |
| **Allowed**                               |                                                                                                                          |
| Language                        | ANSI SQL                                                                                              |

Write an SQL statement that returns a common average rating (the output attribute name is global_rating) for all restaurants. Round your average rating to 4 floating point numbers.

>Напишите SQL-выражение, которое возвращает общий средний рейтинг (имя выходного атрибута — global_rating) для всех ресторанов. Округлите средний рейтинг до 4 чисел с плавающей точкой.

</details>

<details>
<summary> Exercise 08 - Find pizzeria’s restaurant locations </summary>


| Exercise 08: Find pizzeria’s restaurant locations|                                                                                                                          |
|---------------------------------------|--------------------------------------------------------------------------------------------------------------------------|
| Turn-in directory                     | ex08                                                                                                                     |
| Files to turn-in                      | `day07_ex08.sql`                                                                                 |
| **Allowed**                               |                                                                                                                          |
| Language                        | ANSI SQL                                                                                              |

We know personal addresses from our data. Let's assume that this person only visits pizzerias in his city. Write a SQL statement that returns the address, the name of the pizzeria, and the amount of the person's orders. The result should be sorted by address and then by restaurant name. Please take a look at the sample output data below.

> Мы знаем личные адреса из наших данных. Предположим, что этот человек посещает только пиццерии в своем городе. Напишите SQL-выражение, которое возвращает адрес, название пиццерии и сумму заказов этого человека. Результат должен быть отсортирован по адресу, а затем по названию ресторана. Пожалуйста, посмотрите на пример выходных данных ниже.

| address | name |count_of_orders |
| ------ | ------ |------ |
| Kazan | Best Pizza |4 |
| Kazan | DinoPizza |4 |
| ... | ... | ... | 


</details>

<details>
<summary>Exercise 09 - Explicit type transformation </summary> 

| Exercise 09: Explicit type transformation|                                                                                                                          |
|---------------------------------------|--------------------------------------------------------------------------------------------------------------------------|
| Turn-in directory                     | ex09                                                                                                                     |
| Files to turn-in                      | `day07_ex09.sql`                                                                                 |
| **Allowed**                               |                                                                                                                          |
| Language                        | ANSI SQL                                                                                              |

Please write a SQL statement that returns aggregated information by person's address, the result of "Maximum Age - (Minimum Age / Maximum Age)" presented as a formula column, next is average age per address and the result of comparison between formula and average columns (in other words, if formula is greater than average, then True, otherwise False value).

>Напишите SQL-выражение, которое возвращает агрегированную информацию по адресу человека, результат «Максимальный возраст - (Минимальный возраст / Максимальный возраст)», представленный в виде столбца формулы, затем следует средний возраст по адресу и результат сравнения между столбцами формулы и средним значением (другими словами, если формула больше среднего, то значение True, в противном случае значение False).

The result should be sorted by address column. Please take a look at the example of output data below.

| address | formula |average | comparison |
| ------ | ------ |------ |------ |
| Kazan | 44.71 |30.33 | true |
| Moscow | 20.24 | 18.5 | true |
| ... | ... | ... | ... |


</details>

[D06_Exercise 01, 02, 03, 04, 05, 06, 07, 08, 09 ](src/day07.sql)
