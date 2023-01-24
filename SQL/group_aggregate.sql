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