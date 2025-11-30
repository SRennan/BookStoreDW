CREATE PROCEDURE [dbo].[DW_MergeFactOrders]
AS
BEGIN

	UPDATE dc
	SET [AddressSK]			= sc.[AddressSK]
	   ,[BookSK]			= sc.[BookSK]
	   ,[CustomerSK]		= sc.[CustomerSK]
	   ,[MethodSK]			= sc.[MethodSK]
	   ,[Order_dateKey]		= sc.[Order_dateKey]
	   ,[order_date]		= sc.[order_date]
	   ,[quantity]			= sc.[quantity]
	   ,[price]				= sc.[price]
	   ,[method_name]		= sc.[method_name]
	   ,[cost]				= sc.[cost]
	FROM [dbo].[FactOrders]       dc
	INNER JOIN [staging].[orders] sc ON (dc.order_id=sc.order_id)
END

GO



