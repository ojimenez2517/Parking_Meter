/****** Script for SelectTopNRows command from SSMS  ******/
WITH before_tbl AS ( 
SELECT rng.service_request_id
	  ,MAX(rng.zipcode) AS zip
	  ,MAX(rng.[service_name]) AS 'service_name'
	  ,MAX(rng.lat_left) AS lat
	  ,MAX(rng.lng_left) AS lng
	  ,MAX(rng.comm_plan_name) AS comm_plan_name
	  ,MAX(case_age_days) AS case_age_days
      ,COUNT(DISTINCT rng.pole) AS pole
	  ,SUM(pmt.total_payment) AS payment_before
  FROM [parking].[dbo].[train_requests_date_ranges] rng
  INNER JOIN [parking].[dbo].[train_daily_payment_sums] pmt ON rng.pole = pmt.pole_id
  WHERE pmt.date_trans_start BETWEEN rng.before_date AND rng.date_closed
  GROUP BY rng.service_request_id),
after_tbl AS (
SELECT rng.service_request_id
	  ,SUM(pmt.total_payment) AS payment_after
  FROM [parking].[dbo].[train_requests_date_ranges] rng
  INNER JOIN [parking].[dbo].[train_daily_payment_sums] pmt ON rng.pole = pmt.pole_id
  WHERE pmt.date_trans_start BETWEEN rng.date_closed AND rng.after_date
  GROUP BY rng.service_request_id
)
SELECT b.service_request_id
	  ,b.zip
	  ,b.[service_name]
	  ,b.lat
	  ,b.lng
	  ,b.comm_plan_name
	  ,b.case_age_days
	  ,b.pole
	  ,b.payment_before
	  ,a.payment_after
	  ,a.payment_after - b.payment_before AS payment_diff
	  INTO parking.dbo.train_aggregated_data
FROM before_tbl b
INNER JOIN after_tbl a ON b.service_request_id = a.service_request_id