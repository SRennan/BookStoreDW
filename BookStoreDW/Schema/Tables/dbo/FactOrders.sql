CREATE TABLE [dbo].[FactOrders](
	[line_id] [int] NOT NULL,
	[order_id] [int] NOT NULL,
	[AddressSK] [int] NOT NULL,
	[BookSK] [int] NOT NULL,
	[CustomerSK] [int] NOT NULL,
	[MethodSK] [int] NOT NULL,
	[StatusSK] [int] NOT NULL,
	[Order_dateKey] [int] NOT NULL,
	[order_date] [datetime] NULL,
	[quantity] [int] NOT NULL,
	[price] [decimal](5, 2) NOT NULL,
	[method_name] [varchar](100) NULL,
	[cost] [decimal](6, 2) NULL
);
GO

ALTER TABLE [dbo].[FactOrders] ADD CONSTRAINT PK_FactOrders PRIMARY KEY(line_id);
GO

ALTER TABLE [dbo].[FactOrders] ADD CONSTRAINT [FK_DimAddress] FOREIGN KEY([AddressSK]) REFERENCES [dbo].[DimAddress] ([AddressSK]);
GO

ALTER TABLE [dbo].[FactOrders] ADD CONSTRAINT [FK_DimBook] FOREIGN KEY([BookSK]) REFERENCES [dbo].[DimBook] ([BookSK]);
GO

ALTER TABLE [dbo].[FactOrders] ADD CONSTRAINT [FK_DimCustomer] FOREIGN KEY([CustomerSK]) REFERENCES [dbo].[DimCustomer] ([CustomerSK]);
GO

ALTER TABLE [dbo].[FactOrders] ADD CONSTRAINT [FK_DimMethod] FOREIGN KEY([MethodSK]) REFERENCES [dbo].[DimShippingMethod] ([MethodSK]);
GO

ALTER TABLE [dbo].[FactOrders] ADD CONSTRAINT [FK_DimStatus] FOREIGN KEY([StatusSK]) REFERENCES [dbo].[DimStatus] ([StatusSK]);
GO

ALTER TABLE [dbo].[FactOrders] ADD CONSTRAINT [FK_DimDate_OrderDate] FOREIGN KEY(Order_dateKey) REFERENCES [dbo].[DimDate] ([Datekey]);
GO
