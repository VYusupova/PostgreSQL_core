--ex 00


--SESSION 1
BEGIN;
UPDATE pizzeria SET rating = 5 where name = 'Pizza Hut';

SELECT * FROM pizzeria WHERE name = 'Pizza Hut';

COMMIT;


--SESSION 2
SELECT * FROM pizzeria WHERE name = 'Pizza Hut';



--ex 01
--SESSION 1
BEGIN;

SELECT * FROM pizzeria WHERE name = 'Pizza Hut';

UPDATE pizzeria SET rating = 4 where name = 'Pizza Hut';

COMMIT;

SELECT * FROM pizzeria WHERE name = 'Pizza Hut';

--SESSION 2
BEGIN;

SELECT * FROM pizzeria WHERE name = 'Pizza Hut';

UPDATE pizzeria SET rating = 3.6 where name = 'Pizza Hut';

COMMIT;

SELECT * FROM pizzeria WHERE name = 'Pizza Hut';

--ex 02

--SESSION 1
BEGIN TRANSACTION ISOLATION LEVEL REPEATABLE READ;

SELECT * FROM pizzeria WHERE name = 'Pizza Hut';

UPDATE pizzeria SET rating = 4 where name = 'Pizza Hut';

COMMIT;

SELECT * FROM pizzeria WHERE name = 'Pizza Hut';

--SESSION 2
BEGIN TRANSACTION ISOLATION LEVEL REPEATABLE READ;;

SELECT * FROM pizzeria WHERE name = 'Pizza Hut';

UPDATE pizzeria SET rating = 3.6 where name = 'Pizza Hut';

COMMIT;

SELECT * FROM pizzeria WHERE name = 'Pizza Hut';


--ex 03

--SESSION 1
BEGIN ;
SELECT * FROM pizzeria WHERE name = 'Pizza Hut';

SELECT * FROM pizzeria WHERE name = 'Pizza Hut';

COMMIT;

SELECT * FROM pizzeria WHERE name = 'Pizza Hut';

--SESSION 2
BEGIN ;

UPDATE pizzeria SET rating = 3.6 where name = 'Pizza Hut';

COMMIT;

SELECT * FROM pizzeria WHERE name = 'Pizza Hut';


--ex 04

--SESSION 1
BEGIN TRANSACTION ISOLATION LEVEL SERIALIZABLE;
SELECT * FROM pizzeria WHERE name = 'Pizza Hut';

SELECT * FROM pizzeria WHERE name = 'Pizza Hut';

COMMIT;

SELECT * FROM pizzeria WHERE name = 'Pizza Hut';

--SESSION 2
BEGIN TRANSACTION ISOLATION LEVEL SERIALIZABLE;

UPDATE pizzeria SET rating = 3.6 where name = 'Pizza Hut';

COMMIT;

SELECT * FROM pizzeria WHERE name = 'Pizza Hut';


--ex 05

--SESSION 1
BEGIN ;
SELECT SUM(rating) FROM pizzeria;

SELECT SUM(rating) FROM pizzeria;

COMMIT;

SELECT SUM(rating) FROM pizzeria;

--SESSION 2
BEGIN ;

INSERT INTO pizzeria (id, name, rating)
VALUES (10, 'Kazan Pizza', 5);

COMMIT;

SELECT SUM(rating) FROM pizzeria;


--ex 06
--SESSION 1
BEGIN ;
SELECT SUM(rating) FROM pizzeria;

SELECT SUM(rating) FROM pizzeria;

COMMIT;

SELECT SUM(rating) FROM pizzeria;

--SESSION 2
BEGIN ;

INSERT INTO pizzeria (id, name, rating)
VALUES (11, 'Kazan Pizza', 4);

COMMIT;

SELECT SUM(rating) FROM pizzeria;


--ex 07

--SESSION 1
BEGIN ;
UPDATE pizzeria SET rating = 3
WHERE id = 1;

UPDATE pizzeria SET rating = 1
WHERE id = 2;


COMMIT;



--SESSION 2
BEGIN ;

UPDATE pizzeria SET rating = 2
WHERE id = 2;

UPDATE pizzeria SET rating = 0
WHERE id = 1;

COMMIT;

