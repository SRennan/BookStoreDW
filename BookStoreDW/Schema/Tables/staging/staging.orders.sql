CREATE TABLE [staging].[orders](
	[order_id] [int] NOT NULL,
	[AddressSK] [int] NULL,
	[BookSK] [int] NULL,
	[CustomerSK] [int] NULL,
	[MethodSK] [int] NULL,
	[Order_dateKey] [int] NOT NULL,
	[order_date] [datetime] NULL,
	[quantity] [int] NOT NULL,
	[price] [decimal](5, 2) NOT NULL,
	[StatusSK] [int] NULL,
	[method_name] [varchar](100) NULL,
	[cost] [decimal](6, 2) NULL
)
