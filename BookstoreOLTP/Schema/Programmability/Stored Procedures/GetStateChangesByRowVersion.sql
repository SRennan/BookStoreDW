CREATE PROCEDURE [dbo].[GetStateChangesByRowVersion]
(
   @startRow BIGINT 
   ,@endRow  BIGINT 
)
AS
BEGIN
SELECT 
    t.order_id,
    s.status_value,      
    
    Status_dateKey = CONVERT(INT,
				(CONVERT(CHAR(4),DATEPART(YEAR,t.status_date))
				+ CASE 
					WHEN DATEPART(MONTH,t.status_date) < 10 THEN '0' + CONVERT(CHAR(1),DATEPART(MONTH,t.status_date))
					ELSE + CONVERT(CHAR(2),DATEPART(MONTH,t.status_date))
				END
				+ CASE 
					WHEN DATEPART(DAY,t.status_date) < 10 THEN '0' + CONVERT(CHAR(1),DATEPART(DAY,t.status_date))
					ELSE + CONVERT(CHAR(2),DATEPART(DAY,t.status_date))
				END))
    ,t.status_date
FROM (
    SELECT 
        history_id,
        order_id,
        status_id,
        status_date,
        rowversion,
        ROW_NUMBER() OVER (
            PARTITION BY order_id 
            ORDER BY status_date DESC
        ) AS rn
    FROM dbo.order_history
) AS t
INNER JOIN dbo.order_status AS s
    ON t.status_id = s.status_id
WHERE t.rn = 1
and (t.[rowversion] > CONVERT(ROWVERSION,@startRow) AND t.[rowversion] <= CONVERT(ROWVERSION,@endRow))


END
GO