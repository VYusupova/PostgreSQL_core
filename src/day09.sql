/************** EX 00 ****************************/
/**Cоздайте таблицу person_audit с той же структурой, что и таблица person**/
 /**  функцию  триггера базы данных с именем fnc_trg_person_insert_audit которая должна обрабатывать INSERT создавать копию новой строки в таблице person_audit.**/

CREATE TABLE IF NOT EXISTS person_audit
( created timestamp NOT NULL DEFAULT current_date,
  type_event char(1) NOT NULL DEFAULT 'I',
  row_id bigint NOT NULL,
  name varchar,
  age integer,
  gender varchar,
  address varchar
);

ALTER TABLE person_audit  
ADD CONSTRAINT  ch_type_event CHECK ( type_event IN ('I', 'D', 'U') );

CREATE FUNCTION fnc_trg_person_insert_audit ()
RETURNS TRIGGER AS $person_audit$
    BEGIN
       IF (TG_OP = 'INSERT') THEN
            INSERT INTO person_audit 
            VALUES (now(), 'I', NEW.id, NEW.name, NEW.age, New.gender, NEW.ADDress);
        END IF;
        RETURN NULL; -- Возвращаемое значение для триггеров AFTER игнорируется 
    END;
$person_audit$
LANGUAGE plpgsql;

CREATE TRIGGER trg_person_insert_audit
	AFTER INSERT ON person
    FOR EACH ROW EXECUTE PROCEDURE fnc_trg_person_insert_audit();

/* Проверка что триггре работает */
INSERT INTO person VALUES (10, 'Damir', 22, 'male', 'Irkutsk');

SELECT * FROM person_audit ;


/************** EX 01 ****************************/
/**** Давайте продолжим реализацию нашего шаблона аудита для таблицы person.***/
/****Просто определим триггер trg_person_update_audit ***/

CREATE FUNCTION fnc_trg_person_update_audit ()
RETURNS TRIGGER AS $person_audit$
    BEGIN
       IF (TG_OP = 'UPDATE') THEN
            INSERT INTO person_audit 
            VALUES (now(), 'U', OLD.id, OLD.name, OLD.age, OLD.gender, OLD.ADDress);
        END IF;
        RETURN NULL; 
    END;
$person_audit$
LANGUAGE plpgsql;

CREATE TRIGGER trg_person_update_audit
	AFTER UPDATE ON person
    FOR EACH ROW EXECUTE PROCEDURE fnc_trg_person_update_audit();
    
    
    /* Проверка что триггре работает */
UPDATE person SET name = 'Bulat' WHERE id = 10;
UPDATE person SET name = 'Damir' WHERE id = 10;

SELECT * FROM person_audit ;

/***************** EX 02 ****************************/
/**нужно обработать DELETE и сделать копию СТАРЫХ состояний для всех значений атрибута**/

CREATE FUNCTION fnc_trg_person_delete_audit ()
RETURNS TRIGGER AS $person_audit$
    BEGIN
       IF (TG_OP = 'DELETE') THEN
            INSERT INTO person_audit 
            VALUES (now(), 'D', OLD.id, OLD.name, OLD.age, OLD.gender, OLD.ADDress);
        END IF;
        RETURN NULL;  
    END;
$person_audit$
LANGUAGE plpgsql;

CREATE TRIGGER trg_person_delete_audit
	AFTER DELETE ON person
    FOR EACH ROW EXECUTE PROCEDURE fnc_trg_person_delete_audit();
     
    /* Проверка что триггре работает */
 DELETE FROM person WHERE id = 10;

SELECT * FROM person_audit ;
SELECT * FROM person;

/********************* EX 03 ****************************/
/***объединим всю нашу логику в один основной триггер***/
/***трафик DML должен обрабатываться одним функциональным блоком.***/
DROP FUNCTION IF EXISTS fnc_trg_person_insert_audit CASCADE;;
DROP FUNCTION IF EXISTS fnc_trg_person_update_audit CASCADE;
DROP FUNCTION IF EXISTS fnc_trg_person_delete_audit CASCADE;


DROP TRIGGER IF EXISTS trg_person_insert_audit ON person ;
DROP TRIGGER IF EXISTS trg_person_update_audit ON person ;
DROP TRIGGER IF EXISTS trg_person_delete_audit ON person ;

TRUNCATE person_audit;

CREATE FUNCTION fnc_trg_person_audit ()
RETURNS TRIGGER AS $person_audit$
    BEGIN
        IF (TG_OP = 'INSERT') THEN
            INSERT INTO person_audit 
            VALUES (now(), 'I', NEW.id, NEW.name, NEW.age, New.gender, NEW.ADDress);
        ELSEIF (TG_OP = 'UPDATE') THEN
            INSERT INTO person_audit 
            VALUES (now(), 'U', OLD.id, OLD.name, OLD.age, OLD.gender, OLD.ADDress);
        ELSEIF  (TG_OP = 'DELETE') THEN
            INSERT INTO person_audit 
            VALUES (now(), 'D', OLD.id, OLD.name, OLD.age, OLD.gender, OLD.ADDress);
        END IF;
        RETURN NULL;  
    END;
$person_audit$
LANGUAGE plpgsql;

