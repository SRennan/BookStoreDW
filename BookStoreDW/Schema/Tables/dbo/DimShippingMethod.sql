CREATE TABLE [dbo].[DimShippingMethod]
(
	[MethodSK] INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	[method_id] [int] NOT NULL,
	[method_name] [varchar](100) NULL,
	[cost] [decimal](6, 2) NULL,
)

