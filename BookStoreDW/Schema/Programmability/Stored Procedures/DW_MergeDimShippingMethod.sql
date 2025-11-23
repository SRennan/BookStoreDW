CREATE PROCEDURE [dbo].[DW_MergeDimShippingMethod]
AS
BEGIN

	UPDATE dc
	SET [method_name]	= sc.[method_name]
	   ,[cost]			= sc.[cost]

	FROM [dbo].[DimShippingMethod]        dc
	INNER JOIN [staging].[shippingMethod] sc ON (dc.[MethodSK]=sc.[MethodSK])
END
GO
