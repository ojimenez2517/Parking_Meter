/****** Script for SelectTopNRows command from SSMS  ******/
UPDATE dbo.train_aggregated_data
SET payment_before = payment_before / 100
   ,payment_after = payment_after / 100