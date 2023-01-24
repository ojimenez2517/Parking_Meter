/****** Script for SelectTopNRows command from SSMS  ******/
SELECT
	pmt.pole_id,
	pmt.date_trans_start,
	SUM(pmt.trans_amt) AS total_payment 
	INTO parking.dbo.daily_payment_sums
  FROM [parking].[dbo].[current_payments] pmt
  GROUP BY pmt.date_trans_start, pmt.pole_id
