-- удаление таблицы если она существует  в PostgreSQL
-- CASCADE если есть объекты которые от нее зависят
drop TABLE if EXISTS nodes CASCADE;
--DROP VIEW if EXISTS tour_of_cities CASCADE;

CREATE TABLE nodes
(  id int not NULL PRIMARY KEY,
   point1 VARCHAR NOT NULL,
   point2 VARCHAR NOT NULL,
   cost int  
);

INSERT INTO nodes VALUES (1, 'A', 'B', 10);
INSERT INTO nodes VALUES (2, 'A', 'D', 20);
INSERT INTO nodes VALUES (3, 'A', 'C', 15);
INSERT INTO nodes VALUES (4, 'B', 'D', 25);
INSERT INTO nodes VALUES (5, 'B', 'C', 35);
INSERT INTO nodes VALUES (6, 'C', 'D', 30);

--Объявление и использование переменных в PostgreSQL
DO $$
DECLARE i int := (SELECT max(id) FROM nodes);
begin
insert into nodes 
	SELECT id+i,
           point2,
           point1,
           cost
      FROM nodes;
end $$;

--SELECT * from nodes
--DELETE FROM struct WHERE id in(3,4,7,8,11,12)


CREATE VIEW tour_of_cities
AS
WITH RECURSIVE tour_cities (tour_start, tour_end, tour, total_cost, count_cities) AS 
(
SELECT point1 as tour_start,
       point2 AS tour_end,
       CONCAT ( point1, ',' ,point2) as tour,
       cost as total_cost,
  	   2 as count_cities
  FROM nodes   
  
UNION 

SELECT tour_cities.tour_start, 
       n.point2 AS tour_end, 
       cast (tour_cities.tour || ',' ||  n.point2 as varchar(50)) AS tour,
       n.cost+tour_cities.total_cost,
        1+tour_cities.count_cities
  FROM tour_cities
  JOIN nodes AS n ON tour_cities.tour_end = n.point1 
AND strpos(tour,n.point2) <= 1
  AND  strpos(tour,n.point1) > 1
)

SELECT * FROM tour_cities;

CREATE VIEW tour_all_cities
AS

select cast ('{' || tour || '}' as varchar(50)) as tour,
       total_cost
from tour_of_cities 
WHERE
  -- total_cost = (SELECT MIN(total_cost) 
  --                FROM tour_cities 
  --  WHERE count_cities = (SELECT count (DISTINCT point1)+1 
   --                                       FROM nodes)
--)
  -- AND 
   count_cities = (SELECT count (DISTINCT point1)+1 
                                          FROM nodes)
--order by 2,1
