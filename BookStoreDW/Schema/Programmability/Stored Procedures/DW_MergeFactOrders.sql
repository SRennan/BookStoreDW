CREATE PROCEDURE [dbo].[DW_MergeFactOrders]
AS
BEGIN

	UPDATE dc
	SET [AddressSK]			= sc.[AddressSK]
	   ,[BookSK]			= sc.[BookSK]
	   ,[CustomerSK]		= sc.[CustomerSK]
	   ,[MethodSK]			= sc.[MethodSK]
	   ,[StatusSK]			= sc.[StatusSK]
	   ,[Order_dateKey]		= sc.[Order_dateKey]
	   ,[Status_dateKey]	= sc.[Status_dateKey]
	   ,[order_date]		= sc.[order_date]
	   ,[status_date]		= sc.[status_date]
	   ,[quantity]			= sc.[quantity]
	   ,[price]				= sc.[price]
	FROM [dbo].[FactOrders]       dc
	INNER JOIN [staging].[orders] sc ON (dc.order_id=sc.order_id)
END
GO



