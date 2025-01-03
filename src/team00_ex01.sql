SELECT total_cost, 
       tour
  FROM tour_all_cities 
  WHERE strpos(tour,'A') = 2
  AND (total_cost = (SELECT MAX(total_cost) FROM tour_all_cities)
    OR total_cost = (SELECT MIN(total_cost) FROM tour_all_cities))
  ORDER BY total_cost, tour;  
