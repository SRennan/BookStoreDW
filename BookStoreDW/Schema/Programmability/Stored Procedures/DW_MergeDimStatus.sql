CREATE PROCEDURE [dbo].[DW_MergeDimStatus]
AS
BEGIN

	UPDATE dc
	SET		
			[status_value] =   sc.[status_value]
            ,[Status_dateKey]= sc.[Status_dateKey]
            ,[status_date]= sc.[status_date]
	FROM [dbo].[DimStatus]        dc
	INNER JOIN [staging].status sc ON (dc.[StatusSK]=sc.[StatusSK])
END
GO

	