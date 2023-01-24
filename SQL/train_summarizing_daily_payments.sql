SELECT
	pmt.pole_id,
	pmt.date_trans_start,
	SUM(pmt.trans_amt) AS total_payment 
	INTO parking.dbo.train_daily_payment_sums
  FROM [parking].[dbo].[train_payments] pmt
  GROUP BY pmt.date_trans_start, pmt.pole_id