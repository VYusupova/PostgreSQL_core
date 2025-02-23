# Day 09 — SQL Bootcamp

## _RDBMS is not just a tables_(СУБД — это не просто таблицы)

Resume: Today you will see how to create and use functional blocks in Databases.  
Резюме: Сегодня вы увидите, как создавать и использовать функциональные блоки в базах данных.


<details>
<summary> Preamble </summary>

![D09_01](misc/images/D09_01.png)

В мире СУРБД существует множество функциональных языков программирования. В основном мы можем говорить о зависимости "один к одному" между конкретным движком СУРБД и функциональным языком внутри него. Пожалуйста, взгляните на пример этих языков:

- T-SQL,
- PL/SQL,
- SQL,
- PL/PGSQL,
- PL/R,
- PL/Python,
- и т. д.

На самом деле, в мире ИТ существует два противоположных мнения о том, где должна располагаться бизнес-логика. Первое мнение — на уровне приложений, второе — в СУБД, напрямую основанной на наборе UDF (User Defined Functions/Procedures/Packages). Каждый выбирает свой собственный способ реализации бизнес-логики. С нашей точки зрения, бизнес-логика должна находиться в обоих местах, и мы можем объяснить вам, почему. 
Пожалуйста, взгляните на 2 простые архитектуры ниже.

|  |  |
| ------ | ------ |
| ![D09_02](misc/images/D09_02.png) | Все понятно, фронтенды и бэкенды работают через специальный слой REST API, который реализует всю бизнес-логику. Это действительно идеальный мир приложений. |
|    Но всегда есть некоторые привилегированные люди/приложения (вроде IDE), которые работают напрямую с нашими базами данных и... наш шаблон может быть нарушен. | ![D09_03](misc/images/D09_03.png) |

> Just think about it and try to create a clean architecture :-)

## Rules of the day

 **Наш путь знаний является инкрементальным и линейным, поэтому, пожалуйста, имейте в виду, что все изменения, которые вы внесли в Day03 во время упражнений 07-13 и в Day04 во время упражнения 07, должны быть на месте (это похоже на реальный мир, когда мы применили релиз и должны быть согласованы с данными для новых изменений)**


## Exercise 00 — Audit of incoming inserts

| Exercise 00: Audit of incoming inserts |                                                                                                                          |
|---------------------------------------|--------------------------------------------------------------------------------------------------------------------------|
| Turn-in directory                     | ex00                                                                                                                     |
| Files to turn-in                      | `day09_ex00.sql`                                                                                 |
| **Allowed**                               |                                                                                                                          |
| Language                        | SQL, DDL, DML|

Мы хотим устойчивые данные, и мы не хотим терять никаких событий изменения. Давайте реализуем функцию аудита для входящих изменений `INSERT`. Cоздайте таблицу `person_audit` с той же структурой, что и таблица `person`, но добавьте некоторые дополнительные изменения. Взгляните на таблицу ниже с описаниями для каждого столбца.

| Column | Type | Description |
| ------ | ------ | ------ |
| created | timestamp with time zone | временная метка, когда было создано новое событие. Значение по умолчанию — текущая временная метка и NOT NULL |
| type_event | char(1) | возможные значения I (вставка), D (удаление), U (обновление). Значение по умолчанию — «I». NOT NULL. Добавить проверочное ограничение NOT NULL. Добавить проверочное ограничение `ch_type_event` возможными значениями ‘I’, ‘U’ and ‘D’ |
| row_id |bigint | copy of person.id. NOT NULL |
| name |varchar | copy of person.name (no any constraints) (без каких-либо ограничений) |
| age |integer | copy of person.age (no any constraints)(без каких-либо ограничений) |
| gender |varchar | copy of person.gender (no any constraints)(без каких-либо ограничений) |
| address |varchar | copy of person.address (no any constraints)(без каких-либо ограничений) |

- давайте создадим функцию триггера базы данных с именем `fnc_trg_person_insert_audit` которая должна обрабатывать `INSERT` DML traffic и создавать копию новой строки в таблице `person_audit`.

> подсказка: если вы хотите реализовать триггер PostgreSQL (подробнее см. в документации PostgreSQL), вам необходимо создать 2 объекта: функцию триггера базы данных( Database Trigger Function) и триггер базы данных( Database Trigger).

