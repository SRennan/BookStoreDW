CREATE PROCEDURE [dbo].[DW_MergeDimCustomer]
AS
BEGIN

	UPDATE dc
	SET [first_name]	= sc.[first_name]
	   ,[last_name]		= sc.[last_name]
	   ,[email]			= sc.[email]
	   ,[street_name]	= sc.[street_name]
	   ,[street_number]	= sc.[street_number]
	   ,[city]			= sc.[city]
	   ,[address_status]= sc.[address_status]
	   ,[country_id]	= sc.[country_id]
	FROM [dbo].[DimCustomer]        dc
	INNER JOIN [staging].[customer] sc ON (dc.[CustomerSK]=sc.[CustomerSK])
END
GO

