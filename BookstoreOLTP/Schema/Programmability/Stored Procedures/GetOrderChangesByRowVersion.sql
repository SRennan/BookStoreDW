CREATE PROCEDURE [dbo].[GetOrderChangesByRowVersion]
(
   @startRow BIGINT 
   ,@endRow  BIGINT 
)
AS
BEGIN


SELECT 
	 ord.line_id
	 ,order_id=ord.order_id
	,Address_id = ori.dest_address_id
	,Book_id= ord.[book_id]
	,Customer_id= ori.customer_id
	,Method_id =ori.shipping_method_id
	
	,OrderDateKey = CONVERT(INT,
				(CONVERT(CHAR(4),DATEPART(YEAR,ori.[order_date]))
				+ CASE 
					WHEN DATEPART(MONTH,ori.[order_date]) < 10 THEN '0' + CONVERT(CHAR(1),DATEPART(MONTH,ori.[order_date]))
					ELSE + CONVERT(CHAR(2),DATEPART(MONTH,ori.[order_date]))
				END
				+ CASE 
					WHEN DATEPART(DAY,ori.[order_date]) < 10 THEN '0' + CONVERT(CHAR(1),DATEPART(DAY,ori.[order_date]))
					ELSE + CONVERT(CHAR(2),DATEPART(DAY,ori.[order_date]))
				END))
	,ori.[order_date]
	,ord.[price]
	,smt.method_name
	,smt.cost

FROM [Bookstore].[dbo].[order_line] ord
INNER JOIN dbo.cust_order ori ON (ord.order_id = ori.order_id)
INNER JOIN dbo.shipping_method smt ON (ori.shipping_method_id = smt.method_id)


WHERE (ord.[rowversion] > CONVERT(ROWVERSION,@startRow) AND ord.[rowversion] <= CONVERT(ROWVERSION,@endRow))
	OR (ori.[rowversion] > CONVERT(ROWVERSION,@startRow) AND ori.[rowversion] <= CONVERT(ROWVERSION,@endRow))
	
    
    
END
GO