- определите триггер базы данных с именем `trg_person_insert_audit` и следующими параметрами:
    - trigger with "FOR EACH ROW" option; (триггер с опцией «ДЛЯ КАЖДОЙ СТРОКИ»;)
    - trigger with "AFTER INSERT"; (триггер с "AFTER INSERT";)
    - trigger calls `fnc_trg_person_insert_audit` trigger function. (триггер вызывает функцию триггера `fnc_trg_person_insert_audit`)

Когда вы закончите с объектами-триггерами введите `INSERT`. 

```sql
INSERT INTO person(id, name, age, gender, address)
VALUES (10,'Damir', 22, 'male', 'Irkutsk');
```



## Exercise 01 — Audit of incoming updates

| Exercise 01: Audit of incoming updates|                                                                                                                          |
|---------------------------------------|--------------------------------------------------------------------------------------------------------------------------|
| Turn-in directory                     | ex01                                                                                                                     |
| Files to turn-in                      | `day09_ex01.sql`                                                                                 |
| **Allowed**                               |                                                                                                                          |
| Language                        | SQL, DDL, DML                                                                                              |

Давайте продолжим реализацию нашего шаблона аудита для таблицы `person`. Просто определим триггер `trg_person_update_auditи` соответствующую функцию триггера `fnc_trg_person_update_audit` для обработки всего `UPDATE` трафика в таблице `person` . Нам следует сохранить **СТАРЫЕ** состояния всех значений атрибутов.

Когда закончите, примените приведенные ниже операторы ОБНОВЛЕНИЯ.  

```sql
UPDATE person SET name = 'Bulat' WHERE id = 10;
UPDATE person SET name = 'Damir' WHERE id = 10;
```


## Exercise 02 — Audit of incoming deletes

| Exercise 02: Audit of incoming deletes|                                                                                                                          |
|---------------------------------------|--------------------------------------------------------------------------------------------------------------------------|
| Turn-in directory                     | ex02                                                                                                                     |
| Files to turn-in                      | `day09_ex02.sql`                                                                                 |
| **Allowed**                               |                                                                                                                          |
| Language                        | SQL, DDL, DML                                                                                              |

Наконец, нам нужно обработать `DELETE` и сделать копию СТАРЫХ состояний для всех значений атрибута.создайте триггер  `trg_person_delete_audit` и соответствующую функцию триггера `fnc_trg_person_delete_audit`. 

Когда закончите, примените приведенные ниже операторы

```sql
DELETE FROM person WHERE id = 10;
```




## Exercise 03 — Generic Audit

| Exercise 03: Generic Audit |                                                                                                                          |
|---------------------------------------|--------------------------------------------------------------------------------------------------------------------------|
| Turn-in directory                     | ex03                                                                                                                     |
| Files to turn-in                      | `day09_ex03.sql`                                                                                 |
| **Allowed**                               |                                                                                                                          |
| Language                        | SQL, DDL, DML                                                                                              |

На самом деле, есть 3 триггера для одной `person`таблицы. Давайте объединим всю нашу логику в один основной триггер с названием `trg_person_audit` и новую соответствующую функцию триггера `fnc_trg_person_audit`.

Другими словами, весь трафик DML  (`INSERT`, `UPDATE`, `DELETE`) олжен обрабатываться одним функциональным блоком. Пожалуйста, явно определите отдельный блок IF-ELSE для каждого события (I, U, D)!  

Кроме того, пожалуйста, следуйте инструкциям ниже.

- удалить 3 старых триггера;
- удалить 3 старые функции триггера;
- для выполнения  `TRUNCATE` (или `DELETE`) oвсех строк в нашей  `person_audit` таблице.

Когда закончите, примените приведенные ниже операторы

```sql
INSERT INTO person(id, name, age, gender, address)  VALUES (10,'Damir', 22, 'male', 'Irkutsk');
UPDATE person SET name = 'Bulat' WHERE id = 10;
UPDATE person SET name = 'Damir' WHERE id = 10;
DELETE FROM person WHERE id = 10;
```

## Exercise 04 — Database View VS Database Function


| Exercise 04: Database View VS Database Function |                                                                                                                          |
|---------------------------------------|--------------------------------------------------------------------------------------------------------------------------|
| Turn-in directory                     | ex04                                                                                                                     |
| Files to turn-in                      | `day09_ex04.sql`                                                                                 |
| **Allowed**                               |                                                                                                                          |
| Language                        | SQL, DDL, DML                                                                                              |

Как вы помните, мы создали 2 представления базы данных для разделения данных из таблиц person по признаку пола. Пожалуйста, определите 2 функции SQL (обратите внимание, не функции pl/pgsql) с именами:

