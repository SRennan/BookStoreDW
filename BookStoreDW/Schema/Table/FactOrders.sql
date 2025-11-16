CREATE TABLE [dbo].[FactOrders]
(
	
	line_id				INT NOT NULL,
	order_id			INT NOT NULL,

	Order_dateKey		INT NOT NULL,
	Status_dateKey		INT NOT NULL,

    CustomerSK          INT NOT NULL,
    BookSK              INT NOT NULL,
    AddressSK           INT NOT NULL,        
    MethodSK            INT NOT NULL,
    order_status_key    INT NOT NULL,



	status_value		varchar	(20) NULL,
	order_date			datetime NULL,
	status_date			datetime NULL,

	[price] [decimal](5, 2) NULL,
);
GO

ALTER TABLE [dbo].[FactOrders] ADD CONSTRAINT PK_FactOrders PRIMARY KEY(line_id,order_id);
GO



ALTER TABLE [dbo].[FactOrders] ADD CONSTRAINT [FK_DimDate_OrderDate] FOREIGN KEY(Order_dateKey) REFERENCES [dbo].[DimDate] ([DateSK]);
GO

ALTER TABLE [dbo].[FactOrders] ADD CONSTRAINT [FK_DimDate_StatusDate] FOREIGN KEY([Status_dateKey]) REFERENCES [dbo].[DimDate] ([DateSK]);
GO

ALTER TABLE [dbo].[FactOrders] ADD CONSTRAINT [FK_DimCustomer] FOREIGN KEY([CustomerSK]) REFERENCES [dbo].[DimCustomer] ([CustomerSK]);
GO

ALTER TABLE [dbo].[FactOrders] ADD CONSTRAINT [FK_DimBook] FOREIGN KEY([BookSK]) REFERENCES [dbo].[DimBook] ([BookSK]);
GO

ALTER TABLE [dbo].[FactOrders] ADD CONSTRAINT [FK_DimAddress] FOREIGN KEY([AddressSK]) REFERENCES [dbo].[DimAddress] ([AddressSK]);
GO

ALTER TABLE [dbo].[FactOrders] ADD CONSTRAINT [FK_DimMethod] FOREIGN KEY([MethodSK]) REFERENCES [dbo].[DimShippingMethod] ([MethodSK]);
GO



