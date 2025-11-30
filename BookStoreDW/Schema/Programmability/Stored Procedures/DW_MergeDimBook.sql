CREATE PROCEDURE [dbo].[DW_MergeDimBook]
AS
BEGIN
	UPDATE dc
	SET [title]				= sc.[title]
	   ,[isbn13]			= sc.[isbn13]
	   ,[language_code]		= sc.[language_code]
	   ,[language_name]		= sc.[language_name]
	   ,[num_pages]			= sc.[num_pages]
	   ,[publication_date]	= sc.[publication_date]
	   ,[publisher_name]	= sc.[publisher_name]
	FROM [dbo].[DimBook]        dc
	INNER JOIN [staging].[book] sc ON (dc.[BookSK]=sc.[BookSK])
END
GO

