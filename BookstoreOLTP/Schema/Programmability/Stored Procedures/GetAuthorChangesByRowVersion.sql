CREATE PROCEDURE [dbo].[GetAuthorChangesByRowVersion]
(
   @startRow BIGINT 
   ,@endRow  BIGINT 
)
AS
BEGIN

 SELECT     b.[author_id]
            ,b.[author_name]
    FROM [dbo].[author] b
    WHERE (b.[rowversion] > CONVERT(ROWVERSION,@startRow) AND b.[rowversion] <= CONVERT(ROWVERSION,@endRow))
  
END
GO