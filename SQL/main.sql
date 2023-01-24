UPDATE parking.dbo.current_payments
SET date_trans_start = CONVERT(date, date_trans_start);
GO
SELECT
	pmt.pole_id,
	pmt.date_trans_start,
	SUM(pmt.trans_amt) AS total_payment 
	INTO parking.dbo.daily_payment_sums
  FROM [parking].[dbo].[current_payments] pmt
  GROUP BY pmt.date_trans_start, pmt.pole_id
GO
SELECT DATEADD(DAY, -7, date_requested) AS before_date
       ,date_requested
       ,DATEADD(DAY, 7, date_requested) AS after_date
	 ,service_request_id
	 ,pole
	 ,ZIP
	 ,service_name
	 ,lat_left
	 ,lng_left
	 ,comm_plan_name
	 ,case_age_days
	 INTO parking.dbo.new_requests_date_ranges
  FROM [parking].[dbo].new_requests
  WHERE YEAR(DATEADD(DAY, -7, date_requested)) = 2022 
	    AND YEAR(DATEADD(DAY, 7, date_requested)) = 2022
GO
SELECT rng.service_request_id
	  ,MAX(rng.ZIP) AS zip
	  ,MAX(rng.[service_name]) AS 'service_name'
	  ,MAX(rng.lat_left) AS lat
	  ,MAX(rng.lng_left) AS lng
	  ,MAX(rng.comm_plan_name) AS comm_plan_name
	  ,MAX(case_age_days) AS case_age_days
        ,COUNT(DISTINCT rng.pole) AS pole
	  ,SUM(pmt.total_payment) AS payment_before
	  INTO new_aggregated_data
  FROM [parking].[dbo].[new_requests_date_ranges] rng
  INNER JOIN [parking].[dbo].[daily_payment_sums] pmt ON rng.pole = pmt.pole_id
  WHERE pmt.date_trans_start BETWEEN rng.before_date AND rng.date_requested
  GROUP BY rng.service_request_id
GO
SELECT DATEADD(DAY, -7, date_closed) AS before_date
       ,date_closed
       ,DATEADD(DAY, 7, date_closed) AS after_date
	 ,service_request_id
	 ,pole
	 ,zipcode
	 ,[service_name]
	 ,lat_left
	 ,lng_left
	 ,comm_plan_name
	 ,case_age_days
	 INTO parking.dbo.train_requests_date_ranges
  FROM [parking].[dbo].train_requests
  WHERE YEAR(DATEADD(DAY, -7, date_closed)) = 2021 
	    AND YEAR(DATEADD(DAY, 7, date_closed)) = 2021
GO
SELECT
	pmt.pole_id,
	pmt.date_trans_start,
	SUM(pmt.trans_amt) AS total_payment 
	INTO parking.dbo.train_daily_payment_sums
  FROM [parking].[dbo].[train_payments] pmt
  GROUP BY pmt.date_trans_start, pmt.pole_id
GO
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
GO
UPDATE dbo.new_aggregated_data
SET payment_before = payment_before / 100
GO


