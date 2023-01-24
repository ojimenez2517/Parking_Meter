UPDATE parking.dbo.current_payments
SET date_trans_start = CONVERT(date, date_trans_start)