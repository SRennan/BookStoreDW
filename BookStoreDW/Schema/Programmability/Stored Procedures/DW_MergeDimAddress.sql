CREATE PROCEDURE [dbo].[DW_MergeDimAddress]
AS
BEGIN

	UPDATE dc
	SET [street_name]	= sc.[street_name]
	   ,[street_number]	= sc.[street_number]
	   ,[city]			= sc.[city]
	   ,[country_name]	= sc.[country_name]
	   
	FROM [dbo].[DimAddress]        dc
	INNER JOIN [staging].[address] sc ON (dc.[AddressSK]=sc.[AddressSK])
END
GO