CREATE TRIGGER trg_person_audit
	AFTER DELETE OR UPDATE OR INSERT ON person
    FOR EACH ROW EXECUTE PROCEDURE fnc_trg_person_audit();


    /* Проверка что триггре работает */
INSERT INTO person(id, name, age, gender, ADDress)  VALUES (10,'Damir', 22, 'male', 'Irkutsk');
UPDATE person SET name = 'Bulat' WHERE id = 10;
UPDATE person SET name = 'Damir' WHERE id = 10;
DELETE FROM person WHERE id = 10;
SELECT * FROM person_audit ;

/*********************** EX 04 ****************************/
/***Как вы помните, мы создали 2 представления базы данных для разделения данных из таблиц person по признаку пола.****/
/**определите 2 функции SQL (обратите внимание, не функции pl/pgsql) */
/**fnc_persons_female & fnc_persons_male ***/
CREATE FUNCTION fnc_persons_female()  
RETURNS TABLE(name varchar) 
AS
$$
   SELECT NAME FROM v_persons_female  ;
$$ LANGUAGE SQL;

CREATE FUNCTION fnc_persons_male() 
RETURNS TABLE(name varchar) 
AS
$$
   SELECT NAME FROM v_persons_male  ;
$$ LANGUAGE SQL;

  /* Проверка что функция работает */
SELECT * FROM  fnc_persons_female();
SELECT * FROM  fnc_persons_male();


/*********************** EX 05 ****************************/
CREATE OR REPLACE FUNCTION fnc_persons(pgender varchar='female')
RETURNS TABLE (
        id bigint,
        name varchar,
        age integer,
        gender varchar,
        address varchar
) AS $$
        (SELECT * FROM person P WHERE P.gender = pgender);
$$ LANGUAGE sql;
SELECT *
FROM fnc_persons(pgender:='male');
SELECT *
FROM fnc_persons();



/*********************** EX 06 ****************************/
/***Создайте функцию pl/pgsql fnc_person_visits_and_eats_on_date**/
/**айдет названия пиццерий, которые (IN pperson parameter with default value 'Dmitriy') 
**и где он мог купить пиццу по цене ниже указанной суммы в рублях (IN pprice parameter with default value 500) 
**на указанную дату (IN pdate parameter with default value January 8, 2022).****/
/******************** EX 06 ****************************/

CREATE OR REPLACE FUNCTION fnc_person_visits_and_eats_on_date (pperson VARCHAR(6) DEFAULT 'Dmitriy' ,
                                                               pprice NUMERIC DEFAULT 800,
                                                               pdate date DEFAULT '20220108' ) 
RETURNS TABLE(name varchar) 
AS
$$ 
BEGIN
  RETURN QUERY 
  SELECT DISTINCT pizzeria.name 
  FROM person 
  JOIN person_visits pv ON pv.person_id = person.id 
  JOIN menu ON menu.pizzeria_id = pv.pizzeria_id  
  JOIN pizzeria ON pv.pizzeria_id = pizzeria.id
  WHERE person.name = $1
    AND menu.price < pprice
    AND pv.visit_date = pdate;
END;
$$  
LANGUAGE plpgsql;

  /* Проверка что функция работает */
SELECT * FROM fnc_person_visits_and_eats_on_date();
SELECT * FROM fnc_person_visits_and_eats_on_date(pprice := 800);
SELECT * FROM fnc_person_visits_and_eats_on_date(pperson := 'Anna',pprice := 1300,pdate := '2022-01-01');
   
   /*********************** EX 07 ****************************/
/***Напишите функцию SQL или pl/pgsql func_minimum ***/
/***которая имеет входной параметр, представляющий собой массив чисел, ****/
/***и функция должна возвращать минимальное значение.***/

CREATE OR REPLACE FUNCTION func_minimum (VARIADIC arr numeric[]) 
RETURNS NUMERIC
AS
$$ 
    SELECT min($1[i]) FROM generate_subscripts($1, 1) g(i);
$$  
LANGUAGE sql;

SELECT func_minimum(VARIADIC arr => ARRAY[-1.1, 10.0, -1.0, 5.0, 4.4]);
  
  
/*********************** EX 08 ****************************/
/***Напишите функцию SQL или pl/pgsql fnc_fibonacci  **/
/**которая имеет входной параметр pstop типа integer (по умолчанию 10),  ***/
/***а выход функции представляет собой таблицу всех чисел Фибоначчи, меньших pstop. ***/
/*********************** EX 08 ****************************/
CREATE OR REPLACE FUNCTION fnc_fibonacci (pstop numeric DEFAULT 10) 
RETURNS TABLE(val numeric)
AS
$$ 
  WITH RECURSIVE fibonacci_numbers(val1, val2, step) AS (
    VALUES(1, 1, 1)
      UNION ALL
    SELECT val2, val1 + val2, step + 1 FROM fibonacci_numbers
    WHERE val2 < $1
  )
	SELECT val1 FROM fibonacci_numbers
$$  
LANGUAGE sql;
  /* Проверка что функция работает */
SELECT * FROM fnc_fibonacci(100);
SELECT * FROM fnc_fibonacci(10);
SELECT * FROM fnc_fibonacci();
