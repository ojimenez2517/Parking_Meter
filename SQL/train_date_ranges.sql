/****** Script for SelectTopNRows command from SSMS  ******/
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