CREATE TABLE [dbo].[FactOrders]
(
	
	order_id			INT NOT NULL,


    AddressSK           INT NOT NULL, 
	BookSK              INT NOT NULL,
	CustomerSK          INT NOT NULL,
	MethodSK            INT NOT NULL,
    StatusSK			INT NOT NULL,
		  
	Order_dateKey		INT NOT NULL,
	Status_dateKey		INT NOT NULL,




	order_date			datetime NULL,
	status_date			datetime NULL,
	
	quantity            INT NOT NULL DEFAULT(1),
	price               DECIMAL(5,2) NOT NULL

);
GO

ALTER TABLE [dbo].[FactOrders] ADD CONSTRAINT PK_FactOrders PRIMARY KEY(order_id);
GO



ALTER TABLE [dbo].[FactOrders] ADD CONSTRAINT [FK_DimDate_OrderDate] FOREIGN KEY(Order_dateKey) REFERENCES [dbo].[DimDate] ([Datekey]);
GO

ALTER TABLE [dbo].[FactOrders] ADD CONSTRAINT [FK_DimDate_StatusDate] FOREIGN KEY([Status_dateKey]) REFERENCES [dbo].[DimDate] ([Datekey]);
GO

ALTER TABLE [dbo].[FactOrders] ADD CONSTRAINT [FK_DimCustomer] FOREIGN KEY([CustomerSK]) REFERENCES [dbo].[DimCustomer] ([CustomerSK]);
GO

ALTER TABLE [dbo].[FactOrders] ADD CONSTRAINT [FK_DimBook] FOREIGN KEY([BookSK]) REFERENCES [dbo].[DimBook] ([BookSK]);
GO

ALTER TABLE [dbo].[FactOrders] ADD CONSTRAINT [FK_DimAddress] FOREIGN KEY([AddressSK]) REFERENCES [dbo].[DimAddress] ([AddressSK]);
GO

ALTER TABLE [dbo].[FactOrders] ADD CONSTRAINT [FK_DimMethod] FOREIGN KEY([MethodSK]) REFERENCES [dbo].[DimShippingMethod] ([MethodSK]);
GO
ALTER TABLE [dbo].[FactOrders] ADD CONSTRAINT [FK_DimStatus] FOREIGN KEY([StatusSK]) REFERENCES [dbo].[DimShippingMethod] ([StatusSK]);
GO




