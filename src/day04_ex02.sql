CREATE VIEW v_generated_dates AS 
(SELECT da.date AS generated_date 
  FROM generate_series('2022-01-01'::DATE,'2022-01-31', '1 day') as da
ORDER BY 1
)

