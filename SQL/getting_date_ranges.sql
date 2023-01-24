/****** Script for SelectTopNRows command from SSMS  ******/
SELECT DATEADD(DAY, -7, date_requested) AS before_date
      ,date_requested
      ,DATEADD(DAY, 7, date_requested) AS after_date
	  ,service_request_id
	  ,pole
	  INTO parking.dbo.new_requests_date_ranges
  FROM [parking].[dbo].new_requests
  WHERE YEAR(DATEADD(DAY, -7, date_requested)) = 2022 
	    AND YEAR(DATEADD(DAY, 7, date_requested)) = 2022