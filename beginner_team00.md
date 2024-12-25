# Team 00 - Piscine SQL

## _Traveling Salesman Problem_

Resume: Today you will implementing a quick solution on SQL to achieve results of Traveling Salesman Problem.
> Резюме: Сегодня вы будете внедрять быстрое решение на SQL для достижения результатов в задаче коммивояжера.

## Exercise 00 - Classical TSP

| Exercise 00: Classical TSP|                                                                                                                          |
|---------------------------------------|--------------------------------------------------------------------------------------------------------------------------|
| Turn-in directory                     | ex00                                                                                                                     |
| Files to turn-in                      | `team00_ex00.sql` DDL for table creation with INSERTs of data; SQL DML statement                                                                                |
| **Allowed**                               |                                                                                                                          |
| Language                        | ANSI SQL|
| SQL Syntax Pattern                        | Recursive Query|

![T00_02](misc/images/T00_02.png)

Take a look at the Graph on the left. 
There are 4 cities (a, b, c and d) and arcs between them with costs (or taxes). Actually, the cost is (a,b) = (b,a).
> Взгляните на график слева. Города (a, b, c и d) и дуги между ними с расходами (или налогами). На самом деле, расход составляет (a, b) = (b, a).

Please create a table with named nodes using structure {point1, point2, cost} and fill data based on a picture (remember there are direct and reverse paths between 2 nodes).
Please write a SQL statement that returns all tours (aka paths) with minimum travel cost if we start from city "a".
Remember, you need to find the cheapest way to visit all cities and return to your starting point. For example, the tour looks like a -> b -> c -> d -> a.

> Пожалуйста, создайте таблицу с именованными узлами, используя структуру {point1, point2, cost}, и заполните данные на основе рисунка (помните, что между 2 узлами есть прямые и обратные пути).
Пожалуйста, напишите SQL-выражение, которое возвращает все туры (т. е. пути) с минимальной стоимостью поездки, если мы начнем с города «a».
Помните, вам нужно найти самый дешевый способ посетить все города и вернуться в исходную точку. Например, тур выглядит как a -> b -> c -> d -> a.

Below is an example of the output data. Please sort the data by total_cost and then by tour.

| total_cost | tour |
| ------ | ------ |
| 80 | {a,b,d,c,a} |
| ... | ... |

## Chapter V
## Exercise 01 - Opposite TSP

| Exercise 01: Opposite TSP|                                                                                                                          |
|---------------------------------------|--------------------------------------------------------------------------------------------------------------------------|
| Turn-in directory                     | ex01                                                                                                                     |
| Files to turn-in                      | `team00_ex01.sql`     SQL DML statement                                                                             |
| **Allowed**                               |                                                                                                                          |
| Language                        | ANSI SQL|
| SQL Syntax Pattern                        | Recursive Query|

Please add a way to see additional rows with the most expensive cost to the SQL from the previous exercise. Take a look at the sample data below. Please sort the data by total_cost and then by trip.

| total_cost | tour |
| ------ | ------ |
| 80 | {a,b,d,c,a} |
| ... | ... |
| 95 | {a,d,c,b,a} |