- `fnc_persons_female` (следует вернуть лиц женского пола),
- `fnc_persons_male` (следует вернуть лиц мужского пола).

Чтобы проверить себя и вызвать функцию, вы можете сделать следующее выражение (Удивительно! Вы можете работать с функцией как с виртуальной таблицей!):

```sql
    SELECT *
    FROM fnc_persons_male();

    SELECT *
    FROM fnc_persons_female();
```

</details>

## Exercise 05 — Parameterized Database Function


| Exercise 05: Parameterized Database Function|                                                                                                                          |
|---------------------------------------|--------------------------------------------------------------------------------------------------------------------------|
| Turn-in directory                     | ex05                                                                                                                     |
| Files to turn-in                      | `day09_ex05.sql`                                                                                 |
| **Allowed**                               |                                                                                                                          |
| Language                        |  SQL, DDL, DML                                                                                               |

Похоже, что 2 функции из упражнения 04 требуют более общего подхода. Пожалуйста, удалите эти функции из базы данных перед продолжением. Напишите общую функцию SQL (обратите внимание, не pl/pgsql-function) с именем `fnc_persons`.Эта функция должна иметь  `IN` параметр pgender со значением по умолчанию = 'female'.

Чтобы проверить себя и вызвать функцию, вы можете сделать такое выражение 

 ```sql  
    select *
    from fnc_persons(pgender := 'male');

    select *
    from fnc_persons();
```

## Chapter X
## Exercise 06 — Function like a function-wrapper


| Exercise 06: Function like a function-wrapper|                                                                                                                          |
|---------------------------------------|--------------------------------------------------------------------------------------------------------------------------|
| Turn-in directory                     | ex06                                                                                                                     |
| Files to turn-in                      | `day09_ex06.sql`                                                                                 |
| **Allowed**                               |                                                                                                                          |
| Language                        | SQL, DDL, DML                                                                                              |

Теперь давайте рассмотрим функции pl/pgsql.  

Создайте функцию pl/pgsql `fnc_person_visits_and_eats_on_date`на основе оператора SQL, которая найдет названия пиццерий, которые (`IN` pperson parameter with default value 'Dmitriy') vи где он мог купить пиццу по цене ниже указанной суммы в рублях (`IN` pprice parameter with default value 500) на указанную дату  (`IN` pdate parameter with default value January 8, 2022).

Чтобы проверить себя и вызвать функцию, вы можете сделать следующее выражение.

 ```sql  
    select *
    from fnc_person_visits_and_eats_on_date(pprice := 800);

    select *
    from fnc_person_visits_and_eats_on_date(pperson := 'Anna',pprice := 1300,pdate := '2022-01-01');
```

## Chapter XI
## Exercise 07 — Different view to find a Minimum


| Exercise 07: Different view to find a Minimum|                                                                                                                          |
|---------------------------------------|--------------------------------------------------------------------------------------------------------------------------|
| Turn-in directory                     | ex07                                                                                                                     |
| Files to turn-in                      | `day09_ex07.sql`                                                                                 |
| **Allowed**                               |                                                                                                                          |
| Language                        | SQL, DDL, DML                                                                                              |

Напишите функцию SQL или pl/pgsql `func_minimum` (it is up to you) (на ваше усмотрение), которая имеет входной параметр, представляющий собой массив чисел, и функция должна возвращать минимальное значение. 

Чтобы проверить себя и вызвать функцию, вы можете сделать следующее выражение.

```sql  
    SELECT func_minimum(VARIADIC arr => ARRAY[10.0, -1.0, 5.0, 4.4]);
```

## Chapter XII
## Exercise 08 — Fibonacci algorithm is in a function


| Exercise 08: Fibonacci algorithm is in a function|                                                                                                                          |
|---------------------------------------|--------------------------------------------------------------------------------------------------------------------------|
| Turn-in directory                     | ex08                                                                                                                     |
| Files to turn-in                      | `day09_ex08.sql`                                                                                 |
| **Allowed**                               |                                                                                                                          |
| Language                        | SQL, DDL, DML                                                                                              |

Напишите функцию SQL или pl/pgsql  `fnc_fibonacci` (на ваше усмотрение), которая имеет входной параметр pstop типа integer (по умолчанию 10), а выход функции представляет собой таблицу всех чисел Фибоначчи, меньших pstop.

Чтобы проверить себя и вызвать функцию, вы можете сделать следующее выражение.

```sql  
    select * from fnc_fibonacci(100);
    select * from fnc_fibonacci();
```
